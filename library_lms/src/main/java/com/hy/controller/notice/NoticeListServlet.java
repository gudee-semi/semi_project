package com.hy.controller.notice;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

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
		int memberNo = 3; // 사용자
		// int memberNo = 1; // 관리자
		request.setAttribute("memberNo", memberNo);
		
		Notice param = new Notice();
		
		int nowPage = 1;
		String nowPageStr = request.getParameter("nowPage");
		if (nowPageStr != null) nowPage = Integer.parseInt(nowPageStr);
		param.setNowPage(nowPage);
		
		
		String category = request.getParameter("category");
		String keyword = request.getParameter("keyword");
		System.out.println(category + " " + keyword);
		param.setSearchCategory(category);
		param.setKeyword(keyword);
		
		int totalData = service.selectNoticeCount(param);
		param.setTotalData(totalData);
		
		List<Notice> noticeList = service.selectNoticeList(param);
		for (Notice n : noticeList) System.out.println(n);
		
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
