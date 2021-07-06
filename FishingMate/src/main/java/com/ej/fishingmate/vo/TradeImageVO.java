package com.ej.fishingmate.vo;

public class TradeImageVO {
	
	private int image_no;
	private int trade_freeboard_no;
    private String image_location;
    private String image_original_filename;
    
    public TradeImageVO() {
		// TODO Auto-generated constructor stub
	}

	public TradeImageVO(int image_no, int trade_freeboard_no, String image_location, String image_original_filename) {
		super();
		this.image_no = image_no;
		this.trade_freeboard_no = trade_freeboard_no;
		this.image_location = image_location;
		this.image_original_filename = image_original_filename;
	}

	public int getImage_no() {
		return image_no;
	}

	public void setImage_no(int image_no) {
		this.image_no = image_no;
	}

	public int getTrade_freeboard_no() {
		return trade_freeboard_no;
	}

	public void setTrade_freeboard_no(int trade_freeboard_no) {
		this.trade_freeboard_no = trade_freeboard_no;
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
