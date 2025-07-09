package com.hy.dao.calenadar;

import org.apache.ibatis.session.SqlSession;

import com.hy.common.sql.SqlSessionTemplate;
import com.hy.dto.calendar.Todo;

public class CalendarDao {
	public int insertTodo(Todo param) {
		SqlSession session = SqlSessionTemplate.getSqlSession(true);
		int result = session.insert("com.hy.mapper.calendar.CalendarMapper.insertTodo", param);
		session.close();
		return result;
	}
}
