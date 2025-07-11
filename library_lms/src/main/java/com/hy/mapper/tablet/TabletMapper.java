package com.hy.mapper.tablet;

import java.util.List;

import com.hy.dto.tablet.Tablet;

public interface TabletMapper {
	
	// 테이블 전체 조회
	List<Tablet> selectAll();

}
