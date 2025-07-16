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
		session.close();
		return result;
	}

	public int insertNotice(SqlSession session, Notice notice) {
		int result = session.insert("com.hy.mapper.notice.NoticeMapper.insertNotice", notice);
		return result;
	}

	public int insertAttach(SqlSession session, NoticeAttach attach) {
		int result = session.insert("com.hy.mapper.notice.NoticeMapper.insertAttach", attach);
		return result;
	}

	public NoticeAttach selectAttachByNo(int noticeId) {
		SqlSession session = SqlSessionTemplate.getSqlSession(true);
		NoticeAttach result = session.selectOne("com.hy.mapper.notice.NoticeMapper.selectAttachByNo", noticeId);
		session.close();
		return result;
	}

	public int updateNotice(SqlSession session, Notice notice) {
		return session.update("com.hy.mapper.notice.NoticeMapper.updateNotice", notice);
	}

	public int updateAttach(SqlSession session, NoticeAttach attach) {
		return session.update("com.hy.mapper.notice.NoticeMapper.updateAttach", attach);
	}

	public int deleteAttach(SqlSession session, Notice notice) {
		return session.delete("com.hy.mapper.notice.NoticeMapper.deleteAttach", notice);
	}

	public int deleteNotice(int noticeId) {
		SqlSession session = SqlSessionTemplate.getSqlSession(true);
		int result = session.delete("com.hy.mapper.notice.NoticeMapper.deleteNotice", noticeId);
		session.close();
		return result;
	}

	public int updateViewCount(int noticeId) {
		SqlSession session = SqlSessionTemplate.getSqlSession(true);
		int result = session.update("com.hy.mapper.notice.NoticeMapper.updateViewCount", noticeId);
		session.close();
		return result;
	}

}
