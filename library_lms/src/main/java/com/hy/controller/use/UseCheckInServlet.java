package com.hy.controller.use;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

import org.json.simple.JSONObject;

import com.hy.service.use.UseService;

/**
 * Servlet implementation class UseCheckInServlet
 */
@WebServlet("/use/checkIn")
public class UseCheckInServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private UseService service = new UseService();
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UseCheckInServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		
		int memberNo = Integer.parseInt(request.getParameter("memberNo"));
		
		int result = service.updateUseCheckIn(memberNo);
		
		JSONObject obj = new JSONObject();
		
		if (result > 0) {
			obj.put("res_msg", "입실 처리 되었습니다.");
			obj.put("res_code", "200");
		} else {
			obj.put("res_msg", "입실 실패.");
			obj.put("res_code", "500");			
		}
		
		response.setContentType("application/json; charset=UTF-8");
		PrintWriter out = response.getWriter();
		out.print(obj);
		
	}

}
