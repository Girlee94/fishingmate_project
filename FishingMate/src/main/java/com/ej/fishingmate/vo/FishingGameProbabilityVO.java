package com.ej.fishingmate.vo;

public class FishingGameProbabilityVO {
	private int probability_no;
	private int fish_no;
	private double probability_fish;
	private double probability_minlength;
	private double probability_maxlength;
	public FishingGameProbabilityVO(int probability_no, int fish_no, double probability_fish,
			double probability_minlength, double probability_maxlength) {
		super();
		this.probability_no = probability_no;
		this.fish_no = fish_no;
		this.probability_fish = probability_fish;
		this.probability_minlength = probability_minlength;
		this.probability_maxlength = probability_maxlength;
	}
	public FishingGameProbabilityVO() {
		super();
		// TODO Auto-generated constructor stub
	}
	public int getProbability_no() {
		return probability_no;
	}
	public void setProbability_no(int probability_no) {
		this.probability_no = probability_no;
	}
	public int getFish_no() {
		return fish_no;
	}
	public void setFish_no(int fish_no) {
		this.fish_no = fish_no;
	}
	public double getProbability_fish() {
		return probability_fish;
	}
	public void setProbability_fish(double probability_fish) {
		this.probability_fish = probability_fish;
	}
	public double getProbability_minlength() {
		return probability_minlength;
	}
	public void setProbability_minlength(double probability_minlength) {
		this.probability_minlength = probability_minlength;
	}
	public double getProbability_maxlength() {
		return probability_maxlength;
	}
	public void setProbability_maxlength(double probability_maxlength) {
		this.probability_maxlength = probability_maxlength;
	}

}
