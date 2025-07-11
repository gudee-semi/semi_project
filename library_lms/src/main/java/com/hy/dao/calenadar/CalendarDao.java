package com.hy.dao.calenadar;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import com.hy.common.sql.SqlSessionTemplate;
import com.hy.dto.calendar.Todo;

public class CalendarDao {
	public int insertTodo(Todo param) {
		SqlSession session = SqlSessionTemplate.getSqlSession(true);
		session.insert("com.hy.mapper.calendar.CalendarMapper.insertTodo", param);
		session.close();
		return param.getPlannerId();
	}

	public int deleteTodo(int plannerId) {
		SqlSession session = SqlSessionTemplate.getSqlSession(true);
		int result = session.delete("com.hy.mapper.calendar.CalendarMapper.deleteTodo", plannerId);
		return result;
	}

	public int updateTodo(Todo param) {
		SqlSession session = SqlSessionTemplate.getSqlSession(true);
		int result = session.update("com.hy.mapper.calendar.CalendarMapper.updateTodo", param);
		return result;
	}

	public List<Todo> selectTodoByNo(int memberNo) {
		SqlSession session = SqlSessionTemplate.getSqlSession(true);
		List<Todo> result = session.selectList("com.hy.mapper.calendar.CalendarMapper.selectTodoByNo", memberNo);
		return result;
	}

	public int updateCheck(Todo param) {
		SqlSession session = SqlSessionTemplate.getSqlSession(true);
		int result = session.update("com.hy.mapper.calendar.CalendarMapper.updateCheck", param);
		return result;
	}
}
