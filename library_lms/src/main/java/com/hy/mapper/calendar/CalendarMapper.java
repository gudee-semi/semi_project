package com.hy.mapper.calendar;

import java.util.List;

import com.hy.dto.calendar.Todo;

public interface CalendarMapper {
	
	public int insertTodo(Todo param);
	
	public int deleteTodo(int plannerId);
	
	public int updateTodo(Todo param);
	
	List<Todo> selectTodoByNo(int memberNo);

}
