package com.ej.fishingmate.vo;

import java.util.Date;

public class FishingGameLogVO {
	private int log_no;
	private int member_no;
	private int fish_no;
	private double log_fishlength;
	private double log_value;
	private Date log_writedate;
	public FishingGameLogVO(int log_no, int member_no, int fish_no, double log_fishlength, double log_value,
			Date log_writedate) {
		super();
		this.log_no = log_no;
		this.member_no = member_no;
		this.fish_no = fish_no;
		this.log_fishlength = log_fishlength;
		this.log_value = log_value;
		this.log_writedate = log_writedate;
	}
	public FishingGameLogVO() {
		super();
		// TODO Auto-generated constructor stub
	}
	public int getLog_no() {
		return log_no;
	}
	public void setLog_no(int log_no) {
		this.log_no = log_no;
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
	public double getLog_fishlength() {
		return log_fishlength;
	}
	public void setLog_fishlength(double log_fishlength) {
		this.log_fishlength = log_fishlength;
	}
	public double getLog_value() {
		return log_value;
	}
	public void setLog_value(double log_value) {
		this.log_value = log_value;
	}
	public Date getLog_writedate() {
		return log_writedate;
	}
	public void setLog_writedate(Date log_writedate) {
		this.log_writedate = log_writedate;
	}
}
