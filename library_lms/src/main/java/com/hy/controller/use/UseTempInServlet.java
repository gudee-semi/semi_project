package com.hy.controller.use;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.io.PrintWriter;

import org.json.simple.JSONObject;

import com.hy.dto.use.Use;
import com.hy.service.use.UseService;

/**
 * Servlet implementation class UseTempInServlet
 */
@WebServlet("/use/tempIn")
public class UseTempInServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private UseService service = new UseService();
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UseTempInServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		
		int memberNo = Integer.parseInt(request.getParameter("memberNo"));
		int check = Integer.parseInt(request.getParameter("check"));
		System.out.println(check);
		
		int result = service.updateUseCheckIn(memberNo, check);
		
		JSONObject obj = new JSONObject();
		
		if (result > 0) {
			obj.put("res_msg", "재입실 처리 되었습니다.");
			obj.put("res_code", "200");
			HttpSession session = request.getSession(false);
			if (session != null) {
				Use param = service.getUseStatusByNo(memberNo);
				session.setAttribute("useStatus", param);
			}
		} else {
			obj.put("res_msg", "재입실 실패.");
			obj.put("res_code", "500");			
		}
		
		response.setContentType("application/json; charset=UTF-8");
		PrintWriter out = response.getWriter();
		out.print(obj);
	}

}
