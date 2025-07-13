package com.hy.dao.tablet;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import com.hy.common.sql.SqlSessionTemplate;
import com.hy.dto.tablet.Tablet;

public class TabletDao {
	
	public List<Tablet> selectAll() {
		// 데이터베이스 접근(MYBatis)
		SqlSession session = SqlSessionTemplate.getSqlSession(true);
		List<Tablet> list = session.selectList("com.hy.mapper.tablet.TabletMapper.selectAll");
		session.close();
		return list;
	}

}

