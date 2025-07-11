package com.hy.controller.tablet;

import java.io.IOException;

import com.hy.service.tablet.TabletService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/tablsetUseServlet")
public class tabletUpdateServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private TabletService service = new TabletService();

    public tabletUpdateServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int tabletId = Integer.parseInt(request.getParameter("tabletId"));
		String available = request.getParameter("available");
		
		service.updateTabletAvailable(tabletId, available);
		
		response.sendRedirect("/tablet/list");
		
	}

}
