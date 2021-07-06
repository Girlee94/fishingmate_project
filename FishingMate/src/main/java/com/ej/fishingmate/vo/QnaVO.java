package com.ej.fishingmate.vo;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

public class QnaVO {
	
	private int qna_freeboard_no;
	private int member_no;
	private int qna_category_no;
	private String qna_freeboard_title;
	private String qna_freeboard_content;
	private String qna_freeboard_pw;
	private int qna_freeboard_readcount;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date qna_freeboard_writedate;
	
	public QnaVO() {
		super();
	}

	public QnaVO(int qna_freeboard_no, int member_no, int qna_category_no, String qna_freeboard_title,
			String qna_freeboard_content, String qna_freeboard_pw, int qna_freeboard_readcount,
			Date qna_freeboard_writedate) {
		super();
		this.qna_freeboard_no = qna_freeboard_no;
		this.member_no = member_no;
		this.qna_category_no = qna_category_no;
		this.qna_freeboard_title = qna_freeboard_title;
		this.qna_freeboard_content = qna_freeboard_content;
		this.qna_freeboard_pw = qna_freeboard_pw;
		this.qna_freeboard_readcount = qna_freeboard_readcount;
		this.qna_freeboard_writedate = qna_freeboard_writedate;
	}

	public int getQna_freeboard_no() {
		return qna_freeboard_no;
	}

	public void setQna_freeboard_no(int qna_freeboard_no) {
		this.qna_freeboard_no = qna_freeboard_no;
	}

	public int getMember_no() {
		return member_no;
	}

	public void setMember_no(int member_no) {
		this.member_no = member_no;
	}

	public int getQna_category_no() {
		return qna_category_no;
	}

	public void setQna_category_no(int qna_category_no) {
		this.qna_category_no = qna_category_no;
	}

	public String getQna_freeboard_title() {
		return qna_freeboard_title;
	}

	public void setQna_freeboard_title(String qna_freeboard_title) {
		this.qna_freeboard_title = qna_freeboard_title;
	}

	public String getQna_freeboard_content() {
		return qna_freeboard_content;
	}

	public void setQna_freeboard_content(String qna_freeboard_content) {
		this.qna_freeboard_content = qna_freeboard_content;
	}

	public String getQna_freeboard_pw() {
		return qna_freeboard_pw;
	}

	public void setQna_freeboard_pw(String qna_freeboard_pw) {
		this.qna_freeboard_pw = qna_freeboard_pw;
	}

	public int getQna_freeboard_readcount() {
		return qna_freeboard_readcount;
	}

	public void setQna_freeboard_readcount(int qna_freeboard_readcount) {
		this.qna_freeboard_readcount = qna_freeboard_readcount;
	}

	public Date getQna_freeboard_writedate() {
		return qna_freeboard_writedate;
	}

	public void setQna_freeboard_writedate(Date qna_freeboard_writedate) {
		this.qna_freeboard_writedate = qna_freeboard_writedate;
	}
	
	
}
