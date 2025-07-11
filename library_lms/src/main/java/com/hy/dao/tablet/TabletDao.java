package com.hy.dao.tablet;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import com.hy.common.sql.SqlSessionTemplate;
import com.hy.controller.tablet.MyBatisUtil;
import com.hy.dto.tablet.Tablet;
import com.hy.mapper.tablet.TabletMapper;

public class TabletDao {
	
	public List<Tablet> selectAll() {
		// 데이터베이스 접근(MYBatis)
		SqlSession session = SqlSessionTemplate.getSqlSession(true);
		List<Tablet> list = session.selectList("com.hy.mapper.tablet.TabletMapper.selectAll");
		session.close();
		return list;
	}
	
	// SqlSession을 이용해서 Mapper를 가져와 호출
	public void updateFirstAvailableTablet() {
    try (SqlSession session = MyBatisUtil.getSqlSession()) { // 세션 생성
      TabletMapper mapper = session.getMapper(TabletMapper.class); // Mapper 얻기
      mapper.useFirstAvailableTablet(); // XML과 매핑된 메서드 호출
      session.commit(); // 꼭 commit!
  }
	}
	
	

}