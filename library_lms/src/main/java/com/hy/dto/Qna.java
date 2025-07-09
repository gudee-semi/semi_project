package com.hy.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Qna {
	private int qnaId;
	private int memberId;
	private int category;
	private String title;
	private String content;
	private String regDate;
	private String modDate;
	private int visibility;
	private int viewCount;
	private int answerStatus;
}
