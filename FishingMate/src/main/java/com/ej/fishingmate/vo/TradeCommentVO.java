package com.ej.fishingmate.vo;

import java.util.Date;

public class TradeCommentVO {
	
	private int trade_comment_no;
	private int member_no;
	private int trade_freeboard_no;
	private String trade_comment_content;
    private Date trade_comment_writedate;
    
    public TradeCommentVO() {
		// TODO Auto-generated constructor stub
	}

	public TradeCommentVO(int trade_comment_no, int member_no, int trade_freeboard_no, String trade_comment_content,
			Date trade_comment_writedate) {
		super();
		this.trade_comment_no = trade_comment_no;
		this.member_no = member_no;
		this.trade_freeboard_no = trade_freeboard_no;
		this.trade_comment_content = trade_comment_content;
		this.trade_comment_writedate = trade_comment_writedate;
	}

	public int getTrade_comment_no() {
		return trade_comment_no;
	}

	public void setTrade_comment_no(int trade_comment_no) {
		this.trade_comment_no = trade_comment_no;
	}

	public int getMember_no() {
		return member_no;
	}

	public void setMember_no(int member_no) {
		this.member_no = member_no;
	}

	public int getTrade_freeboard_no() {
		return trade_freeboard_no;
	}

	public void setTrade_freeboard_no(int trade_freeboard_no) {
		this.trade_freeboard_no = trade_freeboard_no;
	}

	public String getTrade_comment_content() {
		return trade_comment_content;
	}

	public void setTrade_comment_content(String trade_comment_content) {
		this.trade_comment_content = trade_comment_content;
	}

	public Date getTrade_comment_writedate() {
		return trade_comment_writedate;
	}

	public void setTrade_comment_writedate(Date trade_comment_writedate) {
		this.trade_comment_writedate = trade_comment_writedate;
	}
    
    
    

}
