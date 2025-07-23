package com.hy.controller.tablet;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import org.json.simple.JSONObject;

import com.hy.dto.tablet.Tablet;
import com.hy.dto.tablet.TabletLog;
import com.hy.service.tablet.TabletService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/admin/tablet")
public class TabletAdminServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    private TabletService tabletService = new TabletService();   
	
    public TabletAdminServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		List<Tablet> tabletList = tabletService.selectAll();
		List<Tablet> tabletListm = tabletService.selectAllTabletMemberName();
		
		request.setAttribute("tabletList", tabletList);
		request.setAttribute("tabletListm", tabletListm);
		
		request.getRequestDispatcher("/views/tablet/tabletAdmin.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		
		String[] penaltyMemberInfos = request.getParameterValues("penalty[]");
		int result = 0;
		
		
		if (penaltyMemberInfos != null) {
		    for (String penaltyMember : penaltyMemberInfos) {
		    		String[] paneltyInfo = penaltyMember.split(",");
		    		
		    		if (paneltyInfo.length == 2) {
		    			int memberNo = Integer.parseInt(paneltyInfo[0]);
		    			int tabletNo = Integer.parseInt(paneltyInfo[1]);
		    			result = tabletService.updatePenalty(memberNo);
		    			// 태블릿 반납
		    			tabletService.returnTablet(tabletNo, memberNo);
		    			// 태블릿 로그
		    			tabletService.insertTabletLog(tabletNo, memberNo, 0);
		    		}
		    }
		} else {
		    System.out.println("선택된 항목이 없습니다.");
		}
		
		JSONObject obj = new JSONObject();
		
		if (result > 0) {
			obj.put("res_code", "200");
		} else {
			obj.put("res_code", "500");			
		}
		
		response.setContentType("application/json; charset=UTF-8");
		PrintWriter out = response.getWriter();
		out.print(obj);
	}

}
