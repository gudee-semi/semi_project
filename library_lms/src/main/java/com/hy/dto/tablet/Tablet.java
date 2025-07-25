package com.hy.dto.tablet;

import lombok.Data;

@Data
public class Tablet {
	
	private int tabletId;
	private int tabletAvailable;
	private int status;
	private Integer memberNo;	
	private String memberName;

}
