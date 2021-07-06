package com.ej.fishingmate.vo;

import java.util.Date;

public class MateGroupVO {
	private int mate_group_no;
	private int member_no;
	private int mate_freeboard_no;
	private String mate_content;
	private String mate_approve;
	private Date mate_requestdate;
	
	public MateGroupVO() {
		// TODO Auto-generated constructor stub
	}

	public MateGroupVO(int mate_group_no, int member_no, int mate_freeboard_no, String mate_content, String mate_approve,
			Date mate_requestdate) {
		super();
		this.mate_group_no = mate_group_no;
		this.member_no = member_no;
		this.mate_freeboard_no = mate_freeboard_no;
		this.mate_content = mate_content;
		this.mate_approve = mate_approve;
		this.mate_requestdate = mate_requestdate;
	}

	public int getMate_group_no() {
		return mate_group_no;
	}

	public void setMate_group_no(int mate_group_no) {
		this.mate_group_no = mate_group_no;
	}

	public int getMember_no() {
		return member_no;
	}

	public void setMember_no(int member_no) {
		this.member_no = member_no;
	}

	public int getMate_freeboard_no() {
		return mate_freeboard_no;
	}

	public void setMate_freeboard_no(int mate_freeboard_no) {
		this.mate_freeboard_no = mate_freeboard_no;
	}

	public String getMate_content() {
		return mate_content;
	}

	public void setMate_content(String mate_content) {
		this.mate_content = mate_content;
	}

	public String getMate_approve() {
		return mate_approve;
	}

	public void setMate_approve(String mate_approve) {
		this.mate_approve = mate_approve;
	}

	public Date getMate_requestdate() {
		return mate_requestdate;
	}

	public void setMate_requestdate(Date mate_requestdate) {
		this.mate_requestdate = mate_requestdate;
	}
}
