package com.hy.controller.login;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

import org.json.simple.JSONObject;

import com.hy.dto.Member;
import com.hy.service.login.SignUpService;

/**
 * Servlet implementation class MemberRepeatCheck
 */
@WebServlet("/member/repeatcheck")
public class MemberRepeatCheck extends HttpServlet {
	private static final long serialVersionUID = 1L;
    private SignUpService service = new SignUpService();
    /**
     * @see HttpServlet#HttpServlet()
     */
    public MemberRepeatCheck() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		String memberId = request.getParameter("memberId");
		String memberRrn = request.getParameter("memberRrn");
		
		JSONObject obj = new JSONObject();
		
		//아이디 중복 체크		
		if(memberId != null && !memberId.isEmpty()) {
			Member member = service.checkId(memberId);
			
			if(member==null) {
				obj.put("idCheck","ok");
				
			}else {
				obj.put("idCheck","no");}
			
			
		}
		//주민 번호 중복 체크
		
		if(memberRrn != null && !memberRrn.isEmpty()) {
			Member  member = service.checkRrn(memberRrn);
			 if(member == null) {
				 obj.put("rrnCheck", "ok");
			 }else {
				 obj.put("rrnCheck","no");
			 }
		}
		 
		response.setContentType("application/json; charset=utf-8");
		response.getWriter().print(obj);
		
	}

}
