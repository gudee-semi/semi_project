package com.hy.dto.qna;

import java.time.LocalDateTime;

import com.hy.common.vo.Paging;

import lombok.Data;

@Data
public class QnaReply extends Paging {
	private int qnaReplyId;
	private int qnaId;
	private int replyCheck;
	private String content;
	private LocalDateTime regDate;
	private LocalDateTime modDate;
	
	private Qna qna;
}
