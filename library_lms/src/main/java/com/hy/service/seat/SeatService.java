package com.hy.service.seat;

import java.util.List;

import com.hy.dao.seat.SeatDao;
import com.hy.dto.seat.Seat;

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
	
	
}
