package com.hy.mapper.tablet;

import org.apache.ibatis.annotations.Param;

public interface LogTabletMapper {
	
	void insertLogTablet(@Param("tabletId") int tabletId, @Param("status") int status);

}
