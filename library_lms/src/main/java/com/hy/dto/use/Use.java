package com.hy.dto.use;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Use {
	private int useStatusId;
	private int memberNo;
	private int status;
	
	// custom
	private String memberName;
	private String memberGrade;
	private String memberSchool;
	private String statusDisplay;
}
