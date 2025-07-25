package com.hy.service.calendar;

import java.sql.Date;
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

	public List<Todo> selectTodoByNo(int memberNo) {
		List<Todo> list = dao.selectTodoByNo(memberNo);
		for (Todo t : list) {
			String detail = t.getDetail();
			if (detail != null) {
				detail = detail.replace("\n", "<br>");
				t.setDetail(detail);
			}
		}
		
		return list;
	}

	public int updateTodo(String todoTitle, Date todoDate, String todoDetail, int plannerId) {
		Todo param = new Todo();
		param.setPlannerId(plannerId);
		param.setTitle(todoTitle);
		param.setDueDate(todoDate);
		param.setDetail(todoDetail);
		return dao.updateTodo(param);
	}

	public int updateCheck(int plannerId, int isCompleted) {
		Todo param = new Todo();
		param.setPlannerId(plannerId);
		param.setIsCompleted(isCompleted);
		return dao.updateCheck(param);
	}

}
