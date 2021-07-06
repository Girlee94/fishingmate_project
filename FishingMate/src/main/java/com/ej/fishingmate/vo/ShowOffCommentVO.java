package com.ej.fishingmate.vo;

import java.util.Date;

public class ShowOffCommentVO {
	private int showoff_comment_no;
	private int showoff_freeboard_no;
	private int member_no;
	private String showoff_comment_content;
	private Date showoff_comment_writedate;
	
	public ShowOffCommentVO() {
		super();
		// TODO Auto-generated constructor stub
	}
	public ShowOffCommentVO(int showoff_comment_no, int showoff_freeboard_no, int member_no,
			String showoff_comment_content, Date showoff_comment_writedate) {
		super();
		this.showoff_comment_no = showoff_comment_no;
		this.showoff_freeboard_no = showoff_freeboard_no;
		this.member_no = member_no;
		this.showoff_comment_content = showoff_comment_content;
		this.showoff_comment_writedate = showoff_comment_writedate;
	}
	public int getShowoff_comment_no() {
		return showoff_comment_no;
	}
	public void setShowoff_comment_no(int showoff_comment_no) {
		this.showoff_comment_no = showoff_comment_no;
	}
	public int getShowoff_freeboard_no() {
		return showoff_freeboard_no;
	}
	public void setShowoff_freeboard_no(int showoff_freeboard_no) {
		this.showoff_freeboard_no = showoff_freeboard_no;
	}
	public int getMember_no() {
		return member_no;
	}
	public void setMember_no(int member_no) {
		this.member_no = member_no;
	}
	public String getShowoff_comment_content() {
		return showoff_comment_content;
	}
	public void setShowoff_comment_content(String showoff_comment_content) {
		this.showoff_comment_content = showoff_comment_content;
	}
	public Date getShowoff_comment_writedate() {
		return showoff_comment_writedate;
	}
	public void setShowoff_comment_writedate(Date showoff_comment_writedate) {
		this.showoff_comment_writedate = showoff_comment_writedate;
	}
}
