package com.hy.controller.qna;

import java.io.IOException;
import java.util.Enumeration;
import java.util.Map;

import org.json.simple.JSONObject;

import com.hy.dto.Member;
import com.hy.dto.qna.Qna;
import com.hy.service.qna.QnaService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/qna/update")
public class QnaUpdateServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private QnaService qnaService = new QnaService();
       
    public QnaUpdateServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 화면단에서 전달받은 정보 가져오기
		int qnaId = Integer.parseInt(request.getParameter("no"));
		
		Qna qna = qnaService.selectQnaOne(qnaId);
		request.setAttribute("qna", qna);
		request.getRequestDispatcher("/views/qna/update.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 1. 인코딩처리(utf-8)
		request.setCharacterEncoding("utf-8");
		
		HttpSession session = request.getSession(false); // 기존 세션만 가져오기
		
		Member member = (Member)session.getAttribute("loginMember");
		
	    if (session != null) {
	        if (member != null) {
	        } else {
	        	response.sendRedirect(request.getContextPath()+"/");
	        	return;
	        }
	    } else {
	    	response.sendRedirect(request.getContextPath()+"/");
	    	return;
	    }
		
	    
		// 2. 정보 가져오기(번호,이름,나이)
		
		int memberNo = member.getMemberNo();
		int no = Integer.parseInt(request.getParameter("no"));
		String category = request.getParameter("qnaCategory");
		String title = request.getParameter("qnaTitle");
		String content = request.getParameter("qnaContent");
		int visibility = Integer.parseInt(request.getParameter("qnaVisibility"));
		
		// 3. service한테 부탁해서 updateQna
		// 부탁할 때는 번호,이름,나이 주면서 부탁하고, 
		// 결과는 int 형태로 반환 (delete, insert, update)
		
		Qna qna = new Qna();
		
		qna.setMemberNo(memberNo);
		qna.setQnaId(no);
		qna.setCategory(category);
		qna.setTitle(title);
		qna.setContent(content);
		qna.setVisibility(visibility);
		
		int result = qnaService.updateQna(qna);
		
		JSONObject obj = new JSONObject();
		
		
		request.setAttribute("msg", "수정이 완료되었습니다.");
		request.setAttribute("path", "/qna/detail?no="+no);
		
		if(result<1) {
			request.setAttribute("msg", "수정 중 오류가 발생했습니다.");
			request.setAttribute("path", "/qna/update?no="+no);
		}
		
		request.getRequestDispatcher("/views/qna/result.jsp").forward(request, response);
		
		// 4. 만약에 결과가 0보다 크면 : 목록 화면 전환 다시 요청 sendRedirect()
		// 0보다 크지 않다면 : 수정 화면 재요청 -> 반드시 쿼리 스트링 사용!!
//		if(result > 0) {
//			obj.put("res_code", "200");
//			obj.put("res_msg", "게시글 등록이 성공적으로 진행되었습니다.");
//			response.sendRedirect("/qna/detail");
//		} else {
//			obj.put("res_code", "500");
//			obj.put("res_msg", "게시글 등록중 오류가 발생했습니다.");
//			response.sendRedirect("/qna/update");
//		}
//		
//		response.setContentType("application/json; charset=utf-8");
//		response.getWriter().print(obj);
		
	}

}
