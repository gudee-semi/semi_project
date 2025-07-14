package com.hy.dto.login;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor

public class ProfileAttach {
	
	private int attachNo;
	private int memberNo;
	private String oriName;
	private String reName;
	private String path;
}
