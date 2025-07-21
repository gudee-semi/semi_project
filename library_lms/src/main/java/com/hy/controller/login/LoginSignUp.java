package com.hy.controller.login;

import java.io.File;
import java.io.IOException;

import org.json.simple.JSONObject;

import com.hy.dto.Member;
import com.hy.dto.login.ProfileAttach;
import com.hy.dto.login.User;
import com.hy.service.login.AdminService;
import com.hy.service.login.ProfileAttachService;
import com.hy.service.login.SignUpService;
import com.hy.service.use.UseService;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class loginSignUp
 */
@WebServlet("/login/signup")
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024,
        maxFileSize = 1024 * 1024 * 5,
        maxRequestSize = 1024 * 1024 * 20
)



public class LoginSignUp extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private SignUpService service = new SignUpService();
	private AdminService adService = new AdminService();
	private UseService useService = new UseService();
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public LoginSignUp() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		RequestDispatcher view = request.getRequestDispatcher("/views/login/signUpPage.jsp");
		view.forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		 	String memberId = request.getParameter("member_id");
		    String memberPw = request.getParameter("member_pw");
		    String memberPhone = request.getParameter("member_phone");
		    String memberRrn = request.getParameter("member_rrn");
		    String memberName = request.getParameter("member_name");
		    String memberAddress = request.getParameter("member_address")+request.getParameter("member_address_detail");
		    String memberSchul = request.getParameter("member_schul");
		    int memberGrade = Integer.parseInt(request.getParameter("member_grade"));
		    JSONObject obj = new JSONObject();
		    
		    User user = adService.userSearch(memberName,memberRrn);
		    if( user == null ) {
		    	obj.put("res_code","500");
		    	obj.put("res_msg", "등록된 회원이 아닙니다.");
		    }else {
		    		Member member = new Member();
				    
		    		member.setUserNo(user.getUserNo());
		    		member.setMemberId(memberId);
				    member.setMemberPw(memberPw);
				    member.setMemberPhone(memberPhone);
				    member.setMemberRrn(memberRrn);
				    member.setMemberName(memberName);
				    member.setMemberAddress(memberAddress);
				    member.setMemberSchool(memberSchul);
				    member.setMemberGrade(memberGrade);
				    member.setMemberSeat(user.getUserSeat());
				    File uploadDir = ProfileAttachService.getUploadDirectory();
				    ProfileAttach attach = ProfileAttachService.handleUploadFile(request, uploadDir);
				    
				    int result = service.insertMember(member,attach);
				    int resultAtd = useService.insertUse(member.getMemberNo());

				    
				    obj.put("res_code","200");
			    	obj.put("res_msg", "회원가입 성공!");
		    } 
		    

		    response.setContentType("application/json; charset=UTF-8");
		    response.getWriter().print(obj);
		
		
		
		
		
		
		
		
		
	}

}
