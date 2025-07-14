package com.hy.dto.notice;

import com.hy.common.vo.Paging;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Notice extends Paging {

	// 필수
	private int noticeId;
	private String title;
	private String content;
	private int viewCount;
	private String category;
	
	private String createAt;
	private String updateAt;
	
	// 커스텀
	private String keyword;
	
}
