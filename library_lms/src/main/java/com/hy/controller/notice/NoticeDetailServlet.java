package com.hy.controller.notice;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

import com.hy.dto.notice.Notice;
import com.hy.dto.notice.NoticeAttach;
import com.hy.service.notice.NoticeService;

/**
 * Servlet implementation class NoticeDetailServlet
 */
@WebServlet("/notice/detail")
public class NoticeDetailServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	NoticeService service = new NoticeService();
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public NoticeDetailServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int noticeId = Integer.parseInt(request.getParameter("no"));
		System.out.println(noticeId);
		
		Notice notice = service.selectNoticeByNo(noticeId);
		NoticeAttach attach = service.selectAttachByNo(noticeId);
		
		request.setAttribute("notice", notice);
		request.setAttribute("attach", attach);
		
		System.out.println(attach);
		
		request.getRequestDispatcher("/views/notice/noticeDetailPage.jsp").forward(request, response);
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

import com.hy.dto.Member;
import com.hy.dto.notice.Notice;
import com.hy.dto.notice.NoticeAttach;
import com.hy.service.notice.NoticeService;

/**
 * Servlet implementation class NoticeDetailServlet
 */
@WebServlet("/notice/detail")
public class NoticeDetailServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	NoticeService service = new NoticeService();
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public NoticeDetailServlet() {
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
			}
		}
		request.setAttribute("memberNo", memberNo);
		
		
		int noticeId = Integer.parseInt(request.getParameter("no"));
		
		Notice notice = service.selectNoticeByNo(noticeId);
		NoticeAttach attach = service.selectAttachByNo(noticeId);
		request.setAttribute("notice", notice);
		request.setAttribute("attach", attach);
		
		int result = service.updateViewCount(noticeId);
		if (result > 0) {
			request.getRequestDispatcher("/views/notice/noticeDetailPage.jsp").forward(request, response);			
		}

	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
