package com.hy.controller.use;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import org.json.simple.JSONObject;

import com.hy.dto.use.Use;
import com.hy.service.use.UseService;

/**
 * Servlet implementation class AdminAbortServlet
 */
@WebServlet("/admin/abort")
public class AdminAbortServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    private UseService service = new UseService();   
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AdminAbortServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		List<Use> list = service.getUseStatus();
		request.setAttribute("list", list);
		request.getRequestDispatcher("/views/admin/adminAbortPage.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		
		String[] memberNoArr = request.getParameterValues("list[]");
		String[] memberNoPenArr = request.getParameterValues("listPen[]");
		int result = service.abortMemberWithPenalty(memberNoArr, memberNoPenArr);
		
		JSONObject obj = new JSONObject();
		
		if (result > 0) {
			obj.put("res_msg", "강제 퇴실 조치가 완료되었습니다.");
			obj.put("res_code", "200");
		} else {
			obj.put("res_msg", "강제 퇴실 조치가 실패했습니다.");
			obj.put("res_code", "500");			
		}
		
		response.setContentType("application/json; charset=UTF-8");
		PrintWriter out = response.getWriter();
		out.print(obj);
	}

}
