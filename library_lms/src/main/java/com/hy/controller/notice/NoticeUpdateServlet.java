package com.hy.controller.notice;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;

import org.json.simple.JSONObject;

import com.hy.dto.Member;
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
	private NoticeService noticeService = new NoticeService();
       
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
		
		HttpSession session = request.getSession(false);
		int memberNo = 0; // 여기는 세선에서 값을 가져오도록!!
		
		if (session == null) {
			response.sendRedirect(request.getContentType() + "/");
			return;
		} else {
			if (session.getAttribute("loginMember") == null) {
				response.sendRedirect(request.getContextPath() + "/");
				return;
			} else {
				Member member = (Member)session.getAttribute("loginMember");
				memberNo = member.getMemberNo();
				if (memberNo != 1) {
					response.sendRedirect(request.getContextPath() + "/views/error/403.jsp");
				} else {
						int noticeId = Integer.parseInt(request.getParameter("id"));
						
						Notice notice = noticeService.selectNoticeByNo(noticeId);
						NoticeAttach attach = noticeService.selectAttachByNo(noticeId);
						
						request.setAttribute("notice", notice);
						request.setAttribute("attach", attach);
						
						request.getRequestDispatcher("/views/notice/noticeUpdatePage.jsp").forward(request, response);					
				}
			}
		}
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		
		String title = request.getParameter("title");
		String content = request.getParameter("content");
		String category = request.getParameter("category");
		int noticeId = Integer.parseInt(request.getParameter("id"));
		int check =  Integer.parseInt(request.getParameter("check"));
		
		Notice notice = new Notice();
		notice.setNoticeId(noticeId);
		notice.setTitle(title);
		notice.setContent(content);
		notice.setCategory(category);
		
		File uploadDir = NoticeAttachService.getUploadDirectory();
		NoticeAttach attach = NoticeAttachService.handleUploadFile(request, uploadDir);
		
		int result = 0;
		
		if ("CODE_REJECT_BAD_WORD".equals(title) || "CODE_REJECT_BAD_WORD".equals(content)) {
			result = -1;
		} else {
			if (attach != null) {
				attach.setNoticeId(noticeId);
				if (check == 2) {
					// 공지사항이 없는 게시물에 새롭게 첨부파일이 들어온 경우
					result = noticeService.updateNoticeNewAttach(notice, attach);
				} else {
					// 공지사항 수정과 더불어 첨부파일이 새롭게 업데이트 된 경우
					result = noticeService.updateNoticeWithAttach(notice, attach);				
				}
			} else {
				if (check == 1) {
					// 공지사항 수정과 더불어 첨부파일을 삭제한 경우
					result = noticeService.updateNoticeDeleteAttach(notice);
				} else if (check == 0 || check == 2) {
					// 공지사항 수정과 더불어 첨부파일을 유지하는 경우, 또는 첨부파일이 없는 게시물인 경우
					result = noticeService.updateNoticeSameAttach(notice);
				}
			}			
		}
		
		JSONObject obj = new JSONObject();
		
		if (result > 0) {
			obj.put("res_code", "200");
		} else if (result == 0) {
			obj.put("res_code", "500");			
		} else {
			obj.put("res_code", "998");		
		}
		
		response.setContentType("application/json; charset=UTF-8");
		PrintWriter out = response.getWriter();
		out.print(obj);
		
		
	}

}
