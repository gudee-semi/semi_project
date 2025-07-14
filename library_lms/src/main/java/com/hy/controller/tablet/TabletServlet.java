package com.hy.controller.tablet;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import com.hy.dto.tablet.Tablet;
import com.hy.service.tablet.TabletService;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/tablet/view")
public class TabletServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private TabletService tabletService = new TabletService();

	public TabletServlet() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		// 임시 번호(나중에 삭제)
		int instantMemberNo = 1;

		if (request.getSession().getAttribute("loginMemberNo") == null) {
			// 임시 번호(나중에 삭제)
			request.getSession().setAttribute("loginMemberNo", 1);
		}

		// 로그인 사용자의 memberNo 세션에서 꺼내기
		Integer myMemberNo = (int) request.getSession().getAttribute("loginMemberNo");

		// 로그인한 사용자만 접근 허용
		if (myMemberNo == null) {
			// 로그인 안 한 사용자!
			// 1) 로그인 페이지로 리다이렉트
			response.sendRedirect("/login/view");
			return;
		}

		int memberNo = myMemberNo.intValue();

		// DB에서 태블릿 리스트 조회
		List<Tablet> tabletList = tabletService.selectAll();

		// 각 태블릿별로 '내가 사용중인지' 판단해서, Tablet에 isUsing 필드 추가 or 별도 리스트로 저장
		List<Boolean> usingList = new ArrayList<>();
		for (Tablet tablet : tabletList) {
			boolean using = tablet.getMemberNo() != null && tablet.getMemberNo().equals(myMemberNo);
			usingList.add(using);
		}

		// JSP에서 사용하도록 request 영역에 저장
		request.setAttribute("tabletList", tabletList);
		request.setAttribute("usingList", usingList);

		// 포워드
		RequestDispatcher dispatcher = request.getRequestDispatcher("/views/tablet/tabletPage.jsp");
		dispatcher.forward(request, response);

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    Integer memberNo = (Integer) request.getSession().getAttribute("loginMemberNo");
    tabletService.useAvailableTablet(memberNo);
    response.sendRedirect(request.getContextPath() + "/tablet/view");

	}

}
