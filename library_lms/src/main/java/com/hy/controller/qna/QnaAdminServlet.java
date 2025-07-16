package com.hy.controller.qna;

import java.io.IOException;
import java.util.List;

import com.hy.dto.Member;
import com.hy.dto.qna.QnaAdmin;
import com.hy.service.qna.QnaAdminService;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/qna/view/admin")
public class QnaAdminServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	private QnaAdminService qnaAdminService = new QnaAdminService();

    public QnaAdminServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		// 세션에서 Member 객체 꺼내기 (안전하게 null 체크)
        HttpSession session = request.getSession(false);
        if (session == null) {
            response.sendRedirect(request.getContextPath() + "/login/view");
            return;
        }
        
        Member loginMember = (Member) session.getAttribute("loginMember");
        if (loginMember == null) {
            response.sendRedirect(request.getContextPath() + "/login/view");
            return;
        }
        
        int memberNo = loginMember.getMemberNo();
		
		// 게시글 목록 조회
		List<QnaAdmin> qnaList = qnaAdminService.selectAll();
		
		// JSP에서 사용할 데이터 저장
		request.setAttribute("qnaList", qnaList);
		
		// JSP로 포워드
		RequestDispatcher dispatcher = request.getRequestDispatcher("/views/qna/qnaAdmin.jsp");
		dispatcher.forward(request, response);
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
