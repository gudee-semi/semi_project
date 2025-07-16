package com.hy.service.use;

import com.hy.dao.use.UseDao;
import com.hy.dto.use.Use;

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

}
