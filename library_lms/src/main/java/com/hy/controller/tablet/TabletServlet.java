package com.hy.controller.tablet;

import java.io.IOException;
import java.util.List;

import com.hy.dto.tablet.Tablet;
import com.hy.service.tablet.TabletService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/tablet/view")
public class TabletServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public TabletServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		TabletService service = new TabletService();
		List<Tablet> tabletList = service.getTabletList();
		
		request.setAttribute("tabletList", tabletList);
		request.getRequestDispatcher("/views/tablet/tabletPage.jsp").forward(request, response);
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
