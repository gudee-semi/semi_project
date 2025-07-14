package com.hy.dao.notice;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import com.hy.common.sql.SqlSessionTemplate;
import com.hy.dto.notice.Notice;
import com.hy.dto.notice.NoticeAttach;

public class NoticeDao {

	public List<Notice> selectNoticeList(Notice param) {
		SqlSession session = SqlSessionTemplate.getSqlSession(true);
		List<Notice> list = session.selectList("com.hy.mapper.notice.NoticeMapper.selectNoticeList", param);
		session.close();
		return list;
	}

	public int selectNoticeCount(Notice param) {
		SqlSession session = SqlSessionTemplate.getSqlSession(true);
		int result = session.selectOne("com.hy.mapper.notice.NoticeMapper.selectNoticeCount", param);
		session.close();
		return result;
	}

	public Notice selectNoticeByNo(int noticeId) {
		SqlSession session = SqlSessionTemplate.getSqlSession(true);
		Notice result = session.selectOne("com.hy.mapper.notice.NoticeMapper.selectNoticeByNo", noticeId);
		return result;
	}

	public int insertNotice(SqlSession session, Notice notice) {
		return session.insert("com.hy.mapper.notice.NoticeMapper.insertNotice", notice);
	}

	public int insertAttach(SqlSession session, NoticeAttach attach) {
		return session.insert("com.hy.mapper.notice.NoticeMapper.insertAttach", attach);
	}

	public NoticeAttach selectAttachByNo(int noticeId) {
		SqlSession session = SqlSessionTemplate.getSqlSession(true);
		NoticeAttach result = session.selectOne("com.hy.mapper.notice.NoticeMapper.selectAttachByNo", noticeId);
		return result;
	}

}
