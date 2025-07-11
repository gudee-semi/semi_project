package com.hy.dao.tablet;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import com.hy.common.sql.tablet.SessionTemplate;
import com.hy.dto.tablet.Tablet;
import com.hy.mapper.tablet.TabletMapper;

public class TabletDao {
	
	public List<Tablet> selectAll() {
		SqlSession session = SessionTemplate.getSqlSession(true);
		List<Tablet> list = session.getMapper(TabletMapper.class).selectAll();
		session.close();
		return list;
	}

}
