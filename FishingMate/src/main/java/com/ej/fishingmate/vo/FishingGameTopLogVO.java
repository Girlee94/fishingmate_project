package com.ej.fishingmate.vo;

public class FishingGameTopLogVO {
	private int member_no;
	private double log_value;
	public FishingGameTopLogVO() {
		super();
		// TODO Auto-generated constructor stub
	}
	public FishingGameTopLogVO(int member_no, double log_value) {
		super();
		this.member_no = member_no;
		this.log_value = log_value;
	}
	public int getMember_no() {
		return member_no;
	}
	public void setMember_no(int member_no) {
		this.member_no = member_no;
	}
	public double getLog_value() {
		return log_value;
	}
	public void setLog_value(double log_value) {
		this.log_value = log_value;
	}
}
