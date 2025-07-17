package com.hy.mapper.seat;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.hy.dto.seat.FixedSeatMemberView;

public interface FixedSeatMapper {
    List<FixedSeatMemberView> selectAllFixedSeatMembers();
    void updateFixedSeat(@Param("memberNo") int memberNo, @Param("seatNo") Integer seatNo);
    
 // ✅ 추가: 다른 회원이 이미 사용 중인지 확인
    boolean isSeatNoUsedByOthers(@Param("seatNo") int seatNo, @Param("memberNo") int memberNo);

}

