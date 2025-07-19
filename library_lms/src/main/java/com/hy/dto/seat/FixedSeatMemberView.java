package com.hy.dto.seat;


import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class FixedSeatMemberView {
	private int memberNo;
	private int memberGrade;
    private String memberName;
    private String memberSchool;
    private int memberPenalty; // 패널티
    private Integer seatNo; // null 허용
}
