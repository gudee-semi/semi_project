package com.hy.mapper.qna;

import java.util.List;

import com.hy.dto.Attach;
import com.hy.dto.qna.Qna;

public interface QnaMapper {
	List<Qna> selectQnaList(Qna param);
	
	int selectQnaCount(Qna param);
	
	Qna selectQnaOne(int qnaNo);

	Attach selectAttachByQnaNo(int qnoNo);
	
	Attach selectAttachByAttachNo(int attachNo);
	
	int insertQna(Qna param);
}
