package com.ej.fishingmate.vo;

public class EventImageVO {

	private int image_no;
    private int event_freeboard_no;
    private String image_location;
    private String image_original_filename;
	
    public EventImageVO() {
		super();
	}

	public EventImageVO(int image_no, int event_freeboard_no, String image_location, String image_original_filename) {
		super();
		this.image_no = image_no;
		this.event_freeboard_no = event_freeboard_no;
		this.image_location = image_location;
		this.image_original_filename = image_original_filename;
	}

	public int getImage_no() {
		return image_no;
	}

	public void setImage_no(int image_no) {
		this.image_no = image_no;
	}

	public int getEvent_freeboard_no() {
		return event_freeboard_no;
	}

	public void setEvent_freeboard_no(int event_freeboard_no) {
		this.event_freeboard_no = event_freeboard_no;
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
