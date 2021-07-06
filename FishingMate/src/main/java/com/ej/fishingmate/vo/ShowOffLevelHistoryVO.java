package com.ej.fishingmate.vo;

import java.util.Date;

public class ShowOffLevelHistoryVO {
	private int history_no;
	private int member_no;
	private String history_content;
	private int history_value;
	private Date history_date;
	
	public ShowOffLevelHistoryVO() {
		super();
		// TODO Auto-generated constructor stub
	}
	
	public ShowOffLevelHistoryVO(int history_no, int member_no, String history_content, int history_value,
			Date history_date) {
		super();
		this.history_no = history_no;
		this.member_no = member_no;
		this.history_content = history_content;
		this.history_value = history_value;
		this.history_date = history_date;
	}
	
	public int getHistory_no() {
		return history_no;
	}
	public void setHistory_no(int history_no) {
		this.history_no = history_no;
	}
	public int getMember_no() {
		return member_no;
	}
	public void setMember_no(int member_no) {
		this.member_no = member_no;
	}
	public String getHistory_content() {
		return history_content;
	}
	public void setHistory_content(String history_content) {
		this.history_content = history_content;
	}
	public int getHistory_value() {
		return history_value;
	}
	public void setHistory_value(int history_value) {
		this.history_value = history_value;
	}
	public Date getHistory_date() {
		return history_date;
	}
	public void setHistory_date(Date history_date) {
		this.history_date = history_date;
	}
	

}
