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
		List<Tablet> tabletList = tabletService.selectAll();
		System.out.println(tabletList);
		
		List<Tablet> tabletListm = tabletService.selectAllTabletMemberName();
		System.out.println(tabletListm);
		
		request.setAttribute("tabletList", tabletList);
		request.setAttribute("tabletListm", tabletListm);
		
		request.getRequestDispatcher("/views/tablet/tabletAdmin.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		
		String[] penaltyMemberInfos = request.getParameterValues("penalty");
		System.out.println(penaltyMemberInfos[0]);
		int result = 0;
		
		
		if (penaltyMemberInfos != null) {
		    for (String penaltyMember : penaltyMemberInfos) {
		    		String[] paneltyInfo = penaltyMember.split(",");
		    		
		    		if (paneltyInfo.length == 2) {
		    			int memberNo = Integer.parseInt(paneltyInfo[0]);
		    			int tabletNo = Integer.parseInt(paneltyInfo[1]);
		    			result = tabletService.updatePenalty(memberNo);
		    			tabletService.returnTablet(tabletNo, memberNo);
		    			tabletService.insertTabletLog(tabletNo, memberNo, 0);
		    		}
		    }
		} else {
		    System.out.println("선택된 항목이 없습니다.");
		}
		
		request.setAttribute("msg", "반납처리 후, 해당 사용자에게 패널티를 적용하였습니다.");
		request.setAttribute("path", "/tablet/admin");
		
		if(result < 1) {
			request.setAttribute("msg", "처리 중 오류가 발생했습니다.");
			request.setAttribute("path", "/tablet/admin");
		}
		
		request.getRequestDispatcher("/views/qna/result.jsp").forward(request, response);
	}

}
