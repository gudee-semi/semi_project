package com.hy.controller.login;

import java.io.File;
import java.io.IOException;
import java.util.List;

import org.json.simple.JSONObject;

import com.hy.dto.Member;
import com.hy.dto.login.ProfileAttach;
import com.hy.dto.login.User;
import com.hy.service.login.AdminService;
import com.hy.service.mypage.MyPageService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class AdminMemberDelete
 */
@WebServlet("/admin/member/delete")
public class AdminMemberDelete extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private AdminService service =new AdminService();
	private MyPageService Myservice = new MyPageService(); 
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AdminMemberDelete() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		//전체 회원 목록 
		Member member = new Member();
		
		// 현재 페이지 정보 셋팅
		int nowPage = 1;
		String nowPageStr = request.getParameter("nowPage");
		if(nowPageStr != null) {
			nowPage = Integer.parseInt(nowPageStr);
		}
		member.setNowPage(nowPage);
		

		String memberName = request.getParameter("memberName");

		member.setMemberName(memberName);
		

		int totalData = service.selectMemberCount(member);
		
		// 키워드 기준 2가지로 메소드 각각 만들기
		member.setTotalData(totalData);	
		// 게시글 목록 정보 조회
		List<Member> list= service.memberList(member);
		
		request.setAttribute("paging", member);
		request.setAttribute("memberList", list);
		request.getRequestDispatcher("/views/admin/memberDelete.jsp").forward(request, response);
	
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		String[] deleteMemberNo = request.getParameterValues("deleteMemberNo");
		int result=0;
		JSONObject obj = new JSONObject();
		if (deleteMemberNo != null) {
		    for (String memberNoStr : deleteMemberNo) {
		        int memberNo = Integer.parseInt(memberNoStr);
		        	ProfileAttach attach = Myservice.selectProfileAttach(memberNo);
					result = Myservice.deleteMember(memberNo);
					File file =new File(attach.getPath());
					if(result>0) {
						if (file.exists()) {
							file.delete();
						}
					}
		        
		  
		    }
		}
		obj.put("deleteResult", result);
		response.setContentType("application/json;charset=utf-8");
		response.getWriter().print(obj);
	}

}
