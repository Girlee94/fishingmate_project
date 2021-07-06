package com.ej.fishingmate.vo;

import java.util.Date;

public class ReviewVO {
	
	private int review_freeboard_no;
	private int member_no;
	private String review_freeboard_title;
	private String review_freeboard_content;
	private int review_freeboard_readcount;
	private Date review_writedate;
	
	public ReviewVO() {
		super();
	}

	public ReviewVO(int review_freeboard_no, int member_no, String review_freeboard_title,
			String review_freeboard_content, int review_freeboard_readcount, Date review_writedate) {
		super();
		this.review_freeboard_no = review_freeboard_no;
		this.member_no = member_no;
		this.review_freeboard_title = review_freeboard_title;
		this.review_freeboard_content = review_freeboard_content;
		this.review_freeboard_readcount = review_freeboard_readcount;
		this.review_writedate = review_writedate;
	}

	public int getReview_freeboard_no() {
		return review_freeboard_no;
	}

	public void setReview_freeboard_no(int review_freeboard_no) {
		this.review_freeboard_no = review_freeboard_no;
	}

	public int getMember_no() {
		return member_no;
	}

	public void setMember_no(int member_no) {
		this.member_no = member_no;
	}

	public String getReview_freeboard_title() {
		return review_freeboard_title;
	}

	public void setReview_freeboard_title(String review_freeboard_title) {
		this.review_freeboard_title = review_freeboard_title;
	}

	public String getReview_freeboard_content() {
		return review_freeboard_content;
	}

	public void setReview_freeboard_content(String review_freeboard_content) {
		this.review_freeboard_content = review_freeboard_content;
	}

	public int getReview_freeboard_readcount() {
		return review_freeboard_readcount;
	}

	public void setReview_freeboard_readcount(int review_freeboard_readcount) {
		this.review_freeboard_readcount = review_freeboard_readcount;
	}

	public Date getReview_writedate() {
		return review_writedate;
	}

	public void setReview_writedate(Date review_writedate) {
		this.review_writedate = review_writedate;
	}
	
	
	

}
