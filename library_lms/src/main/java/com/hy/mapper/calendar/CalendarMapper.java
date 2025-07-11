package com.hy.mapper.calendar;

import java.util.List;

import com.hy.dto.calendar.Todo;

public interface CalendarMapper {
	
	int insertTodo(Todo param);
	
	int deleteTodo(int plannerId);
	
	int updateTodo(Todo param);
	
	List<Todo> selectTodoByNo(int memberNo);
	
	int updateCheck(Todo param);

}
