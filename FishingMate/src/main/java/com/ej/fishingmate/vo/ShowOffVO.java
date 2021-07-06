package com.ej.fishingmate.vo;

import java.util.Date;

public class ShowOffVO {
	private int showoff_freeboard_no;
	private int member_no;
	private int fish_no;
	private String showoff_freeboard_title;
	private String showoff_freeboard_content;
	private Date showoff_freeboard_writedate;
	private int showoff_freeboard_readcount;
	private int showoff_freeboard_fishlength;
	private double showoff_freeboard_levelvalue;
	
	public ShowOffVO() {
		super();
		// TODO Auto-generated constructor stub
	}
	
	public ShowOffVO(int showoff_freeboard_no, int member_no, int fish_no, String showoff_freeboard_title,
			String showoff_freeboard_content, Date showoff_freeboard_writedate, int showoff_freeboard_readcount,
			int showoff_freeboard_fishlength, double showoff_freeboard_levelvalue) {
		super();
		this.showoff_freeboard_no = showoff_freeboard_no;
		this.member_no = member_no;
		this.fish_no = fish_no;
		this.showoff_freeboard_title = showoff_freeboard_title;
		this.showoff_freeboard_content = showoff_freeboard_content;
		this.showoff_freeboard_writedate = showoff_freeboard_writedate;
		this.showoff_freeboard_readcount = showoff_freeboard_readcount;
		this.showoff_freeboard_fishlength = showoff_freeboard_fishlength;
		this.showoff_freeboard_levelvalue = showoff_freeboard_levelvalue;
	}
	
	public int getShowoff_freeboard_no() {
		return showoff_freeboard_no;
	}
	public void setShowoff_freeboard_no(int showoff_freeboard_no) {
		this.showoff_freeboard_no = showoff_freeboard_no;
	}
	public int getMember_no() {
		return member_no;
	}
	public void setMember_no(int member_no) {
		this.member_no = member_no;
	}
	public int getFish_no() {
		return fish_no;
	}
	public void setFish_no(int fish_no) {
		this.fish_no = fish_no;
	}
	public String getShowoff_freeboard_title() {
		return showoff_freeboard_title;
	}
	public void setShowoff_freeboard_title(String showoff_freeboard_title) {
		this.showoff_freeboard_title = showoff_freeboard_title;
	}
	public String getShowoff_freeboard_content() {
		return showoff_freeboard_content;
	}
	public void setShowoff_freeboard_content(String showoff_freeboard_content) {
		this.showoff_freeboard_content = showoff_freeboard_content;
	}
	public Date getShowoff_freeboard_writedate() {
		return showoff_freeboard_writedate;
	}
	public void setShowoff_freeboard_writedate(Date showoff_freeboard_writedate) {
		this.showoff_freeboard_writedate = showoff_freeboard_writedate;
	}
	public int getShowoff_freeboard_readcount() {
		return showoff_freeboard_readcount;
	}
	public void setShowoff_freeboard_readcount(int showoff_freeboard_readcount) {
		this.showoff_freeboard_readcount = showoff_freeboard_readcount;
	}
	public int getShowoff_freeboard_fishlength() {
		return showoff_freeboard_fishlength;
	}
	public void setShowoff_freeboard_fishlength(int showoff_freeboard_fishlength) {
		this.showoff_freeboard_fishlength = showoff_freeboard_fishlength;
	}
	public double getShowoff_freeboard_levelvalue() {
		return showoff_freeboard_levelvalue;
	}
	public void setShowoff_freeboard_levelvalue(double showoff_freeboard_levelvalue) {
		this.showoff_freeboard_levelvalue = showoff_freeboard_levelvalue;
	}
	
	
}
