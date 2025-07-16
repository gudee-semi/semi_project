package com.hy.dao.use;

import org.apache.ibatis.session.SqlSession;

import com.hy.common.sql.SqlSessionTemplate;
import com.hy.dto.use.Use;

public class UseDao {

	public int updateUseCheckIn(Use param) {
		SqlSession session = SqlSessionTemplate.getSqlSession(true);
		int result = session.update("com.hy.mapper.use.UseMapper.updateUseCheckIn", param);
		session.close();
		return result;
	}

}
