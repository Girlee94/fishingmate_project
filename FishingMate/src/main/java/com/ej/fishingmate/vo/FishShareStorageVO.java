package com.ej.fishingmate.vo;

import java.util.Date;

public class FishShareStorageVO {
	private int fishshare_storage_no;
	private int member_no;
	private int fish_no;
	private int fishshare_storage_quantity;
	private int fishshare_storage_value;
	private Date fishshare_storage_writedate;
	public int getFishshare_storage_no() {
		return fishshare_storage_no;
	}
	public void setFishshare_storage_no(int fishshare_storage_no) {
		this.fishshare_storage_no = fishshare_storage_no;
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
	public int getFishshare_storage_quantity() {
		return fishshare_storage_quantity;
	}
	public void setFishshare_storage_quantity(int fishshare_storage_quantity) {
		this.fishshare_storage_quantity = fishshare_storage_quantity;
	}
	public int getFishshare_storage_value() {
		return fishshare_storage_value;
	}
	public void setFishshare_storage_value(int fishshare_storage_value) {
		this.fishshare_storage_value = fishshare_storage_value;
	}
	public Date getFishshare_storage_writedate() {
		return fishshare_storage_writedate;
	}
	public void setFishshare_storage_writedate(Date fishshare_storage_writedate) {
		this.fishshare_storage_writedate = fishshare_storage_writedate;
	}
	public FishShareStorageVO(int fishshare_storage_no, int member_no, int fish_no, int fishshare_storage_quantity,
			int fishshare_storage_value, Date fishshare_storage_writedate) {
		super();
		this.fishshare_storage_no = fishshare_storage_no;
		this.member_no = member_no;
		this.fish_no = fish_no;
		this.fishshare_storage_quantity = fishshare_storage_quantity;
		this.fishshare_storage_value = fishshare_storage_value;
		this.fishshare_storage_writedate = fishshare_storage_writedate;
	}
	public FishShareStorageVO() {
		super();
		// TODO Auto-generated constructor stub
	}
	
}
