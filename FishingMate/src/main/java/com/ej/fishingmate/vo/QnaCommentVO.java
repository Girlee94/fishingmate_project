package com.ej.fishingmate.vo;

import java.util.Date;

public class QnaCommentVO {
	
	private int qna_comment_no;
	private int qna_freeboard_no;
	private int member_no;
	private int manager_no;
	private String qna_comment_content;
	private Date qna_comment_writedate;
	public QnaCommentVO() {
		super();
	}
	public QnaCommentVO(int qna_comment_no, int qna_freeboard_no, int member_no, int manager_no,
			String qna_comment_content, Date qna_comment_writedate) {
		super();
		this.qna_comment_no = qna_comment_no;
		this.qna_freeboard_no = qna_freeboard_no;
		this.member_no = member_no;
		this.manager_no = manager_no;
		this.qna_comment_content = qna_comment_content;
		this.qna_comment_writedate = qna_comment_writedate;
	}
	public int getQna_comment_no() {
		return qna_comment_no;
	}
	public void setQna_comment_no(int qna_comment_no) {
		this.qna_comment_no = qna_comment_no;
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
	public int getManager_no() {
		return manager_no;
	}
	public void setManager_no(int manager_no) {
		this.manager_no = manager_no;
	}
	public String getQna_comment_content() {
		return qna_comment_content;
	}
	public void setQna_comment_content(String qna_comment_content) {
		this.qna_comment_content = qna_comment_content;
	}
	public Date getQna_comment_writedate() {
		return qna_comment_writedate;
	}
	public void setQna_comment_writedate(Date qna_comment_writedate) {
		this.qna_comment_writedate = qna_comment_writedate;
	}

	
}
