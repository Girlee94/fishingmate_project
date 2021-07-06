package com.ej.fishingmate.vo;

import java.util.Date;

public class ReviewCommentVO {
	
	private int review_comment_no;
	private int review_freeboard_no;
	private int member_no;
	private String review_comment_content;
	private Date review_comment_writedate;
	
	public ReviewCommentVO() {
		super();
	}

	public ReviewCommentVO(int review_comment_no, int review_freeboard_no, int member_no, String review_comment_content,
			Date review_comment_writedate) {
		super();
		this.review_comment_no = review_comment_no;
		this.review_freeboard_no = review_freeboard_no;
		this.member_no = member_no;
		this.review_comment_content = review_comment_content;
		this.review_comment_writedate = review_comment_writedate;
	}

	public int getReview_comment_no() {
		return review_comment_no;
	}

	public void setReview_comment_no(int review_comment_no) {
		this.review_comment_no = review_comment_no;
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

	public String getReview_comment_content() {
		return review_comment_content;
	}

	public void setReview_comment_content(String review_comment_content) {
		this.review_comment_content = review_comment_content;
	}

	public Date getReview_comment_writedate() {
		return review_comment_writedate;
	}

	public void setReview_comment_writedate(Date review_comment_writedate) {
		this.review_comment_writedate = review_comment_writedate;
	}
	
	
}
