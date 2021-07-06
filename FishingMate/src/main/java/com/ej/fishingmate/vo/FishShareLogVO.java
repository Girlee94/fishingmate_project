package com.ej.fishingmate.vo;

import java.util.Date;

public class FishShareLogVO {
	private int fishshare_log_no;
	private int member_no;
	private int fish_no;
	private int fishshare_category_no;
	private int fishshare_log_value;
	private int fishshare_quantity;
	private Date fishshare_writedate;
	public int getFishshare_log_no() {
		return fishshare_log_no;
	}
	public void setFishshare_log_no(int fishshare_log_no) {
		this.fishshare_log_no = fishshare_log_no;
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
	public int getFishshare_category_no() {
		return fishshare_category_no;
	}
	public void setFishshare_category_no(int fishshare_category_no) {
		this.fishshare_category_no = fishshare_category_no;
	}
	public int getFishshare_log_value() {
		return fishshare_log_value;
	}
	public void setFishshare_log_value(int fishshare_log_value) {
		this.fishshare_log_value = fishshare_log_value;
	}
	public int getFishshare_quantity() {
		return fishshare_quantity;
	}
	public void setFishshare_quantity(int fishshare_quantity) {
		this.fishshare_quantity = fishshare_quantity;
	}
	public Date getFishshare_writedate() {
		return fishshare_writedate;
	}
	public void setFishshare_writedate(Date fishshare_writedate) {
		this.fishshare_writedate = fishshare_writedate;
	}
	public FishShareLogVO(int fishshare_log_no, int member_no, int fish_no, int fishshare_category_no,
			int fishshare_log_value, int fishshare_quantity, Date fishshare_writedate) {
		super();
		this.fishshare_log_no = fishshare_log_no;
		this.member_no = member_no;
		this.fish_no = fish_no;
		this.fishshare_category_no = fishshare_category_no;
		this.fishshare_log_value = fishshare_log_value;
		this.fishshare_quantity = fishshare_quantity;
		this.fishshare_writedate = fishshare_writedate;
	}
	public FishShareLogVO() {
		super();
		// TODO Auto-generated constructor stub
	}
	
}
