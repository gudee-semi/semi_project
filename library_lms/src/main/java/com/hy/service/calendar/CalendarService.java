package com.hy.service.calendar;

import java.util.List;

import com.hy.dao.calenadar.CalendarDao;
import com.hy.dto.calendar.Todo;

public class CalendarService {
	
	private CalendarDao dao = new CalendarDao();
	
	public int insertTodo(int memberNo, String todoTitle, java.sql.Date todoDate, String todoDetail) {
		Todo param = new Todo();
		param.setMemberNo(memberNo);
		param.setTitle(todoTitle);
		param.setDueDate(todoDate);
		param.setDetail(todoDetail);
		return dao.insertTodo(param);
	}

	public int deleteTodo(int plannerId) {
		return dao.deleteTodo(plannerId);
	}

	public int updateTodo(int plannerId) {
		return dao.updateTodo(plannerId);
	}

	public List<Todo> selectTodoByNo(int memberNo) {
		return dao.selectTodoByNo(memberNo);
	}

}
