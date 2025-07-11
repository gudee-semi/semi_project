package com.hy.service.tablet;

import java.util.List;

import com.hy.dao.tablet.TabletDao;
import com.hy.dto.tablet.Tablet;

public class TabletService {	
	private TabletDao dao = new TabletDao();
	
	// 태블릿 조회 메소드
	public List<Tablet> getTabletList() {
		return dao.selectAll();
	}
	
	// DAO 호출해서 가장 앞 태블릿 사용중으로 변경
	public void useFirstAvailableTablet() {
		dao.updateFirstAvailableTablet();
	}
	
	
	
}
