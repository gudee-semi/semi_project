package com.hy.controller.qna;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/qna/reply/write")
public class QnaReplyWriteAdminServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public QnaReplyWriteAdminServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
        String qnaIdStr = request.getParameter("qnaId");
        String content = request.getParameter("content");
        int qnaId = Integer.parseInt(qnaIdStr);

        // (로그인 관리자라면 세션에서 adminId 등도 받을 수 있음)
        // 답글 등록 서비스 호출
        // qnaAdminService.insertReply(qnaId, content, adminId);

        // 등록 후 다시 상세로 리다이렉트
        response.sendRedirect("/qna/detailAdmin?no=" + qnaId);
	}

}
