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

    // 1. QnA 목록 데이터 조회 (Service 호출)
    List<QnaAdmin> qnaAdminList = qnaAdminService.selectAll();

    // 2. 조회한 리스트를 request 영역에 저장 (JSP에서 사용 가능)
    request.setAttribute("qnaAdminList", qnaAdminList);

    // 3. qnalistadmin.jsp로 포워딩 (화면 전환)
    RequestDispatcher dispatcher = request.getRequestDispatcher("/views/qna/qnaListAdmin.jsp");
    dispatcher.forward(request, response);
		
	}

  // POST : 답글 등록
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);

	}

}
