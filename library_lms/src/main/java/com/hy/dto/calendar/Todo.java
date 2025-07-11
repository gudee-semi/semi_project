package com.hy.dto.calendar;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Todo {
	private int plannerId;
	private int memberNo;
	private String title;
	private String detail;
	private int isCompleted;
	private java.sql.Date dueDate;
}
