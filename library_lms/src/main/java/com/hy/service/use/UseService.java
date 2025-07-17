package com.hy.service.use;

import java.util.List;

import com.hy.dao.use.UseDao;
import com.hy.dto.use.Use;
import com.hy.dto.use.UseLog;

public class UseService {

	private UseDao dao = new UseDao();
	
	public int updateUseCheckIn(int memberNo, int check) {
		Use param = new Use();
		param.setMemberNo(memberNo);
		param.setStatus(check);
		return dao.updateUseCheckIn(param);
	}

	public Use getUseStatusByNo(int memberNo) {
		return dao.getUseStatusByNo(memberNo);
	}

	public int insertUseLog(int memberNo, int checkLog) {
		UseLog param = new UseLog();
		param.setMemberNo(memberNo);
		param.setStatus(checkLog);
		return dao.insertUseLog(param);
	}

	public List<UseLog> getLogByNo(int memberNo) {
		return dao.getLogByNo(memberNo);
	}

}
