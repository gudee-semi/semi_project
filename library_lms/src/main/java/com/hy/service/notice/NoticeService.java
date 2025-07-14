package com.hy.service.notice;

import java.util.List;

import com.hy.dao.notice.NoticeDao;
import com.hy.dto.notice.Notice;

public class NoticeService {
	
	private NoticeDao noticeDao = new NoticeDao();

	public List<Notice> selectNoticeList(Notice param) {
		return noticeDao.selectNoticeList(param);
	}

	public int selectNoticeCount(Notice param) {
		return noticeDao.selectNoticeCount(param);
	}

	public Notice selectNoticeByNo(int noticeId) {
		return noticeDao.selectNoticeByNo(noticeId);
	}
	
	

}
