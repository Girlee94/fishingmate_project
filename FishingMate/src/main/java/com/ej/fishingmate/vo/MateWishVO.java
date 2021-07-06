package com.ej.fishingmate.vo;

public class MateWishVO {
	private int mate_wish_no;
	private int member_no;
	private int mate_freeboard_no;
	
	public MateWishVO() {
		// TODO Auto-generated constructor stub
	}

	public MateWishVO(int mate_wish_no, int member_no, int mate_freeboard_no) {
		super();
		this.mate_wish_no = mate_wish_no;
		this.member_no = member_no;
		this.mate_freeboard_no = mate_freeboard_no;
	}

	public int getMate_wish_no() {
		return mate_wish_no;
	}

	public void setMate_wish_no(int mate_wish_no) {
		this.mate_wish_no = mate_wish_no;
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
}
