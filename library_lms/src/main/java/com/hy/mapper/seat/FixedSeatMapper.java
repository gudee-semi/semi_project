package com.hy.mapper.seat;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.hy.dto.seat.FixedSeatMemberView;

public interface FixedSeatMapper {
    List<FixedSeatMemberView> selectAllFixedSeatMembers();
    void updateFixedSeat(@Param("memberNo") int memberNo, @Param("seatNo") Integer seatNo);
}

