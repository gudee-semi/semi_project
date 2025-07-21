package com.hy.controller.login;

import java.io.IOException;

import org.json.simple.JSONObject;

import com.hy.dto.login.User;
import com.hy.service.login.SignUpService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class UserRepeatCheck
 */
@WebServlet("/user/reapeatCheck")
public class UserRepeatCheck extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private SignUpService service = new SignUpService();
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UserRepeatCheck() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		String userRrn = request.getParameter("member_rrn");
		
		JSONObject obj = new JSONObject();

		//주민 번호 중복 체크
		
		if(userRrn != null && !userRrn.isEmpty()) {
			User user = service.checkUserRrn(userRrn);
			 if(user == null) {
				 obj.put("rrnCheck", "ok");
			 }else {
				 obj.put("rrnCheck","no");
			 }
		}
		 
		response.setContentType("application/json; charset=utf-8");
		response.getWriter().print(obj);
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
