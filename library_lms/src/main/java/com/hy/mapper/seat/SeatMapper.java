package com.hy.mapper.seat;
import org.apache.ibatis.annotations.Param;
import java.util.List;

import com.hy.dto.seat.Seat;

public interface SeatMapper {
	void updateSeatStatus(@Param("seatId") int seatId,
            @Param("memberNo") Integer memberNo,
            @Param("seatStatus") int seatStatus);
	List<Seat> selectAllSeat();
	int useSeat(Seat param);
	int cancelSeat(Seat param);
}
