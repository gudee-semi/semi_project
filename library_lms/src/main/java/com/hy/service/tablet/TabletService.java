package com.hy.service.tablet;

import java.util.List;

import com.hy.dao.tablet.TabletDao;
import com.hy.dto.tablet.Tablet;

public class TabletService {
	
	private TabletDao dao = new TabletDao();
	
	public List<Tablet> getTabletList() {
		return dao.selectAll();
	}


}
