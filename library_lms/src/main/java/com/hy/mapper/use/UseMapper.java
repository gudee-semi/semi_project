package com.hy.mapper.use;

import com.hy.dto.use.Use;

public interface UseMapper {
	
	int updateUseCheckIn(Use param);
	
	Use getUseStatusByNo(int memberNo);
	
}
