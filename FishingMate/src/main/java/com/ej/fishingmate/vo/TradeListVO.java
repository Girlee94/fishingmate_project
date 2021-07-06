package com.ej.fishingmate.vo;

public class TradeListVO {
	
	private int trade_list_no; 
	private int trade_freeboard_no;
	private int member_no;
	private String trade_list_phone;
	private String trade_list_content;
    private String trade_list_approve;
    
    public TradeListVO() {
		// TODO Auto-generated constructor stub
	}

	public TradeListVO(int trade_list_no, int trade_freeboard_no, int member_no, String trade_list_phone,
			String trade_list_content, String trade_list_approve) {
		super();
		this.trade_list_no = trade_list_no;
		this.trade_freeboard_no = trade_freeboard_no;
		this.member_no = member_no;
		this.trade_list_phone = trade_list_phone;
		this.trade_list_content = trade_list_content;
		this.trade_list_approve = trade_list_approve;
	}

	public int getTrade_list_no() {
		return trade_list_no;
	}

	public void setTrade_list_no(int trade_list_no) {
		this.trade_list_no = trade_list_no;
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

	public String getTrade_list_phone() {
		return trade_list_phone;
	}

	public void setTrade_list_phone(String trade_list_phone) {
		this.trade_list_phone = trade_list_phone;
	}

	public String getTrade_list_content() {
		return trade_list_content;
	}

	public void setTrade_list_content(String trade_list_content) {
		this.trade_list_content = trade_list_content;
	}

	public String getTrade_list_approve() {
		return trade_list_approve;
	}

	public void setTrade_list_approve(String trade_list_approve) {
		this.trade_list_approve = trade_list_approve;
	}
    
    
}