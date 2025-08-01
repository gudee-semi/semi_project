package com.hy.mapper.notice;

import java.util.List;

import com.hy.dto.notice.Notice;
import com.hy.dto.notice.NoticeAttach;

public interface NoticeMapper {
	
	List<Notice> selectNoticeList(Notice param);
	
	int selectNoticeCount(Notice param);
	
	Notice selectNoticeByNo(int noticeId);
	
	int insertNotice(Notice param);
	
	int insertAttach(NoticeAttach param);
	
	NoticeAttach selectAttachByNo(int noticeId);
	
	int updateNotice(Notice param);
	
	int updateAttach(NoticeAttach param);
	
	int deleteAttach(Notice param);
	
	int deleteNotice(int noticeId);
	
	int updateViewCount(int noticeId);
	
	List<Notice> selectNoticeMain();

}
