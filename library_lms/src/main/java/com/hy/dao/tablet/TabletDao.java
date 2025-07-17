package com.hy.dao.tablet;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import com.hy.common.sql.SqlSessionTemplate;
import com.hy.controller.tablet.MyBatisUtil;
import com.hy.dto.tablet.Tablet;
import com.hy.dto.tablet.TabletLog;
import com.hy.mapper.tablet.TabletMapper;

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
  
	// 사용 가능한 태블릿 중 첫 번째 사용(실제 구현은 프로젝트 목적에 따라 다름)
  public void useTablet(int tabletId, int memberNo) {
    // try-with-resources로 SqlSession 사용 (자동 close)
    try (SqlSession session = MyBatisUtil.getSqlSession(false)) {
        
    	// Mapper 가져오기
        TabletMapper mapper = session.getMapper(TabletMapper.class);
        
        // 실제 UPDATE 쿼리 호출
        mapper.useTablet(tabletId, memberNo); // XML에서 UPDATE 처리
        
        // commit() 호출해야 DB에 반영됨
        session.commit();
    }
  }
  
  public void returnTablet(int tabletId, int memberNo) {
	    try (SqlSession session = MyBatisUtil.getSqlSession(false)) {
	        TabletMapper mapper = session.getMapper(TabletMapper.class);
	        mapper.returnTablet(tabletId, memberNo);
	        session.commit();
	    }
	}
  
  // 태블릿 로그 추가
  public void insertTabletLog(int memberNo, int tabletStatus) {
      try (SqlSession session = MyBatisUtil.getSqlSession(false)) {
          TabletMapper mapper = session.getMapper(TabletMapper.class);
          mapper.insertTabletLog(memberNo, tabletStatus);
          session.commit();
      }
  }
  
  // 태블릿 로그 전체 조회
  public List<TabletLog> selectAllTabletLog() {
	    try (SqlSession session = MyBatisUtil.getSqlSession(true)) {
	        TabletMapper mapper = session.getMapper(TabletMapper.class);
	        return mapper.selectAllTabletLog();
	    }
	}
	
     public List<Tablet> selectAllTabletMemberName() {
	 	SqlSession session = SqlSessionTemplate.getSqlSession(true);
	 	List<Tablet> tabletList = session.selectList("com.hy.mapper.tablet.TabletMapper.selectAllTabletMemberName");
	 	session.close();
	 	return tabletList;
	}

     public int updatePenalty(int memberNo) {
    	 SqlSession session = SqlSessionTemplate.getSqlSession(true);
    	 int result = session.update("com.hy.mapper.tablet.TabletMapper.updatePenalty", memberNo);
    	 session.close();
    	 return result;
     }
}