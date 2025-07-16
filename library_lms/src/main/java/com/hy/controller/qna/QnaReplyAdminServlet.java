package com.hy.controller.qna;

import java.io.IOException;

import com.hy.service.qna.QnaAdminService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/qna/reqlyAdmin")
public class QnaReplyAdminServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	private QnaAdminService qnaAdminService = new QnaAdminService();

    public QnaReplyAdminServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
        int qnaId = Integer.parseInt(request.getParameter("qnaId"));
        String content = request.getParameter("content");
        // 관리자 정보(세션 등)도 필요하면 받아서 처리

        // 답글 등록
        qnaAdminService.insertReply(qnaId, content);

        // 답글 등록 후 관리자 상세로 리다이렉트
        response.sendRedirect("/qna/detailAdmin?no=" + qnaId);
	}

}
