package com.hy.controller.login;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

import org.json.simple.JSONObject;

import com.hy.dto.Member;
import com.hy.service.login.LoginService;

/**
 * Servlet implementation class LoginSearch
 */
@WebServlet("/login/search")
public class LoginSearch extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private LoginService service = new LoginService();
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public LoginSearch() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String type= request.getParameter("type");
		request.setAttribute("type",type);
		RequestDispatcher view = request.getRequestDispatcher("/views/login/loginSearch.jsp");
		view.forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		String memberName=request.getParameter("memberName");
		String memberPhone = request.getParameter("memberPhone");
		String memberId = request.getParameter("memberId");
		JSONObject obj = new JSONObject();
		
		if(memberName != null ) {
			//아이디 찾기
		
			Member member = service.searchId(memberName,memberPhone);
			if(member ==null) {
		
				obj.put("id", "no");
			}else {
				obj.put("id",member.getMemberId());
			}
		}else {
			//비밀번호 찾기
			 Member member = service.searchPw(memberId,memberPhone);
			 if(member == null) {
				 //비밀번호 불일치
				 obj.put("pw","no");
			 }else {
				 //비밀번호 일치시 비밀번호 변경 페이지로 이동
				obj.put("pw",member.getMemberId());
			 }
	
		}

		response.setContentType("application/json;charset=utf-8");
		response.getWriter().print(obj);
		
		
		
		
	}

}
