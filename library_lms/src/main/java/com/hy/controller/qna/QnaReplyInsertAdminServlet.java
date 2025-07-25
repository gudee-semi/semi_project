package com.hy.controller.qna;

import java.io.IOException;

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

		// 1. 파라미터 받기
	    String qnaId = request.getParameter("qnaId");
	    String content = request.getParameter("content");

	    // 2. 파라미터가 없거나 빈 값이면 메인 페이지로 이동
	    if (qnaId == null || qnaId.isEmpty() || content == null || content.isEmpty()) {
	        response.sendRedirect("/qna/detail/admin");
	        return;
	    }

	    // 3. qnaId를 int로 변환
	    int qnaNo = Integer.parseInt(qnaId);

	    // 4. DTO 생성 및 값 세팅
	    QnaReply reply = new QnaReply();
	    reply.setQnaId(qnaNo);      // 댓글이 달리는 QnA 번호!
	    reply.setContent(content);  // 댓글 내용

	    // 5. Service 호출하여 댓글 등록 (댓글 번호는 DB에서 자동 생성)
	    qnaAdminService.insertReplyAndUpdateStatus(reply);

	    // 6. 등록 후 상세페이지로 리다이렉트
	    response.sendRedirect(request.getContextPath() + "/qna/detail/admin?qnaId=" + qnaNo);
	    
	}
}
