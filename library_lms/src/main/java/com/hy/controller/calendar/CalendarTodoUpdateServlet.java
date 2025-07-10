package com.hy.controller.calendar;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

import com.hy.service.calendar.CalendarService;

/**
 * Servlet implementation class CalendarTodoUpdateServlet
 */
@WebServlet("/CalendarTodoUpdateServlet")
public class CalendarTodoUpdateServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private CalendarService service = new CalendarService();
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CalendarTodoUpdateServlet() {
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
		
		int plannerId = Integer.parseInt(request.getParameter("plannerId"));
		
		int result = service.updateTodo(plannerId);
	}

}
