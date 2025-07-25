package com.hy.controller.main;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

import com.hy.dto.notice.Notice;
import com.hy.dto.qna.Qna;
import com.hy.service.notice.NoticeService;
import com.hy.service.qna.QnaService;

/**
 * Servlet implementation class MainPageDataServlet
 */
@WebServlet("/main")
public class MainPageDataServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private NoticeService noticeService = new NoticeService();
	private QnaService qnaService = new QnaService();
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public MainPageDataServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		List<Notice> noticeList = noticeService.selectNoticeMain();
		List<Qna> qnaList = qnaService.selectQnaMain();
		
		request.setAttribute("noticeList", noticeList);
		request.setAttribute("qnaList", qnaList);
		request.getRequestDispatcher("/views/login/mainPage.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
