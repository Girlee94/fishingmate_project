package com.ej.fishingmate.vo;

public class ShowOffFishVO {
	private int fish_no;
	private int fishing_category_no;
	private String fish_name;
	private int fish_score;
	
	public ShowOffFishVO() {
		super();
		// TODO Auto-generated constructor stub
	}
	
	public ShowOffFishVO(int fish_no, int fishing_category_no, String fish_name, int fish_score) {
		super();
		this.fish_no = fish_no;
		this.fishing_category_no = fishing_category_no;
		this.fish_name = fish_name;
		this.fish_score = fish_score;
	}
	
	public int getFish_no() {
		return fish_no;
	}
	public void setFish_no(int fish_no) {
		this.fish_no = fish_no;
	}
	public int getFishing_category_no() {
		return fishing_category_no;
	}
	public void setFishing_category_no(int fishing_category_no) {
		this.fishing_category_no = fishing_category_no;
	}
	public String getFish_name() {
		return fish_name;
	}
	public void setFish_name(String fish_name) {
		this.fish_name = fish_name;
	}
	public int getFish_score() {
		return fish_score;
	}
	public void setFish_score(int fish_score) {
		this.fish_score = fish_score;
	}
}
