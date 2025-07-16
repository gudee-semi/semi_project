package com.hy.dto.qna;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Attach {
	private int qnaAttachId;
	private int qnaId;
	private String oriName;
	private String reName;
	private String path;
	
	
}

