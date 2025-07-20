package com.hy.mapper.use;

import java.util.List;

import com.hy.dto.Member;
import com.hy.dto.use.Use;
import com.hy.dto.use.UseLog;

public interface UseMapper {
	
	int updateUseCheckIn(Use param);
	
	Use getUseStatusByNo(int memberNo);
	
	int insertUseLog(UseLog param);
	
	List<UseLog> getLogByNo(int memberNo);
	
	int insertUse(int param);
	
	List<Use> getUseStatus();
	
	int abortMember(int memberNo);
	
}
