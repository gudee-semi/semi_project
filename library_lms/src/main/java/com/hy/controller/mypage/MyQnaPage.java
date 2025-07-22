package com.hy.controller.mypage;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.hy.dto.Member;
import com.hy.dto.qna.Qna;
import com.hy.dto.qna.QnaReply;
import com.hy.service.mypage.MyPageService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class MyQnaPage
 */
@WebServlet("/myqna/view")
public class MyQnaPage extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private MyPageService service = new MyPageService();
    /**
     * @see HttpServlet#HttpServlet()
     */
    public MyQnaPage() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Qna qna = new Qna();
		
		// 현재 페이지 정보 셋팅
		int nowPage = 1;
		String nowPageStr = request.getParameter("nowPage");
		if(nowPageStr != null) {
			nowPage = Integer.parseInt(nowPageStr);
		}
		int memberNo =((Member)request.getSession().getAttribute("loginMember")).getMemberNo();
		qna.setNowPage(nowPage);
		qna.setMemberNo(memberNo);

		int totalData = service.selectMyQnaCount(qna);
		
		
		//내가 문의한 글 전체 개수
		qna.setTotalData(totalData);
		
		// 내가쓴 목록 정보 조회
		List<Qna> qnaList = service.selectMyQnaList(qna);
		//내가 쓴 글에 대한 관리자 답변 
		List<QnaReply> qnaReply = service.selectMyQnaReplyList(memberNo);
		Map<Qna, Integer> m = new HashMap<Qna, Integer>(); 
		for(Qna q : qnaList) {
			
			for(QnaReply r : qnaReply ) {
				
				if(q.getQnaId()== r.getQnaId())
				{
					m.put(q, r.getReplyCheck());
					System.out.println(r.getReplyCheck());
				}
			}
		}	

		
		
		
		request.setAttribute("paging", qna);
		request.setAttribute("qnaList", qnaList);
		request.setAttribute("qnaReply", qnaReply);
		request.getRequestDispatcher("/views/mypage/myQnaView.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
