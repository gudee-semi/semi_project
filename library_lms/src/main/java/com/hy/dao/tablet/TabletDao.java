package com.hy.dao.tablet;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import com.hy.common.sql.SqlSessionTemplate;
import com.hy.controller.tablet.MyBatisUtil;
import com.hy.dto.tablet.Tablet;

public class TabletDao {
	
  // 전체 태블릿 목록 조회 메서드
  public List<Tablet> selectAll() {
    // MyBatis의 SqlSession을 생성 (true: autoCommit 설정)
    SqlSession session = SqlSessionTemplate.getSqlSession(true);

    // Mapper의 selectAll 쿼리를 실행하여 결과를 List<Tablet>로 받음
    List<Tablet> list = session.selectList("com.hy.mapper.tablet.TabletMapper.selectAll");

    // SqlSession을 반드시 닫아줌 (DB 연결 해제)
    session.close();

    // 조회 결과(태블릿 목록) 반환
    return list;
	}
	
  // 사용 가능한 태블릿을 사용중(1)으로 변경하는 메서드
  public void useAvailableTablet() {
    // try-with-resources 구문으로 SqlSession을 생성 (종료시 자동 close)
    try (SqlSession session = MyBatisUtil.getSqlSession()) { // 세션 생성

        // MyBatis Mapper 인터페이스의 구현체를 동적으로 얻음
        TabletMapper mapper = session.getMapper(TabletMapper.class);

        // Mapper의 useAvailableTablet() 메서드 호출 → 
        // 실제로는 XML의 <update id="useAvailableTablet"> 쿼리 실행
        mapper.useAvailableTablet();

        // DB에 변경사항을 저장(커밋). (UPDATE, INSERT, DELETE 등에는 필수)
        session.commit();
    }
    // try-with-resources라 세션은 자동으로 닫힘

	}	

}
