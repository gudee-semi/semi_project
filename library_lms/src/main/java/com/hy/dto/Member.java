package com.hy.dto;

import com.hy.common.vo.Paging;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Member extends Paging{
	private int memberNo;
	private int userNo;
	private String memberId;
	private String memberName;
	private String memberPw;
	private String memberPhone;
	private String memberRrn;
	private String memberAddress;
	private String memberSchool;
	private int memberGrade;
	private int memberSeat;
	private int memberPenalty;
	private String registeredAt;
	private int activeStatus;
}
