package com.hy.controller.qna;

import java.io.IOException;

import com.hy.dto.qna.Attach;
import com.hy.dto.qna.Qna;
import com.hy.service.qna.QnaService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/qna/detail")
public class QnaDetailServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private QnaService qnaService = new QnaService();
       
    public QnaDetailServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		
		
		// 1. no라는 이름의 게시글 pk값 전달받기
		int qnaId = Integer.parseInt(request.getParameter("no"));
		
		// 2. Qna와 Attach 조회
		Qna qna = qnaService.selectQnaOne(qnaId);
		Attach attach = qnaService.selectAttachByQnaNo(qnaId);
		System.out.println("attach : "+attach);
		
		// 조회수 올리기
		qnaService.updateViewCount(qnaId);
		
		request.setAttribute("qna", qna);
		request.setAttribute("attach", attach);
		request.getRequestDispatcher("/views/qna/detail.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
