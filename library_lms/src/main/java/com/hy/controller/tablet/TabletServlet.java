package com.hy.controller.tablet;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import com.hy.dto.Member;
import com.hy.dto.tablet.Tablet;
import com.hy.dto.tablet.TabletLog;
import com.hy.service.tablet.TabletService;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/tablet/view")
public class TabletServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private TabletService tabletService = new TabletService();

	public TabletServlet() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		// 세션에서 Member 객체 꺼내기 (안전하게 null 체크)
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

        // 태블릿 목록 조회
        List<Tablet> tabletList = tabletService.selectAll();
        
        // 태블릿 로그 목록 조회
        List<TabletLog> tabletLogList = tabletService.selectAllTabletLog();
        request.setAttribute("tabletLogList", tabletLogList);

        // 각 태블릿별로 내가 사용중인지 체크하는 리스트 생성
        List<Boolean> usingList = new ArrayList<>();
        for (Tablet tablet : tabletList) {
            boolean using = tablet.getMemberNo() != null && tablet.getMemberNo().equals(memberNo);
            usingList.add(using);
        }

        // JSP에서 사용할 데이터 저장
        request.setAttribute("tabletList", tabletList);
        request.setAttribute("usingList", usingList);

        // JSP로 포워드
        RequestDispatcher dispatcher = request.getRequestDispatcher("/views/tablet/tabletPage.jsp");
        dispatcher.forward(request, response);

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	    
	}

}
