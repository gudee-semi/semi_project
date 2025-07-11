package com.hy.controller.calendar;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import org.json.simple.JSONObject;

import com.hy.dto.calendar.Todo;
import com.hy.service.calendar.CalendarService;

/**
 * Servlet implementation class CalendarView
 */
@WebServlet("/calendar/view")
public class CalendarView extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private CalendarService service = new CalendarService();
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CalendarView() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		int memberNo = 3; // 여기는 세선에서 값을 가져오도록!!
		
		List<Todo> todoList = service.selectTodoByNo(memberNo);
		for (Todo t : todoList) {
			System.out.println(t);
		}
		
		request.setAttribute("todoList", todoList);
		request.getRequestDispatcher("/views/calendar/calendarPage.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		
		int memberNo = 3;
		String todoTitle = request.getParameter("todoTitle");
		java.sql.Date todoDate = java.sql.Date.valueOf( request.getParameter("todoDate"));
		String todoDetail = null;
		if (!request.getParameter("todoDetail").equals("")) {
			todoDetail = request.getParameter("todoDetail");			
		}
		
		System.out.println(memberNo);
		System.out.println(todoTitle);
		System.out.println(todoDate);
		System.out.println(todoDetail);
		
		int result = service.insertTodo(memberNo, todoTitle, todoDate, todoDetail);
		System.out.println(result);
		
		JSONObject obj = new JSONObject();
		
		if (result > 0) {
			obj.put("res_code", "200");
			obj.put("res_msg", "할 일 목록 입력 성공");
			obj.put("planner_id", result);
		} else {
			obj.put("res_code", "500");
			obj.put("res_msg", "할 일 목록 입력 실패");	
		}
		
		response.setContentType("application/json; charset=UTF-8");
		PrintWriter out = response.getWriter();
		out.print(obj);
		
	}

}
