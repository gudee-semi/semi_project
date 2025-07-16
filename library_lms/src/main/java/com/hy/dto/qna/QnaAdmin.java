package com.hy.dto.qna;

import java.time.LocalDateTime;

import com.hy.common.vo.Paging;

import lombok.Data;

@Data
public class QnaAdmin extends Paging {
	
	private int qnaReplyId;
	private int qnaId;
	private String content;
	private LocalDateTime regDate;
	private LocalDateTime modDate;
	
	private Qna qna;

}
