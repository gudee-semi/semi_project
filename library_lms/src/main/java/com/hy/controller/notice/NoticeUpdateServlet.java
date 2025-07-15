package com.hy.controller.notice;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.File;
import java.io.IOException;

import com.hy.dto.notice.Notice;
import com.hy.dto.notice.NoticeAttach;
import com.hy.service.notice.NoticeAttachService;
import com.hy.service.notice.NoticeService;

/**
 * Servlet implementation class NoticeUpdateServlet
 */
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024,
        maxFileSize = 1024 * 1024 * 5,
        maxRequestSize = 1024 * 1024 * 20
)
@WebServlet("/notice/update")
public class NoticeUpdateServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private NoticeService service = new NoticeService();
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public NoticeUpdateServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int noticeId = Integer.parseInt(request.getParameter("id"));
		
		Notice notice = service.selectNoticeByNo(noticeId);
		NoticeAttach attach = service.selectAttachByNo(noticeId);
		
		request.setAttribute("notice", notice);
		request.setAttribute("attach", attach);
		
		request.getRequestDispatcher("/views/notice/noticeUpdatePage.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		
		String title = request.getParameter("title");
		String content = request.getParameter("content");
		String category = request.getParameter("category");
		int check =  Integer.parseInt(request.getParameter("check"));
		
		Notice notice = new Notice();
		notice.setTitle(title);
		notice.setContent(content);
		notice.setCategory(category);
		
		File uploadDir = NoticeAttachService.getUploadDirectory();
		NoticeAttach attach = NoticeAttachService.handleUploadFile(request, uploadDir);
		
		int result = 0;
		
		if (attach != null) {
			// 첨부파일이 업데이트 된 경우
			result = 
		} else {
			if (check == 1) {
				// 첨부파일을 삭제한 경우
			} else if (check == 0) {
				// 첨부파일을 유지하는 경우
			}
		}
		
		
	}

}
