package com.ej.fishingmate.vo;

import java.util.Date;

public class MateFreeboardCommentVO {
	private int mate_comment_no;
	private int mate_freeboard_no;
	private int member_no;
	private String mate_comment_content;
	private Date mate_comment_writedate;
	
	public MateFreeboardCommentVO() {
		// TODO Auto-generated constructor stub
	}

	public MateFreeboardCommentVO(int mate_comment_no, int mate_freeboard_no, int member_no,
			String mate_comment_content, Date mate_comment_writedate) {
		super();
		this.mate_comment_no = mate_comment_no;
		this.mate_freeboard_no = mate_freeboard_no;
		this.member_no = member_no;
		this.mate_comment_content = mate_comment_content;
		this.mate_comment_writedate = mate_comment_writedate;
	}

	public int getMate_comment_no() {
		return mate_comment_no;
	}

	public void setMate_comment_no(int mate_comment_no) {
		this.mate_comment_no = mate_comment_no;
	}

	public int getMate_freeboard_no() {
		return mate_freeboard_no;
	}

	public void setMate_freeboard_no(int mate_freeboard_no) {
		this.mate_freeboard_no = mate_freeboard_no;
	}

	public int getMember_no() {
		return member_no;
	}

	public void setMember_no(int member_no) {
		this.member_no = member_no;
	}

	public String getMate_comment_content() {
		return mate_comment_content;
	}

	public void setMate_comment_content(String mate_comment_content) {
		this.mate_comment_content = mate_comment_content;
	}

	public Date getMate_comment_writedate() {
		return mate_comment_writedate;
	}

	public void setMate_comment_writedate(Date mate_comment_writedate) {
		this.mate_comment_writedate = mate_comment_writedate;
	}
}
