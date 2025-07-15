package com.hy.service.tablet;

import java.util.List;

import com.hy.dao.tablet.TabletDao;
import com.hy.dto.tablet.Tablet;

public class TabletService {	
	
	private TabletDao tabletDao = new TabletDao();
	
	// 태블릿 조회
	public List<Tablet> selectAll() {
		return tabletDao.selectAll();
	}	

	// 태블릿 사용
	public void useTablet(int tabletId, int memberNo) {
		tabletDao.useTablet(tabletId, memberNo);
	}
	
	// 태블릿 반납
	public void returnTablet(int tabletId, int memberNo) {
		tabletDao.returnTablet(tabletId, memberNo);
	}

	
}
