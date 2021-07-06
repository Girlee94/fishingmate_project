package com.ej.fishingmate.vo;

public class FishingCategoryVO {
	private int fishing_category_no;
	private String fishing_category_name;
	
	public FishingCategoryVO() {
		// TODO Auto-generated constructor stub
	}

	public FishingCategoryVO(int fishing_category_no, String fishing_category_name) {
		super();
		this.fishing_category_no = fishing_category_no;
		this.fishing_category_name = fishing_category_name;
	}

	public int getFishing_category_no() {
		return fishing_category_no;
	}

	public void setFishing_category_no(int fishing_category_no) {
		this.fishing_category_no = fishing_category_no;
	}

	public String getFishing_category_name() {
		return fishing_category_name;
	}

	public void setFishing_category_name(String fishing_category_name) {
		this.fishing_category_name = fishing_category_name;
	}
}
