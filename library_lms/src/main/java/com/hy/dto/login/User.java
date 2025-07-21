package com.hy.dto.login;

import com.hy.common.vo.Paging;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class User extends Paging {
	int userNo;
	String userName;
	String userRrn;
	int userSeat;
}
