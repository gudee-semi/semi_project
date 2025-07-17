package com.hy.controller.calendar;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

import org.json.simple.JSONObject;

import com.hy.dto.Member;
import com.hy.dto.calendar.Todo;
import com.hy.dto.use.UseLog;
import com.hy.service.calendar.CalendarService;
import com.hy.service.use.UseService;

/**
 * Servlet implementation class CalendarView
 */
@WebServlet("/calendar/view")
public class CalendarView extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private CalendarService service = new CalendarService();
	private UseService useService = new UseService();
       
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
		
		HttpSession session = request.getSession(false);
		int memberNo = 0; // 여기는 세선에서 값을 가져오도록!!
		
		if (session == null) {
			response.sendRedirect(request.getContentType() + "/");
			return;
		} else {
			if (session.getAttribute("loginMember") == null) {
				response.sendRedirect(request.getContextPath() + "/");
				return;
			} else {
				Member member = (Member)session.getAttribute("loginMember");
				memberNo = member.getMemberNo();
			}
		}
		
		if (memberNo != 0) {
			List<Todo> todoList = service.selectTodoByNo(memberNo);
			List<UseLog> atdLogs = useService.getLogByNo(memberNo);
			
			List<String> log = new ArrayList<String>();
			for (UseLog l : atdLogs) log.add(l.getNowTime().toString());
			
			request.setAttribute("todoList", todoList);
			request.setAttribute("useLog", log);
			request.getRequestDispatcher("/views/calendar/calendarPage.jsp").forward(request, response);			
		} else {
			response.sendRedirect(request.getContextPath() + "/");
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		
		HttpSession session = request.getSession(false);
		int memberNo = 0; // 여기는 세선에서 값을 가져오도록!!
		
		if (session == null) {
			response.sendRedirect(request.getContentType() + "/");
			return;
		} else {
			System.out.println(session);
			if (session.getAttribute("loginMember") == null) {
				response.sendRedirect(request.getContextPath() + "/");
				return;
			} else {
				Member member = (Member)session.getAttribute("loginMember");
				memberNo = member.getMemberNo();
			}
		}
		
		
		if (memberNo != 0) {			
			String todoTitle = request.getParameter("todoTitle");
			java.sql.Date todoDate = java.sql.Date.valueOf( request.getParameter("todoDate"));
			String todoDetail = null;
			if (!request.getParameter("todoDetail").equals("")) {
				todoDetail = request.getParameter("todoDetail");			
			}
			
			int result = service.insertTodo(memberNo, todoTitle, todoDate, todoDetail);
			
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
		} else {
			response.sendRedirect(request.getContextPath() + "/");
		}
		
		
	}

}