package com.hy.dto.seat;

import java.time.LocalDateTime;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;


@Data
@AllArgsConstructor
@NoArgsConstructor
public class SeatLog {
	private int seatLogId;
    private int memberNo;
    private Integer seatNo;
    private LocalDateTime nowTime;
    private int state;
}
