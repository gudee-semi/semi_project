package com.hy.controller.qna;

import java.io.IOException;

import com.hy.service.qna.QnaAdminService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/qna/reply/admin/delete")
public class QnaReplyDeleteAdminServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private QnaAdminService qnaAdminService = new QnaAdminService();

	public QnaReplyDeleteAdminServlet() {
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

		// 1. 삭제할 답글 ID 파라미터 받기
		String replyIdStr = request.getParameter("qnaReplyId");
		String qnaIdStr = request.getParameter("qnaId"); // 삭제 후 돌아갈 원글 번호

		// 파라미터 체크 (비었을 때 안전처리)
		if (replyIdStr == null || replyIdStr.isEmpty() || qnaIdStr == null
				|| qnaIdStr.isEmpty()) {
			response.sendRedirect(request.getContextPath() + "/qna/list/admin");
			return;
		}

		int replyId = Integer.parseInt(replyIdStr);
		int qnaId = Integer.parseInt(qnaIdStr);

		// 2. 서비스 계층에서 삭제
		qnaAdminService.deleteReply(replyId);

		// 3. 원글 상세페이지로 리다이렉트
		response.sendRedirect(request.getContextPath() + "/qna/detail/admin?qnaId=" + qnaId);
	}

}
