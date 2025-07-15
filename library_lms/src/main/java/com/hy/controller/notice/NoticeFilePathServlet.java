package com.hy.controller.notice;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;

import com.hy.dto.notice.NoticeAttach;
import com.hy.service.notice.NoticeService;

/**
 * Servlet implementation class NoticeFilePathServlet
 */
@WebServlet("/notice/filePath")
public class NoticeFilePathServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private NoticeService service = new NoticeService();
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public NoticeFilePathServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int noticeAttachId = Integer.parseInt(request.getParameter("id"));
		NoticeAttach attach = service.selectAttachByNo(noticeAttachId);
		
		String filePath = "C:\\upload\\notice\\" + attach.getReName();
		
		if (filePath == null || filePath.trim().equals("")) {
			response.sendError(HttpServletResponse.SC_BAD_REQUEST);
			return;
		}
		
		File file = new File(filePath);
		if (!file.exists()) {
			response.sendError(HttpServletResponse.SC_NOT_FOUND);
			return;
		}
		
		String mimeType = getServletContext().getMimeType(filePath);
		if (mimeType == null) mimeType = "application/octet-stream";
		response.setContentType(mimeType);
		
		try (FileInputStream fis = new FileInputStream(file); OutputStream out = response.getOutputStream();) {
			byte[] buffer = new byte[1024];
			int byteRead;
			while ((byteRead = fis.read(buffer)) != -1) {
				out.write(buffer, 0, byteRead);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
