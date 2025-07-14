package com.hy.mapper.tablet;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.hy.dto.tablet.Tablet;

public interface TabletMapper {
	
	// DB 쿼리와 1:1 연결
	
	// 테이블 전체 조회
	List<Tablet> selectAll();
	
	// 사용 가능한 테블릿	
	void useAvailableTablet();

}
