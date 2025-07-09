package com.hy.dto.calendar;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Todo {
	private int memberNo;
	private String title;
	private String detail;
	private java.sql.Date dueDate;
}
