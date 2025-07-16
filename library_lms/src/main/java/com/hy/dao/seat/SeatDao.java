package com.hy.dao.seat;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import com.hy.common.sql.SqlSessionTemplate;
import com.hy.dto.seat.Seat;

public class SeatDao {

	public List<Seat> selectAllSeat() {
		SqlSession session = SqlSessionTemplate.getSqlSession(true);
		List<Seat> result = session.selectList("com.hy.mapper.seat.SeatMapper.selectAllSeat"); 
		session.close();
		return result;
	}

	public int useSeat(Seat param) {
		SqlSession session = SqlSessionTemplate.getSqlSession(true);
		int result = session.update("com.hy.mapper.seat.SeatMapper.useSeat", param); 
		session.close();
		return result;
	}

	public int cancelSeat(Seat param) {
		SqlSession session = SqlSessionTemplate.getSqlSession(true);
		int result = session.update("com.hy.mapper.seat.SeatMapper.cancelSeat", param); 
		session.close();
		return result;
	}

	// 트랜잭션 처리용 오버로딩
	public int useSeat(SqlSession session, Seat param) {
		return session.update("com.hy.mapper.seat.SeatMapper.useSeat", param);
	}
	
	public int cancelSeat(SqlSession session, Seat param) {
		return session.update("com.hy.mapper.seat.SeatMapper.cancelSeat", param);
	}

	public Seat selectSeatByMember(int memberNo) {
	    SqlSession session = SqlSessionTemplate.getSqlSession(true);
	    Seat seat = session.selectOne("com.hy.mapper.seat.SeatMapper.selectSeatByMember", memberNo);
	    session.close();
	    return seat;
	}
}
