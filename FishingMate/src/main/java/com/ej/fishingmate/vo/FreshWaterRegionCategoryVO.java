package com.ej.fishingmate.vo;

public class FreshWaterRegionCategoryVO {
	private int region_category_no;
	private String region_category_name;
	
	public FreshWaterRegionCategoryVO() {
		// TODO Auto-generated constructor stub
	}

	public FreshWaterRegionCategoryVO(int region_category_no, String region_category_name) {
		super();
		this.region_category_no = region_category_no;
		this.region_category_name = region_category_name;
	}

	public int getRegion_category_no() {
		return region_category_no;
	}

	public void setRegion_category_no(int region_category_no) {
		this.region_category_no = region_category_no;
	}

	public String getRegion_category_name() {
		return region_category_name;
	}

	public void setRegion_category_name(String region_category_name) {
		this.region_category_name = region_category_name;
	}
}
