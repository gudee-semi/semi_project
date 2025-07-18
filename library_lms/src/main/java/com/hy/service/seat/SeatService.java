package com.hy.service.seat;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import com.hy.common.sql.SqlSessionTemplate;
import com.hy.controller.tablet.MyBatisUtil;
import com.hy.dao.seat.SeatDao;
import com.hy.dto.seat.Seat;
import com.hy.dto.seat.SeatLog;
import com.hy.mapper.seat.SeatLogMapper;

public class SeatService {
	
	// dao 작성 -> dao 를 여기에 필드로 선언하기
	private SeatDao dao = new SeatDao();

	public List<Seat> selectAllSeat() {
		return dao.selectAllSeat();
	}

	public int useSeat(int seatNo, int memberNo) {
		Seat param = new Seat();
		param.setSeatId(seatNo);
		param.setMemberNo(memberNo);
		return dao.useSeat(param);
	}

	public int cancelSeat(int seatNo, int memberNo) {
		Seat param = new Seat();
		param.setSeatId(seatNo);
		param.setMemberNo(memberNo);
		return dao.cancelSeat(param);
	}

	public int changeSeat(int oldSeatNo, int newSeatNo, int memberNo) {
		// 트랜잭션이 필요한 경우: 수동 커밋 설정
		SqlSession session = SqlSessionTemplate.getSqlSession(false);
		int result = 0;
		
		try {
			// 1단계: 기존 좌석 취소
			Seat oldSeat = new Seat();
			oldSeat.setSeatId(oldSeatNo);
			oldSeat.setMemberNo(memberNo);
			int cancelResult = dao.cancelSeat(session, oldSeat);
			
			// 2단계: 새 좌석 사용
			Seat newSeat = new Seat();
			newSeat.setSeatId(newSeatNo);
			newSeat.setMemberNo(memberNo);
			int useResult = dao.useSeat(session,newSeat);
			
			if (cancelResult > 0 && useResult > 0) {
				session.commit();
				result = 1;
			} else {
				session.rollback();
			}
			
		} catch(Exception e) {
			session.rollback();
			e.printStackTrace();
		} finally {
			session.close();
		}
		return result;
	}

	public Seat getSeatByMember(int memberNo) {
		return dao.selectSeatByMember(memberNo);
	}
	
	public int insertSeatLog(SeatLog log) {
	    try (SqlSession session = MyBatisUtil.getSession()) {
	        SeatLogMapper mapper = session.getMapper(SeatLogMapper.class);
	        int result = mapper.insertLog(log);
	        session.commit();
	        return result;
	    }
	}

	
}
