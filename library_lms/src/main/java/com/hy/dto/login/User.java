package com.hy.dto.login;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class User {
	int userNo;
	String userName;
	String userRrn;
	int userSeat;
}
