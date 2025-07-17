package com.hy.dto.tablet;

import java.util.Date;

import lombok.Data;

@Data
public class TabletLog {
	
	private int tabletLogId;
    private int tabletStatus;
    private Date useTime;
    
    private Tablet tablet;

}
