package com.hy.controller.mypage;

import java.io.File;
import java.io.IOException;

import com.hy.dto.Member;
import com.hy.dto.login.ProfileAttach;
import com.hy.service.mypage.MyPageService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 * Servlet implementation class DeleteMember
 */
@WebServlet("/delete/member")
public class DeleteMember extends HttpServlet {
	private static final long serialVersionUID = 1L;
    private MyPageService service = new MyPageService();
    /**
     * @see HttpServlet#HttpServlet()
     */
    public DeleteMember() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession(false);
		Member member= (Member)session.getAttribute("loginMember");
		int memberNo = member.getMemberNo();
		ProfileAttach attach = service.selectProfileAttach(memberNo);
		int result = service.deleteMember(memberNo);
		
		
		File file =new File(attach.getPath());
		if(result>0) {
			if (file.exists()) {
				file.delete();
			}
		}
		session.invalidate();
		response.sendRedirect(request.getContextPath() + "/login/view");
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
