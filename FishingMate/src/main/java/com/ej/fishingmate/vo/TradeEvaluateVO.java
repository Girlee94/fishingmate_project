package com.ej.fishingmate.vo;

public class TradeEvaluateVO {
	
	 private int trade_evaluate_no;
	 private int buyer_member_no;
	 private int seller_member_no;
	 private int evaluate_value;
	 private String evaluate_content;
	 
	 public TradeEvaluateVO() {
		// TODO Auto-generated constructor stub
	}

	public TradeEvaluateVO(int trade_evaluate_no, int buyer_member_no, int seller_member_no, int evaluate_value,
			String evaluate_content) {
		super();
		this.trade_evaluate_no = trade_evaluate_no;
		this.buyer_member_no = buyer_member_no;
		this.seller_member_no = seller_member_no;
		this.evaluate_value = evaluate_value;
		this.evaluate_content = evaluate_content;
	}

	public int getTrade_evaluate_no() {
		return trade_evaluate_no;
	}

	public void setTrade_evaluate_no(int trade_evaluate_no) {
		this.trade_evaluate_no = trade_evaluate_no;
	}

	public int getBuyer_member_no() {
		return buyer_member_no;
	}

	public void setBuyer_member_no(int buyer_member_no) {
		this.buyer_member_no = buyer_member_no;
	}

	public int getSeller_member_no() {
		return seller_member_no;
	}

	public void setSeller_member_no(int seller_member_no) {
		this.seller_member_no = seller_member_no;
	}

	public int getEvaluate_value() {
		return evaluate_value;
	}

	public void setEvaluate_value(int evaluate_value) {
		this.evaluate_value = evaluate_value;
	}

	public String getEvaluate_content() {
		return evaluate_content;
	}

	public void setEvaluate_content(String evaluate_content) {
		this.evaluate_content = evaluate_content;
	}
	 
	 
}