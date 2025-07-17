package com.hy.controller.qna;

import java.io.IOException;
import java.util.List;

import com.hy.dto.qna.Qna;
import com.hy.dto.qna.QnaReply;
import com.hy.service.qna.QnaAdminService;
import com.hy.service.qna.QnaService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/qna/detail/Admin")
public class QnaDetailAdminServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	private QnaAdminService qnaAdminService = new QnaAdminService();
	private QnaService qnaService = new QnaService();

    public QnaDetailAdminServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
        // 파라미터 받기
        String qnaId = request.getParameter("no");
        if (qnaId == null || qnaId.isEmpty()) {
            // 파라미터 없으면 에러 처리 or 목록으로 이동
            response.sendRedirect("/qna/list/admin");
            return;
        }
        
        // 문의글 내용 조회
        int qnaNo = Integer.parseInt(qnaId);
        Qna qna = qnaService.selectQnaOne(qnaNo);
        
        // QnA 상세 데이터, 답글(댓글) 리스트 조회
        List<QnaReply> replyList = qnaAdminService.selectReplyList(qnaNo);

        // JSP에서 사용할 데이터 저장
        request.setAttribute("qna", qna);
        request.setAttribute("replyList", replyList);

        // 관리자용 상세 JSP로 포워드
        request.getRequestDispatcher("/views/qna/qnaDetailAdmin.jsp").forward(request, response);
	
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
