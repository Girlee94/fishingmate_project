package com.ej.fishingmate.vo;

import java.util.Date;

public class InfoFreeboardVO {

	private int info_freeboard_no;
	private int member_no;
	private int info_category_no;
	private String info_freeboard_title;
	private String info_freeboard_content;
	private int info_freeboard_readcount;
	private Date info_freeboard_writedate;

	public InfoFreeboardVO() {
		super();
	}
	
	
	public InfoFreeboardVO(int info_freeboard_no, int member_no, int info_category_no, String info_freeboard_title,
			String info_freeboard_content, int info_freeboard_readcount, Date info_freeboard_writedate) {
		super();
		this.info_freeboard_no = info_freeboard_no;
		this.member_no = member_no;
		this.info_category_no = info_category_no;
		this.info_freeboard_title = info_freeboard_title;
		this.info_freeboard_content = info_freeboard_content;
		this.info_freeboard_readcount = info_freeboard_readcount;
		this.info_freeboard_writedate = info_freeboard_writedate;
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


	public int getInfo_category_no() {
		return info_category_no;
	}


	public void setInfo_category_no(int info_category_no) {
		this.info_category_no = info_category_no;
	}


	public String getInfo_freeboard_title() {
		return info_freeboard_title;
	}


	public void setInfo_freeboard_title(String info_freeboard_title) {
		this.info_freeboard_title = info_freeboard_title;
	}


	public String getInfo_freeboard_content() {
		return info_freeboard_content;
	}


	public void setInfo_freeboard_content(String info_freeboard_content) {
		this.info_freeboard_content = info_freeboard_content;
	}


	public int getInfo_freeboard_readcount() {
		return info_freeboard_readcount;
	}


	public void setInfo_freeboard_readcount(int info_freeboard_readcount) {
		this.info_freeboard_readcount = info_freeboard_readcount;
	}


	public Date getInfo_freeboard_writedate() {
		return info_freeboard_writedate;
	}


	public void setInfo_freeboard_writedate(Date info_freeboard_writedate) {
		this.info_freeboard_writedate = info_freeboard_writedate;
	}
	
	
	
}
