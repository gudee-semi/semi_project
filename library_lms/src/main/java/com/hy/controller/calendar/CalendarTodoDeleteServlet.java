package com.hy.controller.calendar;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

import org.json.simple.JSONObject;

import com.hy.service.calendar.CalendarService;

/**
 * Servlet implementation class CalendarTodoDeleteServlet
 */
@WebServlet("/calendar/delete")
public class CalendarTodoDeleteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private CalendarService service = new CalendarService();
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CalendarTodoDeleteServlet() {
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
		
		int plannerId = Integer.parseInt(request.getParameter("plannerId"));
		System.out.println(plannerId);
		
		int result = service.deleteTodo(plannerId);
		System.out.println(result);
		
		JSONObject obj = new JSONObject();
		
		if (result > 0) {
			obj.put("res_code", "200");
			obj.put("res_msg", "할 일 목록 삭제 성공");
		} else {
			obj.put("res_code", "500");
			obj.put("res_msg", "할 일 목록 삭제 실패");	
		}
		
		response.setContentType("application/json; charset=UTF-8");
		PrintWriter out = response.getWriter();
		out.print(obj);
		
		
	}

}
