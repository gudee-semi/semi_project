package com.hy.dao.use;

import org.apache.ibatis.session.SqlSession;

import com.hy.common.sql.SqlSessionTemplate;

public class UseDao {

	public int updateUseCheckIn(int memberNo) {
		SqlSession session = SqlSessionTemplate.getSqlSession(true);
		int result = session.update("com.hy.mapper.use.UseMapper.updateUseCheckIn", memberNo);
		session.close();
		return result;
	}

}
