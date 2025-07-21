package com.hy.controller.login;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

import org.json.simple.JSONObject;

import com.hy.dto.login.User;
import com.hy.service.login.AdminService;

/**
 * Servlet implementation class UserSignUp
 */
@WebServlet("/user/signup")
public class UserSignUp extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private AdminService adService = new AdminService();
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UserSignUp() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.sendRedirect("/views/admin/userRegister.jsp");
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
	    String userRrn = request.getParameter("member_rrn");
	    String userName = request.getParameter("member_name");
	    int userSeat = Integer.parseInt(request.getParameter("member_seat"));
	    JSONObject obj = new JSONObject();
	    
	    User user = adService.userSearch(userName,userRrn);
	    if( user != null ) {
	    	obj.put("res_code","500");
	    	obj.put("res_msg", "등록된 회원입니다.");
	    }else {
	    		user = new User();
			    
	    		user.setUserRrn(userRrn);
	    		user.setUserName(userName);
	    		user.setUserSeat(userSeat);
			    
			    int result = adService.insertUser(user);
			    if(result>0) {
			    obj.put("res_code","200");
		    	obj.put("res_msg", "회원 등록 성공!");
			    }else {
			    	obj.put("res_code","300");
			    	obj.put("res_msg", "회원 등록 실패!");
			    }
	    } 
	    

	    response.setContentType("application/json; charset=UTF-8");
	    response.getWriter().print(obj);
		
	}

}
