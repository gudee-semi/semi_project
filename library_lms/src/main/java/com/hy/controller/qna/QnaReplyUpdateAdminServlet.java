package com.hy.controller.qna;

import java.io.IOException;

import com.hy.dto.qna.QnaReply;
import com.hy.service.qna.QnaAdminService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/qna/reply/admin/update")
public class QnaReplyUpdateAdminServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	private QnaAdminService qnaAdminService = new QnaAdminService();

    public QnaReplyUpdateAdminServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
        request.setCharacterEncoding("UTF-8");
        
        String replyIdStr = request.getParameter("qnaReplyId");
        String qnaIdStr = request.getParameter("qnaId");
        
        if (replyIdStr == null || replyIdStr.isEmpty() ||
                qnaIdStr == null || qnaIdStr.isEmpty()) {
                // 값이 비었으면 에러/리다이렉트
                response.sendRedirect(request.getContextPath() + "/qna/list/admin");
                return;
            }

        // 1. 파라미터 받기
        int replyId = Integer.parseInt(request.getParameter("qnaReplyId"));
        int qnaId   = Integer.parseInt(request.getParameter("qnaId"));
        String content = request.getParameter("content");

        // 2. DTO 생성 및 값 세팅
        QnaReply reply = new QnaReply();
        reply.setQnaReplyId(replyId);
        reply.setQnaId(qnaId);
        reply.setContent(content);

        // 3. 서비스 호출하여 수정
        qnaAdminService.updateReply(reply);

        // 4. 상세 페이지로 리다이렉트
        response.sendRedirect(request.getContextPath()+ "/qna/detail/admin?qnaId=" + qnaId);
        
	}

}
