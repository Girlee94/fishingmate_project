package com.ej.fishingmate.vo;

import java.util.Date;

public class InfoFreeboardRecommendVO {

	private int info_recommend_no;
	private int info_freeboard_no;
	private int member_no;
	private Date info_recommend_date;
	public InfoFreeboardRecommendVO() {
		super();
	}
	public InfoFreeboardRecommendVO(int info_recommend_no, int info_freeboard_no, int member_no,
			Date info_recommend_date) {
		super();
		this.info_recommend_no = info_recommend_no;
		this.info_freeboard_no = info_freeboard_no;
		this.member_no = member_no;
		this.info_recommend_date = info_recommend_date;
	}
	public int getInfo_recommend_no() {
		return info_recommend_no;
	}
	public void setInfo_recommend_no(int info_recommend_no) {
		this.info_recommend_no = info_recommend_no;
	}
	public int getInfo_freeboard_no() {
		return info_freeboard_no;
	}
	public void setInfo_freeboard_no(int info_freeboard_no) {
		this.info_freeboard_no = info_freeboard_no;
	}
	public int getMember_no() {
		return member_no;
	}
	public void setMember_no(int member_no) {
		this.member_no = member_no;
	}
	public Date getInfo_recommend_date() {
		return info_recommend_date;
	}
	public void setInfo_recommend_date(Date info_recommend_date) {
		this.info_recommend_date = info_recommend_date;
	}
	
}
