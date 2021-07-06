package com.ej.fishingmate.vo;

public class MateFreeboardImageVO {
	private int image_no;
	private int mate_freeboard_no;
	private String image_location;
	private String image_original_filename;
	
	public MateFreeboardImageVO() {
		// TODO Auto-generated constructor stub
	}

	public MateFreeboardImageVO(int image_no, int mate_freeboard_no, String image_location,
			String image_original_filename) {
		super();
		this.image_no = image_no;
		this.mate_freeboard_no = mate_freeboard_no;
		this.image_location = image_location;
		this.image_original_filename = image_original_filename;
	}

	public int getImage_no() {
		return image_no;
	}

	public void setImage_no(int image_no) {
		this.image_no = image_no;
	}

	public int getMate_freeboard_no() {
		return mate_freeboard_no;
	}

	public void setMate_freeboard_no(int mate_freeboard_no) {
		this.mate_freeboard_no = mate_freeboard_no;
	}

	public String getImage_location() {
		return image_location;
	}

	public void setImage_location(String image_location) {
		this.image_location = image_location;
	}

	public String getImage_original_filename() {
		return image_original_filename;
	}

	public void setImage_original_filename(String image_original_filename) {
		this.image_original_filename = image_original_filename;
	}
}
