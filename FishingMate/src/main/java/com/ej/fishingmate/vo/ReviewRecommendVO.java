package com.ej.fishingmate.vo;

import java.util.Date;

public class ReviewRecommendVO {
	
	private int review_recommend_no;
	private int review_freeboard_no;
	private int member_no;
	private Date review_recommend_date;
	
	public ReviewRecommendVO() {
		super();
	}

	public ReviewRecommendVO(int review_recommend_no, int review_freeboard_no, int member_no,
			Date review_recommend_date) {
		super();
		this.review_recommend_no = review_recommend_no;
		this.review_freeboard_no = review_freeboard_no;
		this.member_no = member_no;
		this.review_recommend_date = review_recommend_date;
	}

	public int getReview_recommend_no() {
		return review_recommend_no;
	}

	public void setReview_recommend_no(int review_recommend_no) {
		this.review_recommend_no = review_recommend_no;
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

	public Date getReview_recommend_date() {
		return review_recommend_date;
	}

	public void setReview_recommend_date(Date review_recommend_date) {
		this.review_recommend_date = review_recommend_date;
	}
	
	
}
