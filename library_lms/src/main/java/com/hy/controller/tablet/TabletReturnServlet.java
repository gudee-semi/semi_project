package com.hy.controller.tablet;

import java.io.IOException;

import com.hy.dto.Member;
import com.hy.service.tablet.TabletService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/tablet/return")
public class TabletReturnServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	TabletService tabletService = new TabletService();

    public TabletReturnServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
        Member loginMember = (Member) request.getSession().getAttribute("loginMember");
        if (loginMember == null) {
            response.sendRedirect(request.getContextPath() + "/login/view");
            return;
        }
        int memberNo = loginMember.getMemberNo();
        int tabletId = Integer.parseInt(request.getParameter("tabletId"));
        tabletService.returnTablet(tabletId, memberNo); // Service에 이 메소드 반드시 추가!
        response.sendRedirect(request.getContextPath() + "/tablet/view");
            
            
	}

}
