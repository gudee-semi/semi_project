package com.hy.controller.qna;

import java.io.IOException;

import com.hy.dto.qna.QnaAdmin;
import com.hy.service.qna.QnaAdminService;
import com.hy.service.qna.QnaService;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/qna/detail/Admin")
public class QnaDetailAdminServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	private QnaAdminService qnaAdminService = new QnaAdminService();

    public QnaDetailAdminServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
        // 파라미터 받기 (qnaId 또는 no)
        String noStr = request.getParameter("no");
        int qnaId = 0;
        if (noStr != null && !noStr.isEmpty()) {
            qnaId = Integer.parseInt(noStr);
        } else {
            // 파라미터 없으면 에러 처리 or 목록으로 이동
            response.sendRedirect("/qna/view");
            return;
        }
        
        // 문의글 내용 조회
        QnaAdmin qna = Integer.par.selectQnaOne("qnaNo");
        
        // QnA 상세 데이터, 답글(댓글) 리스트 조회
        QnaAdmin replyList = qnaAdminService.selectReplyOne(qnaId);

        // JSP에서 사용할 데이터 저장
        request.setAttribute("qnaAdminList", qna);
        request.setAttribute("replyList", replyList);

        // 관리자용 상세 JSP로 포워드
        RequestDispatcher dispatcher = request.getRequestDispatcher("/views/qna/qnaDetailAdmin.jsp");
        dispatcher.forward(request, response);
	
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
