package com.hy.mapper.seat;

import java.util.List;

import com.hy.dto.seat.Seat;

public interface SeatMapper {
	
	List<Seat> selectAllSeat();
	int useSeat(Seat param);
	int cancelSeat(Seat param);
}
