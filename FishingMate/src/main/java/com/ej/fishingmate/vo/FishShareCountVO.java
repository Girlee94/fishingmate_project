package com.ej.fishingmate.vo;

public class FishShareCountVO {
	private int fish_no;
	private int fishshare_storage_quantity;
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
	public FishShareCountVO(int fish_no, int fishshare_storage_quantity) {
		super();
		this.fish_no = fish_no;
		this.fishshare_storage_quantity = fishshare_storage_quantity;
	}
	public FishShareCountVO() {
		super();
		// TODO Auto-generated constructor stub
	}
	
}
