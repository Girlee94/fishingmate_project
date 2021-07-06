package com.ej.fishingmate.vo;

import java.util.Date;

public class MemberEvaluateVO {
	private int member_evaluate_no;
	private int member_no;
	private double member_evaluate_value;
	private Date evaluate;
	
	public MemberEvaluateVO() {
		// TODO Auto-generated constructor stub
	}

	public MemberEvaluateVO(int member_evaluate_no, int member_no, double member_evaluate_value, Date evaluate) {
		super();
		this.member_evaluate_no = member_evaluate_no;
		this.member_no = member_no;
		this.member_evaluate_value = member_evaluate_value;
		this.evaluate = evaluate;
	}

	public int getMember_evaluate_no() {
		return member_evaluate_no;
	}

	public void setMember_evaluate_no(int member_evaluate_no) {
		this.member_evaluate_no = member_evaluate_no;
	}

	public int getMember_no() {
		return member_no;
	}

	public void setMember_no(int member_no) {
		this.member_no = member_no;
	}

	public double getMember_evaluate_value() {
		return member_evaluate_value;
	}

	public void setMember_evaluate_value(double member_evaluate_value) {
		this.member_evaluate_value = member_evaluate_value;
	}

	public Date getEvaluate() {
		return evaluate;
	}

	public void setEvaluate(Date evaluate) {
		this.evaluate = evaluate;
	}
}
