package com.hy.mapper.use;

import com.hy.dto.use.Use;
import com.hy.dto.use.UseLog;

public interface UseMapper {
	
	int updateUseCheckIn(Use param);
	
	Use getUseStatusByNo(int memberNo);
	
	int insertUseLog(UseLog param);
	
}
