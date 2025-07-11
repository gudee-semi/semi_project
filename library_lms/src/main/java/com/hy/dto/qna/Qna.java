package com.hy.dto.qna;

import com.hy.common.vo.Paging;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Qna extends Paging{
	private int qnaId;
	private int memberNo;
	private String category;
	private String title;
	private String content;
	private String regDate;
	private String modDate;
	private int visibility;
	private int viewCount = 0;
	private int answerStatus;
	
	private String keyword;
}
