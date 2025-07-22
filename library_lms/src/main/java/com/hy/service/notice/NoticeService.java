package com.hy.service.notice;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import com.hy.common.sql.SqlSessionTemplate;
import com.hy.dao.notice.NoticeDao;
import com.hy.dto.notice.Notice;
import com.hy.dto.notice.NoticeAttach;

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

	public int createNoticeWithAttach(Notice notice, NoticeAttach attach) {
		SqlSession session = SqlSessionTemplate.getSqlSession(false);
		int result = 0;
		
		try {
			result = noticeDao.insertNotice(session, notice);

			
			if (attach != null && result > 0) {
				attach.setNoticeId(notice.getNoticeId());
				result = noticeDao.insertAttach(session, attach);
			}
						
			// commit or rollback
			if (result > 0) session.commit();
			else session.rollback();
			
		} catch (Exception e) {
			e.printStackTrace();
			session.rollback();
		}  finally {
			session.close();
		}
		
		return result;
	}
	
	public int updateNoticeWithAttach(Notice notice, NoticeAttach attach) {
		SqlSession session = SqlSessionTemplate.getSqlSession(false);
		int result = 0;
		
		try {
			result = noticeDao.updateNotice(session, notice);
			
			if (attach != null && result > 0) {
				result = noticeDao.updateAttach(session, attach);
			}
						
			// commit or rollback
			if (result > 0) session.commit();
			else session.rollback();
			
		} catch (Exception e) {
			e.printStackTrace();
			session.rollback();
		}  finally {
			session.close();
		}
		
		return result;
	}

	public int updateNoticeDeleteAttach(Notice notice) {
		SqlSession session = SqlSessionTemplate.getSqlSession(false);
		int result = 0;
		
		try {
			result = noticeDao.updateNotice(session, notice);
			
			if (result > 0) {
				result = noticeDao.deleteAttach(session, notice);
			}
						
			// commit or rollback
			if (result > 0) session.commit();
			else session.rollback();
			
		} catch (Exception e) {
			e.printStackTrace();
			session.rollback();
		}  finally {
			session.close();
		}
		
		return result;
	}
	
	public int updateNoticeSameAttach(Notice notice) {
		SqlSession session = SqlSessionTemplate.getSqlSession(false);
		int result = 0;
		
		try {
			result = noticeDao.updateNotice(session, notice);
						
			// commit or rollback
			if (result > 0) session.commit();
			else session.rollback();
			
		} catch (Exception e) {
			e.printStackTrace();
			session.rollback();
		}  finally {
			session.close();
		}
		
		return result;
	}
	
	public int updateNoticeNewAttach(Notice notice, NoticeAttach attach) {
		SqlSession session = SqlSessionTemplate.getSqlSession(false);
		
		int result = 0;
		
		try {
			result = noticeDao.updateNotice(session, notice);
			
			if (attach != null && result > 0) {
				result = noticeDao.insertAttach(session, attach);
			}
						
			// commit or rollback
			if (result > 0) session.commit();
			else session.rollback();
			
		} catch (Exception e) {
			e.printStackTrace();
			session.rollback();
		}  finally {
			session.close();
		}
		
		return result;
	}
	
	public NoticeAttach selectAttachByNo(int noticeId) {
		return noticeDao.selectAttachByNo(noticeId);
	}

	public int deleteNotice(int noticeId) {
		return noticeDao.deleteNotice(noticeId);
	}

	public int updateViewCount(int noticeId) {
		return noticeDao.updateViewCount(noticeId);
	}

	public List<Notice> selectNoticeMain() {
		return noticeDao.selectNoticeMain();
	}



	
	

}
