package com.hy.service.calendar;

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

}
