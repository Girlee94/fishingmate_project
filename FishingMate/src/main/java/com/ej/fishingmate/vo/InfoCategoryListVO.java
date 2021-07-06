package com.ej.fishingmate.vo;

public class InfoCategoryListVO {

	private int list_no;
	private int info_category_no;
	private int info_freeboard_no;
	
	public InfoCategoryListVO() {
		super();
	}

	public InfoCategoryListVO(int list_no, int info_category_no, int info_freeboard_no) {
		super();
		this.list_no = list_no;
		this.info_category_no = info_category_no;
		this.info_freeboard_no = info_freeboard_no;
	}

	public int getList_no() {
		return list_no;
	}

	public void setList_no(int list_no) {
		this.list_no = list_no;
	}

	public int getInfo_category_no() {
		return info_category_no;
	}

	public void setInfo_category_no(int info_category_no) {
		this.info_category_no = info_category_no;
	}

	public int getInfo_freeboard_no() {
		return info_freeboard_no;
	}

	public void setInfo_freeboard_no(int info_freeboard_no) {
		this.info_freeboard_no = info_freeboard_no;
	}
	
	
}
