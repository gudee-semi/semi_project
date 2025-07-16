package com.hy.mapper.tablet;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.hy.dto.tablet.Tablet;
import com.hy.dto.tablet.TabletLog;

	// DB 쿼리와 1:1 연결
public interface TabletMapper {
	
	// DB 쿼리와 1:1 연결
	
	// 테이블 전체 조회
	List<Tablet> selectAll();
	
	void useAvailableTablet();
	// 특정 태블릿을 '사용중' 상태로 바꾸는 쿼리(UPDATE)를 호출	
	void useTablet(@Param("tabletId") int tabletId, @Param("memberNo") int memberNo);

	// 특정 태블릿을 '반납(사용가능)' 상태로 바꾸는 쿼리(UPDATE)를 호출
	void returnTablet(@Param("tabletId") int tabletId, @Param("memberNo") int memberNo);

	// 로그 테이블(tablet_log)에 “사용/반납” 기록을 추가(INSERT)
	void insertTabletLog(@Param("memberNo") int memberNo, @Param("tabletStatus") int tabletStatus);
    
	// 로그 전체 조회
	List<TabletLog> selectAllTabletLog();
    
}
