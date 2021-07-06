package com.ej.fishingmate.vo;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

public class EventVO {

	private int event_freeboard_no; 
    private int member_no;
    private int manager_no;
    private String event_freeboard_title;
    private String event_freeboard_content;
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date event_freeboard_startdate;
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date event_freeboard_enddate;
    private int event_freeboard_readcount;    
    private Date event_freeboard_writedate;
    private String event_freeboard_approve;
	
    public EventVO() {
		super();
	}

	public EventVO(int event_freeboard_no, int member_no, int manager_no, String event_freeboard_title,
			String event_freeboard_content, Date event_freeboard_startdate, Date event_freeboard_enddate,
			int event_freeboard_readcount, Date event_freeboard_writedate, String event_freeboard_approve) {
		super();
		this.event_freeboard_no = event_freeboard_no;
		this.member_no = member_no;
		this.manager_no = manager_no;
		this.event_freeboard_title = event_freeboard_title;
		this.event_freeboard_content = event_freeboard_content;
		this.event_freeboard_startdate = event_freeboard_startdate;
		this.event_freeboard_enddate = event_freeboard_enddate;
		this.event_freeboard_readcount = event_freeboard_readcount;
		this.event_freeboard_writedate = event_freeboard_writedate;
		this.event_freeboard_approve = event_freeboard_approve;
	}

	public int getEvent_freeboard_no() {
		return event_freeboard_no;
	}

	public void setEvent_freeboard_no(int event_freeboard_no) {
		this.event_freeboard_no = event_freeboard_no;
	}

	public int getMember_no() {
		return member_no;
	}

	public void setMember_no(int member_no) {
		this.member_no = member_no;
	}

	public int getManager_no() {
		return manager_no;
	}

	public void setManager_no(int manager_no) {
		this.manager_no = manager_no;
	}

	public String getEvent_freeboard_title() {
		return event_freeboard_title;
	}

	public void setEvent_freeboard_title(String event_freeboard_title) {
		this.event_freeboard_title = event_freeboard_title;
	}

	public String getEvent_freeboard_content() {
		return event_freeboard_content;
	}

	public void setEvent_freeboard_content(String event_freeboard_content) {
		this.event_freeboard_content = event_freeboard_content;
	}

	public Date getEvent_freeboard_startdate() {
		return event_freeboard_startdate;
	}

	public void setEvent_freeboard_startdate(Date event_freeboard_startdate) {
		this.event_freeboard_startdate = event_freeboard_startdate;
	}

	public Date getEvent_freeboard_enddate() {
		return event_freeboard_enddate;
	}

	public void setEvent_freeboard_enddate(Date event_freeboard_enddate) {
		this.event_freeboard_enddate = event_freeboard_enddate;
	}

	public int getEvent_freeboard_readcount() {
		return event_freeboard_readcount;
	}

	public void setEvent_freeboard_readcount(int event_freeboard_readcount) {
		this.event_freeboard_readcount = event_freeboard_readcount;
	}

	public Date getEvent_freeboard_writedate() {
		return event_freeboard_writedate;
	}

	public void setEvent_freeboard_writedate(Date event_freeboard_writedate) {
		this.event_freeboard_writedate = event_freeboard_writedate;
	}

	public String getEvent_freeboard_approve() {
		return event_freeboard_approve;
	}

	public void setEvent_freeboard_approve(String event_freeboard_approve) {
		this.event_freeboard_approve = event_freeboard_approve;
	}
	
    
    
}
