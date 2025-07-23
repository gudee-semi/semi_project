package com.hy.controller.qna;

import java.io.IOException;
import java.util.List;

import com.hy.dto.qna.Attach;
import com.hy.dto.qna.Qna;
import com.hy.dto.qna.QnaReply;
import com.hy.service.qna.QnaAdminService;
import com.hy.service.qna.QnaService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/qna/detail/admin")
public class QnaDetailAdminServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;	

    private QnaService   qnaService      = new QnaService();      
    private QnaAdminService qnaAdminService = new QnaAdminService(); // 답글·조회수용

    public QnaDetailAdminServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		// QnA ID 파라미터 받기
		String qnaId = request.getParameter("qnaId");

		// 파라미터가 없거나 빈 값이면 메인 페이지로 이동 (에러 처리)
		if (qnaId == null || qnaId.isEmpty()) {
		    response.sendRedirect("/");
		    return;
		}

		// 파라미터 값을 int로 변환
		int qnaNo = Integer.parseInt(qnaId);

		// QnA 상세 데이터 조회 (Service/DAO 호출)
		Qna qna = qnaService.selectQnaOne(qnaNo);		
		
		// 파일첨부
		Attach attach = qnaAdminService.getAttach(qnaNo);
		
		// 조회수 증가
	    qnaAdminService.incrementViewCount(qnaNo);

		// 해당 QnA에 대한 답글(댓글) 리스트 조회
		List<QnaReply> replyList = qnaAdminService.selectReplyList(qnaNo);

		// JSP에서 사용할 데이터 저장 (request 영역)
		request.setAttribute("qna", qna);
		request.setAttribute("replyList", replyList);
		request.setAttribute("attach", attach);

		// 관리자용 QnA 상세 JSP로 포워드
		request.getRequestDispatcher("/views/qna/qnaDetailAdmin.jsp").forward(request, response);                
	
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
