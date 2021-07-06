package com.ej.fishingmate.vo;

import java.util.Date;

public class InfoFreeboardCommentVO {

	private int info_comment_no;
	private int info_freeboard_no;
	private int member_no;
	private String info_comment_content;
	private Date info_comment_writedate;
	public InfoFreeboardCommentVO() {
		super();
	}
	public InfoFreeboardCommentVO(int info_comment_no, int info_freeboard_no, int member_no, String info_comment_content,
			Date info_comment_writedate) {
		super();
		this.info_comment_no = info_comment_no;
		this.info_freeboard_no = info_freeboard_no;
		this.member_no = member_no;
		this.info_comment_content = info_comment_content;
		this.info_comment_writedate = info_comment_writedate;
	}
	public int getInfo_comment_no() {
		return info_comment_no;
	}
	public void setInfo_comment_no(int info_comment_no) {
		this.info_comment_no = info_comment_no;
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
	public String getInfo_comment_content() {
		return info_comment_content;
	}
	public void setInfo_comment_content(String info_comment_content) {
		this.info_comment_content = info_comment_content;
	}
	public Date getInfo_comment_writedate() {
		return info_comment_writedate;
	}
	public void setInfo_comment_writedate(Date info_comment_writedate) {
		this.info_comment_writedate = info_comment_writedate;
	}
	
	
	
	
}
