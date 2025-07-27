package com.hy.controller.notice;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;

import org.apache.commons.io.FilenameUtils;
import org.json.simple.JSONObject;

import com.hy.dto.notice.Notice;
import com.hy.dto.notice.NoticeAttach;
import com.hy.service.notice.NoticeAttachService;
import com.hy.service.notice.NoticeService;

/**
 * Servlet implementation class NoticeWriteServlet
 */
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024,
        maxFileSize = 1024 * 1024 * 5,
        maxRequestSize = 1024 * 1024 * 20
)
@WebServlet("/notice/write")
public class NoticeWriteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private NoticeService noticeService = new NoticeService();
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public NoticeWriteServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.getRequestDispatcher("/views/notice/noticeWritePage.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		
		String title = request.getParameter("title");
		String content = request.getParameter("content");
		String category = request.getParameter("category");
		
		Notice notice = new Notice();
		notice.setTitle(title);
		notice.setContent(content);
		notice.setCategory(category);
		
		File uploadDir = NoticeAttachService.getUploadDirectory();
		NoticeAttach attach = NoticeAttachService.handleUploadFile(request, uploadDir);
		String ext = "pass";
		if (attach != null) {
			int loc = attach.getOriName().lastIndexOf(".");
			ext = attach.getOriName().substring(loc + 1);			
		}
		
		int result = -1;
		
		if (ext.equals("png") || ext.equals("jpg") || ext.equals("pass")) {
			if ("CODE_REJECT_BAD_WORD".equals(title) || "CODE_REJECT_BAD_WORD".equals(content)) {
				result = -2;
			} else {
				result = noticeService.createNoticeWithAttach(notice, attach);						
			}
		}
		
		
		JSONObject obj = new JSONObject();
		
		if (result > 0) {
			obj.put("res_code", "200");
		} else if (result == 0) {
			obj.put("res_code", "500");			
		} else if (result == -1) {
			obj.put("res_code", "999");
		} else {
			obj.put("res_code", "998");
		}
		
		response.setContentType("application/json; charset=UTF-8");
		PrintWriter out = response.getWriter();
		out.print(obj);
		
	}

}
