package com.ej.fishingmate.vo;

public class MateCategoryVO {
	private int mate_category_no;
	private String mate_category_name;
	
	public MateCategoryVO() {
		// TODO Auto-generated constructor stub
	}
	
	public MateCategoryVO(int mate_category_no, String mate_category_name) {
		super();
		this.mate_category_no = mate_category_no;
		this.mate_category_name = mate_category_name;
	}

	public int getMate_category_no() {
		return mate_category_no;
	}

	public void setMate_category_no(int mate_category_no) {
		this.mate_category_no = mate_category_no;
	}

	public String getMate_category_name() {
		return mate_category_name;
	}

	public void setMate_category_name(String mate_category_name) {
		this.mate_category_name = mate_category_name;
	}
}
