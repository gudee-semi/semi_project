package com.hy.mapper.qna;

import java.util.List;

import com.hy.dto.notice.Notice;
import com.hy.dto.notice.NoticeAttach;
import com.hy.dto.qna.Attach;
import com.hy.dto.qna.Qna;

public interface QnaMapper {
	List<Qna> selectQnaList(Qna param);
	
	int selectQnaCount(Qna param);
	
	int updateViewCount(int qnaId);
	
	int updateQna(Qna qna);
	
	int updateAttach(Attach param);
	
	Qna selectQnaOne(int qnaId);

	int deleteAttach(Qna param);
	
	int deleteQna(int qnaId);
	
	Attach selectAttachByQnaNo(int qnaId);
	
	Attach selectAttachByAttachNo(int attachNo);
	
	int insertQna(Qna param);
	
	int insertAttach(Attach param);
}
