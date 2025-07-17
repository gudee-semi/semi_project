package com.hy.controller.qna;

import java.io.IOException;
import java.time.LocalDateTime;

import com.hy.dto.qna.QnaReply;
import com.hy.service.qna.QnaAdminService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/qna/reply/admin/insert")
public class QnaReplyInsertAdminServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private QnaAdminService qnaAdminService = new QnaAdminService();

	public QnaReplyInsertAdminServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ")
				.append(request.getContextPath());
	}

	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {

		// 파라미터 받기
		String qnaIdStr = request.getParameter("qnaId");
		
		if (qnaIdStr == null || qnaIdStr.isEmpty()) {
			// 파라미터 누락 시 목록으로 리다이렉트 또는 에러 처리
			response.sendRedirect(request.getContextPath() + "/qna/list/admin");
			return;
		}
		int qnaNo = Integer.parseInt(qnaIdStr);

		String content = request.getParameter("content");

		// DTO 생성 및 값 세팅 (댓글 번호는 DB에서 자동 생성)
		QnaReply reply = new QnaReply();
		reply.setQnaId(qnaNo);
		reply.setContent(content);

		// Service 호출하여 댓글 등록
		qnaAdminService.insertReply(reply);

		// 등록 후 상세페이지로 리다이렉트
		response.sendRedirect(request.getContextPath()+ "/qna/detail/admin?qnaId=" + qnaNo);
	}
}
