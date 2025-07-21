package com.hy.controller.qna;

import java.io.IOException;

import com.hy.dto.qna.QnaReply;
import com.hy.service.qna.QnaAdminService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/qna/reply/admin/edit")
public class QnaReplyEditAdminServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	private QnaAdminService qnaAdminService = new QnaAdminService();

    public QnaReplyEditAdminServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		// replyId 파라미터 받기
        String replyId = request.getParameter("qnaReplyId");
        
        if(replyId == null || replyId.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/qna/list/admin");
            return;
        }
        int replyNo = Integer.parseInt(replyId);

        // 해당 댓글 조회
        QnaReply reply = qnaAdminService.selectReplyOne(replyNo);

        // (중요!) reply가 null 또는 값이 없는 경우도 체크!
        if(reply == null) {
            response.sendRedirect(request.getContextPath() + "/");
            return;
        }
        
        // JSP로 전달
        request.setAttribute("reply", reply);
        request.getRequestDispatcher("/views/qna/qnaReplyEditAdmin.jsp").forward(request, response);
    }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
