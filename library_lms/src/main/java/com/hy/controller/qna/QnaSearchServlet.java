package com.hy.controller.qna;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/qnaSearch")
public class QnaSearchServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public QnaSearchServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String searchBy = request.getParameter("searchBy");
		String keyword = request.getParameter("keyword");
		
		
		// 시험 출력
//		System.out.println(searchBy);
//		System.out.println(keyword);
//		response.setContentType("text/html; charset=UTF-8");
//		response.getWriter().print(searchBy);
//		response.getWriter().print(keyword);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
