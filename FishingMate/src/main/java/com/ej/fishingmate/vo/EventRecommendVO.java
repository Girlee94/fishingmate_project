package com.ej.fishingmate.vo;

import java.util.Date;

public class EventRecommendVO {

	private int event_recommend_no;
    private int event_freeboard_no;
    private int member_no;
    private Date event_recommend_date;
	
    public EventRecommendVO() {
		super();
	}

	public EventRecommendVO(int event_recommend_no, int event_freeboard_no, int member_no, Date event_recommend_date) {
		super();
		this.event_recommend_no = event_recommend_no;
		this.event_freeboard_no = event_freeboard_no;
		this.member_no = member_no;
		this.event_recommend_date = event_recommend_date;
	}

	public int getEvent_recommend_no() {
		return event_recommend_no;
	}

	public void setEvent_recommend_no(int event_recommend_no) {
		this.event_recommend_no = event_recommend_no;
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

	public Date getEvent_recommend_date() {
		return event_recommend_date;
	}

	public void setEvent_recommend_date(Date event_recommend_date) {
		this.event_recommend_date = event_recommend_date;
	}

	
    
}
