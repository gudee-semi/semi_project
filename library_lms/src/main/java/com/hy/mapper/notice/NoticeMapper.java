package com.hy.mapper.notice;

import java.util.List;

import com.hy.dto.notice.Notice;

public interface NoticeMapper {
	
	List<Notice> selectNoticeList(Notice param);
	
	int selectNoticeCount(Notice param);

}
