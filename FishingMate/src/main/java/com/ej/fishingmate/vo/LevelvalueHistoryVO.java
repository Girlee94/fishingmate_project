package com.ej.fishingmate.vo;

import java.util.Date;

public class LevelvalueHistoryVO {
	private int history_no;
	private int levelvalue_category_no;
	private int member_no;
	private double history_value;
	private Date history_date;
	public int getHistory_no() {
		return history_no;
	}
	public void setHistory_no(int history_no) {
		this.history_no = history_no;
	}
	public int getLevelvalue_category_no() {
		return levelvalue_category_no;
	}
	public void setLevelvalue_category_no(int levelvalue_category_no) {
		this.levelvalue_category_no = levelvalue_category_no;
	}
	public int getMember_no() {
		return member_no;
	}
	public void setMember_no(int member_no) {
		this.member_no = member_no;
	}
	public double getHistory_value() {
		return history_value;
	}
	public void setHistory_value(double history_value) {
		this.history_value = history_value;
	}
	public Date getHistory_date() {
		return history_date;
	}
	public void setHistory_date(Date history_date) {
		this.history_date = history_date;
	}
	public LevelvalueHistoryVO() {
		super();
		// TODO Auto-generated constructor stub
	}
	public LevelvalueHistoryVO(int history_no, int levelvalue_category_no, int member_no, double history_value,
			Date history_date) {
		super();
		this.history_no = history_no;
		this.levelvalue_category_no = levelvalue_category_no;
		this.member_no = member_no;
		this.history_value = history_value;
		this.history_date = history_date;
	}
	
}
