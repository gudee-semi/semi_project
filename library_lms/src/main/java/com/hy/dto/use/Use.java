package com.hy.dto.use;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Use {
	private int useId;
	private int memberNo;
	private int status;
}
