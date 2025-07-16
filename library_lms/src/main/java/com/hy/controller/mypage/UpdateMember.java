package com.hy.controller.mypage;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.File;
import java.io.IOException;

import org.json.simple.JSONObject;

import com.hy.dto.Member;
import com.hy.dto.login.ProfileAttach;
import com.hy.dto.login.User;
import com.hy.service.login.ProfileAttachService;
import com.hy.service.mypage.MyPageService;

/**
 * Servlet implementation class UpdateMember
 */
@WebServlet("/update/member")
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024,
        maxFileSize = 1024 * 1024 * 5,
        maxRequestSize = 1024 * 1024 * 20
)
public class UpdateMember extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private MyPageService service =new MyPageService();
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UpdateMember() {
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
		int memberNo = Integer.parseInt(request.getParameter("member_no"));
		String memberPw = request.getParameter("member_pw");
	    String memberAddress = request.getParameter("member_address");
	    String memberSchul = request.getParameter("member_schul");
	    String memberGrade = request.getParameter("member_grade");
	    
	    JSONObject obj = new JSONObject();
	   
  
		Member member = new Member();
		member.setMemberNo(memberNo);
		if(memberPw != null && !memberPw.equals("")) {
		member.setMemberPw(memberPw);
		}
		if(memberAddress != null && !memberAddress.equals("")) {
			member.setMemberAddress(memberAddress);
		}
		if(memberSchul != null && !memberSchul.equals("")) {
			member.setMemberSchool(memberSchul);
		}
		if(memberGrade != null && !memberGrade.equals("")) {
			member.setMemberGrade(Integer.parseInt(memberGrade));
		}
	    File uploadDir = ProfileAttachService.getUploadDirectory();
	    ProfileAttach attach = ProfileAttachService.handleUploadFile(request, uploadDir);
	    int result = service.updateMember(member,attach);
	    
	    
	    HttpSession session = request.getSession();
	    member =(Member)session.getAttribute("loginMember");
	    member = service.selectMember(memberNo);
	    session.setAttribute("loginMember", member);

	    if(result>0) {
	    	obj.put("res_code","200");
	    	obj.put("res_msg","정보 수정 완료");
	    }else {
	    	obj.put("res_code","500");
	    	obj.put("res_msg","서버 오류");
	    }

	    response.setContentType("application/json; charset=UTF-8");
	    response.getWriter().print(obj);
	}

}
