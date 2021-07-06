package com.ej.fishingmate.vo;

import java.util.Date;

public class TopListVO {
	private int showoff_freeboard_no;
    private String showoff_freeboard_title; 
    private String member_nick; 
    private int showoff_freeboard_readcount; 
    private Date showoff_freeboard_writedate;
	private int recommedCount;
	public int getShowoff_freeboard_no() {
		return showoff_freeboard_no;
	}
	public void setShowoff_freeboard_no(int showoff_freeboard_no) {
		this.showoff_freeboard_no = showoff_freeboard_no;
	}
	public String getShowoff_freeboard_title() {
		return showoff_freeboard_title;
	}
	public void setShowoff_freeboard_title(String showoff_freeboard_title) {
		this.showoff_freeboard_title = showoff_freeboard_title;
	}
	public String getMember_nick() {
		return member_nick;
	}
	public void setMember_nick(String member_nick) {
		this.member_nick = member_nick;
	}
	public int getShowoff_freeboard_readcount() {
		return showoff_freeboard_readcount;
	}
	public void setShowoff_freeboard_readcount(int showoff_freeboard_readcount) {
		this.showoff_freeboard_readcount = showoff_freeboard_readcount;
	}
	public Date getShowoff_freeboard_writedate() {
		return showoff_freeboard_writedate;
	}
	public void setShowoff_freeboard_writedate(Date showoff_freeboard_writedate) {
		this.showoff_freeboard_writedate = showoff_freeboard_writedate;
	}
	public int getRecommedCount() {
		return recommedCount;
	}
	public void setRecommedCount(int recommedCount) {
		this.recommedCount = recommedCount;
	}
	public TopListVO(int showoff_freeboard_no, String showoff_freeboard_title, String member_nick,
			int showoff_freeboard_readcount, Date showoff_freeboard_writedate, int recommedCount) {
		super();
		this.showoff_freeboard_no = showoff_freeboard_no;
		this.showoff_freeboard_title = showoff_freeboard_title;
		this.member_nick = member_nick;
		this.showoff_freeboard_readcount = showoff_freeboard_readcount;
		this.showoff_freeboard_writedate = showoff_freeboard_writedate;
		this.recommedCount = recommedCount;
	}
	public TopListVO() {
		super();
		// TODO Auto-generated constructor stub
	}
	
}
