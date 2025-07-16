package com.hy.controller.mypage;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

import org.json.simple.JSONObject;

import com.hy.dto.Member;	

/**
 * Servlet implementation class MypagePasswordInput
 */
@WebServlet("/mypage/password/input")
public class MypagePasswordInput extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public MypagePasswordInput() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.sendRedirect("/views/mypage/mypagePasswordInput.jsp");
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		String inputPw = request.getParameter("member_pw");
		HttpSession session = request.getSession();
		Member member = (Member)session.getAttribute("loginMember");
		String memberPw = member.getMemberPw();
		JSONObject obj = new JSONObject();
		if(inputPw.equals(memberPw)) {
			obj.put("res_code", "200");
		}else {
			obj.put("res_code","500");
		}
		
		response.setContentType("application/json; charset=utf-8");
		response.getWriter().print(obj);
	
	}
	
	

}
