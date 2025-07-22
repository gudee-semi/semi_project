package com.hy.controller.qna;

import java.io.IOException;
import java.util.List;

import com.hy.dto.qna.QnaReply;
import com.hy.service.qna.QnaAdminService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/qna/list/admin")
public class QnaListAdminServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private QnaAdminService qnaAdminService = new QnaAdminService();

	public QnaListAdminServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		
	    // 1. 검색 파라미터 받기 (category, keyword, searchType)
	    String category = request.getParameter("category");
	    String keyword = request.getParameter("keyword");
	    String searchType = request.getParameter("searchType");	    

	    // Service로 검색 조건 전달해서 결과 조회
	    List<QnaReply> qnaAdminList = qnaAdminService.selectAll(category, keyword, searchType);

		// 조회한 리스트를 request 영역에 저장 (JSP에서 사용 가능)
		request.setAttribute("qnaAdminList", qnaAdminList);

		// qnalistadmin.jsp로 포워딩 (화면 전환)
		request.getRequestDispatcher("/views/qna/qnaListAdmin.jsp").forward(request, response);

	}

	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);

	}

}
