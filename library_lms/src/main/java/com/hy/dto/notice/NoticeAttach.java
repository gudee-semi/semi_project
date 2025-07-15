package com.hy.dto.notice;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class NoticeAttach {
	private int noticeAttachId;
	private int noticeId;
	private String oriName;
	private String reName;
	private String path;
}
