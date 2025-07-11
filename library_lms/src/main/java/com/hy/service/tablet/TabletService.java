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
	
}
