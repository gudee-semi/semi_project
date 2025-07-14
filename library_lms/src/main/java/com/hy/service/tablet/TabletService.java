package com.hy.service.tablet;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import com.hy.controller.tablet.MyBatisUtil;
import com.hy.dao.tablet.TabletDao;
import com.hy.dto.tablet.Tablet;
import com.hy.mapper.tablet.LogTabletMapper;
import com.hy.mapper.tablet.TabletMapper;

public class TabletService {	
	
	private TabletDao tabletDao = new TabletDao();
	
	// 태블릿 조회 메소드
	public List<Tablet> selectAll() {
		return tabletDao.selectAll();
	}
	

	// DAO 호출해서 가장 앞 태블릿 사용중으로 변경
	public void useAvailableTablet(int memberNo) {
    tabletDao.useAvailableTablet(memberNo);
//    tabletDao.insertLogTablet(memberNo, 1);
	}

	
}
