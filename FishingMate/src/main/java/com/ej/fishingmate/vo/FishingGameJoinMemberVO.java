package com.ej.fishingmate.vo;

import java.util.Date;

public class FishingGameJoinMemberVO {
	private int joinmember_no;
	private int member_no;
	private Date joinmember_joindate;
	
	public FishingGameJoinMemberVO() {
		// TODO Auto-generated constructor stub
	}

	public FishingGameJoinMemberVO(int joinmember_no, int member_no, Date joinmember_joindate) {
		super();
		this.joinmember_no = joinmember_no;
		this.member_no = member_no;
		this.joinmember_joindate = joinmember_joindate;
	}

	public int getJoinmember_no() {
		return joinmember_no;
	}

	public void setJoinmember_no(int joinmember_no) {
		this.joinmember_no = joinmember_no;
	}

	public int getMember_no() {
		return member_no;
	}

	public void setMember_no(int member_no) {
		this.member_no = member_no;
	}

	public Date getJoinmember_joindate() {
		return joinmember_joindate;
	}

	public void setJoinmember_joindate(Date joinmember_joindate) {
		this.joinmember_joindate = joinmember_joindate;
	}
}
