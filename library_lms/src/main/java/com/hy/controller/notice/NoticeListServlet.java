package com.hy.controller.notice;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

import com.hy.dto.Member;
import com.hy.dto.notice.Notice;
import com.hy.service.notice.NoticeService;

/**
 * Servlet implementation class NoticeListServlet
 */
@WebServlet("/notice/list")
public class NoticeListServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private NoticeService service = new NoticeService();
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public NoticeListServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 추후 세션에서 가져오기
		// int memberNo = 1; // 관리자
		
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
		
		Notice param = new Notice();
		
		int nowPage = 1;
		String nowPageStr = request.getParameter("nowPage");
		if (nowPageStr != null) nowPage = Integer.parseInt(nowPageStr);
		param.setNowPage(nowPage);
		
		
		String category = request.getParameter("category");
		String keyword = request.getParameter("keyword");
		param.setSearchCategory(category);
		param.setKeyword(keyword);
		
		int totalData = service.selectNoticeCount(param);
		param.setTotalData(totalData);
		int totaldata = param.getTotalData();
		
		List<Notice> noticeList = service.selectNoticeList(param);
		
		request.setAttribute("totaldata", totaldata);
		request.setAttribute("paging", param);
		request.setAttribute("noticeList", noticeList);
		
		request.getRequestDispatcher("/views/notice/noticeListPage.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
