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
	
	//서비스 객체 생성
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

    // ★ 여기! qnaId 파싱(안전 가드) 넣는 자리
    String idStr = request.getParameter("qnaId");   // 또는 no, idx 등
    if (idStr == null || idStr.isEmpty()) {         // 없으면 목록으로
        response.sendRedirect(request.getContextPath() + "/qna/list/admin");
        return;
    }
    int qnaId = Integer.parseInt(idStr);            // 안전하게 int 변환 완료

    // 질문 + 답글 목록 조회
    QnaAdmin reply = qnaAdminService.selectReplyOne(qnaId);
    request.setAttribute("reply", reply);

    // JSP 포워드
    RequestDispatcher rd = request.getRequestDispatcher("/views/qna/detailAdmin.jsp");
    rd.forward(request, response);
		
	}

  // POST : 답글 등록
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
		// 파라미터 수집
		int qnaId = Integer.parseInt(request.getParameter("qnaId"));
		String content = request.getParameter("replyContent");

		// 서비스 호출 – 답글 저장
		qnaAdminService.insertReply(qnaId, content);

		// 다시 상세 화면으로 리다이렉트
		response.sendRedirect(request.getContextPath() + "/qna/detailAdmin?no=" + qnaId);

	}

}
