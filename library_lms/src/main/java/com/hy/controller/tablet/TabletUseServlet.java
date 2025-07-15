package com.hy.controller.tablet;

import java.io.IOException;

import com.hy.dto.Member;
import com.hy.service.tablet.TabletService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/tablet/use")
public class TabletUseServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	private TabletService tabletService = new TabletService();

    public TabletUseServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
		// 1. 세션에서 Member 객체 꺼내기 (안전하게 null 체크)
        HttpSession session = request.getSession(false);
        if (session == null) {
            response.sendRedirect(request.getContextPath() + "/login/view");
            return;
        }
        
        Member loginMember = (Member) session.getAttribute("loginMember");
        if (loginMember == null) {
            response.sendRedirect(request.getContextPath() + "/login/view");
            return;
        }
        
        int memberNo = loginMember.getMemberNo();
        int tabletId = Integer.parseInt(request.getParameter("tabletId"));

        // 태블릿 사용 처리
        tabletService.useTablet(tabletId, memberNo);

        // 로그 남기기 (1: 사용중)
        tabletService.insertTabletLog(tabletId, memberNo, 1);

        response.sendRedirect(request.getContextPath() + "/tablet/view");
	
	}

}
