package com.ej.fishingmate.vo;

import java.util.Date;

public class TradeVO {
	
	private int trade_freeboard_no;
	private int member_no;
	private int trade_status_no;
	private int item_category_no; 
	private String trade_freeboard_title;
    private String trade_freeboard_content; 
    private int trade_freeboard_readcount; 
    private Date trade_freeboard_writedate;
    private int trade_freeboard_wishcount;
    private int trade_freeboard_itemprice;
    
    public TradeVO() {
		// TODO Auto-generated constructor stub
	}

	public TradeVO(int trade_freeboard_no, int member_no, int trade_status_no, int item_category_no,
			String trade_freeboard_title, String trade_freeboard_content, int trade_freeboard_readcount,
			Date trade_freeboard_writedate, int trade_freeboard_wishcount, int trade_freeboard_itemprice) {
		super();
		this.trade_freeboard_no = trade_freeboard_no;
		this.member_no = member_no;
		this.trade_status_no = trade_status_no;
		this.item_category_no = item_category_no;
		this.trade_freeboard_title = trade_freeboard_title;
		this.trade_freeboard_content = trade_freeboard_content;
		this.trade_freeboard_readcount = trade_freeboard_readcount;
		this.trade_freeboard_writedate = trade_freeboard_writedate;
		this.trade_freeboard_wishcount = trade_freeboard_wishcount;
		this.trade_freeboard_itemprice = trade_freeboard_itemprice;
	}

	public int getTrade_freeboard_no() {
		return trade_freeboard_no;
	}

	public void setTrade_freeboard_no(int trade_freeboard_no) {
		this.trade_freeboard_no = trade_freeboard_no;
	}

	public int getMember_no() {
		return member_no;
	}

	public void setMember_no(int member_no) {
		this.member_no = member_no;
	}

	public int getTrade_status_no() {
		return trade_status_no;
	}

	public void setTrade_status_no(int trade_status_no) {
		this.trade_status_no = trade_status_no;
	}

	public int getItem_category_no() {
		return item_category_no;
	}

	public void setItem_category_no(int item_category_no) {
		this.item_category_no = item_category_no;
	}

	public String getTrade_freeboard_title() {
		return trade_freeboard_title;
	}

	public void setTrade_freeboard_title(String trade_freeboard_title) {
		this.trade_freeboard_title = trade_freeboard_title;
	}

	public String getTrade_freeboard_content() {
		return trade_freeboard_content;
	}

	public void setTrade_freeboard_content(String trade_freeboard_content) {
		this.trade_freeboard_content = trade_freeboard_content;
	}

	public int getTrade_freeboard_readcount() {
		return trade_freeboard_readcount;
	}

	public void setTrade_freeboard_readcount(int trade_freeboard_readcount) {
		this.trade_freeboard_readcount = trade_freeboard_readcount;
	}

	public Date getTrade_freeboard_writedate() {
		return trade_freeboard_writedate;
	}

	public void setTrade_freeboard_writedate(Date trade_freeboard_writedate) {
		this.trade_freeboard_writedate = trade_freeboard_writedate;
	}

	public int getTrade_freeboard_wishcount() {
		return trade_freeboard_wishcount;
	}

	public void setTrade_freeboard_wishcount(int trade_freeboard_wishcount) {
		this.trade_freeboard_wishcount = trade_freeboard_wishcount;
	}

	public int getTrade_freeboard_itemprice() {
		return trade_freeboard_itemprice;
	}

	public void setTrade_freeboard_itemprice(int trade_freeboard_itemprice) {
		this.trade_freeboard_itemprice = trade_freeboard_itemprice;
	}




}
