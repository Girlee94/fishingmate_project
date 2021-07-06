package com.ej.fishingmate.vo;

public class FishCatchRateVO {
	private int fish_no;
	private String fish_name;
	private int catch_count;
	
	public FishCatchRateVO() {
		// TODO Auto-generated constructor stub
	}

	public FishCatchRateVO(int fish_no, String fish_name, int catch_count) {
		super();
		this.fish_no = fish_no;
		this.fish_name = fish_name;
		this.catch_count = catch_count;
	}

	public int getFish_no() {
		return fish_no;
	}

	public void setFish_no(int fish_no) {
		this.fish_no = fish_no;
	}

	public String getFish_name() {
		return fish_name;
	}

	public void setFish_name(String fish_name) {
		this.fish_name = fish_name;
	}

	public int getCatch_count() {
		return catch_count;
	}

	public void setCatch_count(int catch_count) {
		this.catch_count = catch_count;
	}
}
