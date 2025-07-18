package com.hy.mapper.seat;

import org.apache.ibatis.annotations.Insert;
import com.hy.dto.seat.SeatLog;

public interface SeatLogMapper {

    @Insert("INSERT INTO seat_log (member_no, seat_no, now_time, state) " +
            "VALUES (#{memberNo}, #{seatNo}, #{nowTime}, #{state})")
    int insertLog(SeatLog log);
}
