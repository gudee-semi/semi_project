package com.hy.controller.login;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

import org.json.simple.JSONObject;

import com.hy.service.login.LoginService;

/**
 * Servlet implementation class ChangePw
 */
@WebServlet("/changePw/view")
public class ChangePw extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private LoginService service = new LoginService();
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ChangePw() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String memberId =request.getParameter("memberId");
		response.sendRedirect("/views/login/loginChangePw.jsp?memberId="+memberId);		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		String memberId =request.getParameter("memberId");
		String memberPw = request.getParameter("member_pw");
		JSONObject obj = new JSONObject();
		
		int result = service.updatePw(memberId,memberPw);
		
		if(result>0){
			obj.put("res_code", "200"); 
			
		}else {
			obj.put("res_code", "500"); 
		}
		
		response.setContentType("application/json;charset=utf-8");
		response.getWriter().print(obj);
		
	}

}
