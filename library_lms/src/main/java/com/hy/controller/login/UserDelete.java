package com.hy.controller.login;

import java.io.File;
import java.io.IOException;
import java.util.List;

import javax.print.attribute.HashPrintRequestAttributeSet;

import com.hy.dto.login.ProfileAttach;
import com.hy.dto.login.User;
import com.hy.dto.qna.Qna;
import com.hy.service.login.AdminService;
import com.hy.service.mypage.MyPageService;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class UserDelete
 */
@WebServlet("/user/delete")
public class UserDelete extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private AdminService service =new AdminService();
	private MyPageService Myservice = new MyPageService(); 
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UserDelete() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		//전체 회원 목록 
		User user = new User();
		
		// 현재 페이지 정보 셋팅
		int nowPage = 1;
		String nowPageStr = request.getParameter("nowPage");
		if(nowPageStr != null) {
			nowPage = Integer.parseInt(nowPageStr);
		}
		user.setNowPage(nowPage);
		

		String userName = request.getParameter("userName");

		user.setUserName(userName);
		

		int totalData = service.selectUserCount(user);
		
		// 키워드 기준 2가지로 메소드 각각 만들기
		user.setTotalData(totalData);	
		// 게시글 목록 정보 조회
		List<User> list= service.userList(user);
		for(User u : list) {
			String str = u.getUserRrn();
			str= str.substring(0, 6);
			str= str.substring(0,2)+"년 "+str.substring(2,4)+"월 "+str.substring(4,6)+"일";
			u.setUserRrn(str);
		}
		
		request.setAttribute("paging", user);
		request.setAttribute("userList", list);
		request.getRequestDispatcher("/views/admin/userDelete.jsp").forward(request, response);
	
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		String[] deleteUserNo = request.getParameterValues("deleteUserNo");
		int result=0;
		if (deleteUserNo != null) {
		    for (String userNoStr : deleteUserNo) {
		        int userNo = Integer.parseInt(userNoStr);
		        int memberNo = service.selectMember(userNo);
		        
		        if(memberNo>0) {
		        	ProfileAttach attach = Myservice.selectProfileAttach(memberNo);
					result = Myservice.deleteMember(memberNo);
					File file =new File(attach.getPath());
					if(result>0) {
						if (file.exists()) {
							file.delete();
						}
					}
					result = service.deleteUser(userNo);
		        }else {
		        	result = service.deleteUser(userNo);
		        }
		  
		    }
		}
		if(result>0) {
			request.setAttribute("deleteResult", result);
		}
		request.getRequestDispatcher("/views/admin/userDelete.jsp").forward(request, response);
	}

}
