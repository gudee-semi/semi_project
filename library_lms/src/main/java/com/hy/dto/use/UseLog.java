package com.hy.dto.use;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class UseLog {
	private int useLogId;
	private int memberNo;
	private int status;
	private java.sql.Date nowTime;
}
