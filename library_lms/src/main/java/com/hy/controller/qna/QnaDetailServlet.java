package com.hy.controller.qna;

import java.io.IOException;
import java.util.List;

import com.hy.dto.Member;
import com.hy.dto.qna.Attach;
import com.hy.dto.qna.Qna;
import com.hy.dto.qna.QnaReply;
import com.hy.dto.use.Use;
import com.hy.service.mypage.MyPageService;
import com.hy.service.qna.QnaAdminService;
import com.hy.service.qna.QnaService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/qna/detail")
public class QnaDetailServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private QnaService qnaService = new QnaService();
	private QnaAdminService qnaAdminService = new QnaAdminService();
	private MyPageService mypageservice =new MyPageService();
       
    public QnaDetailServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int qnaId = Integer.parseInt(request.getParameter("no"));
		
		// Qna와 Attach 조회
		Qna qna = qnaService.selectQnaOne(qnaId);
		Attach attach = qnaService.selectAttachByQnaNo(qnaId);
		QnaReply reply = new QnaReply();
		
		List<QnaReply> replyList = qnaAdminService.selectReplyList(qnaId);
		
		// 조회수 올리기
		qnaService.updateViewCount(qnaId);
		
		// qnaReply replyCheck 값 0로 변경(문의한사람이 확인했다는 표시)
		HttpSession session =request.getSession();
		Member member =(Member)session.getAttribute("loginMember");
		
		int memberNo = member.getMemberNo();
		
		// 작성자 아닌 멤버가 비공개글 url로 접근 시, 메인페이지로 전환
		if ((memberNo != qna.getMemberNo()) && (qna.getVisibility() == 0)){
			response.sendRedirect(request.getContextPath()+"/");
			return;
		}
		
		if (memberNo == qna.getMemberNo()) {
			int result = mypageservice.updateReplyCheck(qnaId);
		}
	
		request.setAttribute("qna", qna);
		request.setAttribute("attach", attach);
		request.setAttribute("replyList", replyList);
		request.getRequestDispatcher("/views/qna/detail.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
