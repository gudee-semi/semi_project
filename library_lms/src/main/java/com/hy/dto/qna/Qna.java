package com.hy.dto.qna;

import com.hy.common.vo.Paging;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@NoArgsConstructor
@AllArgsConstructor
@ToString
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
	
	private int memberNo;
	private String keyword;
	private String keywordIn;

}
