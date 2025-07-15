package com.hy.controller.login;

import java.io.IOException;

import org.json.simple.JSONObject;

import com.hy.dto.Member;
import com.hy.service.login.LoginService;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 * Servlet implementation class loginPage
 */
@WebServlet("/login/view")
public class LoginPage extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private LoginService service = new LoginService();
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public LoginPage() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession(true);
		RequestDispatcher view;
		if(session.getAttribute("loginMember")!=null) {
			 view = request.getRequestDispatcher("/views/login/mainPage.jsp");
		}else {
			
			 view = request.getRequestDispatcher("/views/login/loginPage.jsp");
		}
		view.forward(request, response);

	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		String memberId = request.getParameter("memberId");
		String memberPw = request.getParameter("member_pw");
		Member member = service.selectMember(memberId, memberPw);
		JSONObject obj = new JSONObject();
		if(member==null) {
			obj.put("checkId","no");
			
		}else {
			//TODO 아이디 저장체크박스 만들고 다시 쿠키설정
//			Cookie cookie = new Cookie("memberId", memberId);
//			cookie.setMaxAge(60 * 60 * 24 * 7);
//			response.addCookie(cookie);

			HttpSession session = request.getSession(true);
			session.setAttribute("loginMember", member);
			session.setMaxInactiveInterval(30*60);
		}
		
		response.setContentType("application/json;charset=utf-8");
		response.getWriter().print(obj);
		
		
		
		
	}

}
