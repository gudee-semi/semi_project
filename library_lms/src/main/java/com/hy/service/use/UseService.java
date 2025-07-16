package com.hy.service.use;

import com.hy.dao.use.UseDao;

public class UseService {

	private UseDao dao = new UseDao();
	
	public int updateUseCheckIn(int memberNo) {
		return dao.updateUseCheckIn(memberNo);
	}

}
