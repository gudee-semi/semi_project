package com.hy.controller.qna;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

import com.hy.service.qna.QnaService;

@WebServlet("/qna/delete")
public class QnaDeleteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private QnaService qnaService = new QnaService();
       
    public QnaDeleteServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int qnaId = Integer.parseInt(request.getParameter("no"));
		
		int result = qnaService.deleteQna(qnaId);
		
		if(result > 0) {
			response.sendRedirect("/qna/view");
		} else {
			response.sendRedirect("/qna/detail");
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
