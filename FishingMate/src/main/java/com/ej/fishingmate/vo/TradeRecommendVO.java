package com.ej.fishingmate.vo;

import java.util.Date;

public class TradeRecommendVO {
	
	private int trade_recommend_no;
	private int trade_freeboard_no;
	private int member_no;
	private Date trade_recommend_date;
	
	public TradeRecommendVO() {
		// TODO Auto-generated constructor stub
	}

	public TradeRecommendVO(int trade_recommend_no, int trade_freeboard_no, int member_no, Date trade_recommend_date) {
		super();
		this.trade_recommend_no = trade_recommend_no;
		this.trade_freeboard_no = trade_freeboard_no;
		this.member_no = member_no;
		this.trade_recommend_date = trade_recommend_date;
	}

	public int getTrade_recommend_no() {
		return trade_recommend_no;
	}

	public void setTrade_recommend_no(int trade_recommend_no) {
		this.trade_recommend_no = trade_recommend_no;
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

	public Date getTrade_recommend_date() {
		return trade_recommend_date;
	}

	public void setTrade_recommend_date(Date trade_recommend_date) {
		this.trade_recommend_date = trade_recommend_date;
	}
	
	

}
