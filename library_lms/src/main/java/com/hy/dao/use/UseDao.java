package com.hy.dao.use;

import org.apache.ibatis.session.SqlSession;

import com.hy.common.sql.SqlSessionTemplate;
import com.hy.dto.use.Use;
import com.hy.dto.use.UseLog;

public class UseDao {

	public int updateUseCheckIn(Use param) {
		SqlSession session = SqlSessionTemplate.getSqlSession(true);
		int result = session.update("com.hy.mapper.use.UseMapper.updateUseCheckIn", param);
		session.close();
		return result;
	}

	public Use getUseStatusByNo(int memberNo) {
		SqlSession session = SqlSessionTemplate.getSqlSession(true);
		Use result = session.selectOne("com.hy.mapper.use.UseMapper.getUseStatusByNo", memberNo);
		session.close();
		return result;
	}

	public int insertUseLog(UseLog param) {
		SqlSession session = SqlSessionTemplate.getSqlSession(true);
		int result = session.insert("com.hy.mapper.use.UseMapper.insertUseLog", param);
		session.close();
		return result;
	}

}
