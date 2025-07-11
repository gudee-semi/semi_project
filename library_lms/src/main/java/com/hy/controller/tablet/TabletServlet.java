package com.hy.controller.tablet;

import java.io.IOException;
import java.util.List;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

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
		
		// DB에서 태블릿 리스트 가져오기
		List<Tablet> tabletList = tabletService.getTabletList();
		request.setAttribute("tabletList", tabletList);
		
		// JSP로 요청을 넘기는 역할 = 어느 JSP에 넘길지 지정
		RequestDispatcher dispatcher = request.getRequestDispatcher("/views/tablet/tabletPage.jsp");
		dispatcher.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
