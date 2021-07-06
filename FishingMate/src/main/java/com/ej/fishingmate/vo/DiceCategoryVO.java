package com.ej.fishingmate.vo;

public class DiceCategoryVO {
	
	private int batting_category_no;
	private int batting_kinds;
	
	public DiceCategoryVO() {
		// TODO Auto-generated constructor stub
	}

	public DiceCategoryVO(int batting_category_no, int batting_kinds) {
		super();
		this.batting_category_no = batting_category_no;
		this.batting_kinds = batting_kinds;
	}

	public int getBatting_category_no() {
		return batting_category_no;
	}

	public void setBatting_category_no(int batting_category_no) {
		this.batting_category_no = batting_category_no;
	}

	public int getBatting_kinds() {
		return batting_kinds;
	}

	public void setBatting_kinds(int batting_kinds) {
		this.batting_kinds = batting_kinds;
	}
	

}
