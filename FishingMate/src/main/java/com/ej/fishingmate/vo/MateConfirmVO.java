package com.ej.fishingmate.vo;

public class MateConfirmVO {
	private int mate_confirm_no;
	private int mate_freeboard_no;
	private int member_no;
	
	public MateConfirmVO() {
		// TODO Auto-generated constructor stub
	}

	public MateConfirmVO(int mate_confirm_no, int mate_freeboard_no, int member_no) {
		super();
		this.mate_confirm_no = mate_confirm_no;
		this.mate_freeboard_no = mate_freeboard_no;
		this.member_no = member_no;
	}

	public int getMate_confirm_no() {
		return mate_confirm_no;
	}

	public void setMate_confirm_no(int mate_confirm_no) {
		this.mate_confirm_no = mate_confirm_no;
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
}
