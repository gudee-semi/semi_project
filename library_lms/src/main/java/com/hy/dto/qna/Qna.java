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
	private String memberId;
	private String category;
	private String title;
	private String content;
	private String regDate;
	private String modDate;
	private int visibility;
	private int viewCount;
	private int answerStatus;
	
	private int memberNo; // 맞는지..
	private String keyword;
}
