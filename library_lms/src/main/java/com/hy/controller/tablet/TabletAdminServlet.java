package com.hy.controller.tablet;

import java.io.IOException;
import java.util.List;

import com.hy.dto.tablet.Tablet;
import com.hy.dto.tablet.TabletLog;
import com.hy.service.tablet.TabletService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/tablet/admin")
public class TabletAdminServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    private TabletService tabletService = new TabletService();   
	
    public TabletAdminServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.getRequestDispatcher("/views/tablet/tabletAdmin.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		
		List<Tablet> tabletList = tabletService.selectAllTabletMemberName();
		System.out.println(tabletList);
		List<TabletLog> tabletLogList = tabletService.selectAllTabletLog();
		System.out.println(tabletLogList);
		
		
		
	}

}
