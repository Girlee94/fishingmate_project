package com.ej.fishingmate.vo;

public class MateEvaluateVO {
	private int evaluate_no;
	private int mate_confirm_no;
	private int to_member_no;
	private int from_member_no;
	private double evaluate_value;
	private String evaluate_content;
	
	public MateEvaluateVO() {
		// TODO Auto-generated constructor stub
	}

	public MateEvaluateVO(int evaluate_no, int mate_confirm_no, int to_member_no, int from_member_no,
			double evaluate_value, String evaluate_content) {
		super();
		this.evaluate_no = evaluate_no;
		this.mate_confirm_no = mate_confirm_no;
		this.to_member_no = to_member_no;
		this.from_member_no = from_member_no;
		this.evaluate_value = evaluate_value;
		this.evaluate_content = evaluate_content;
	}

	public int getEvaluate_no() {
		return evaluate_no;
	}

	public void setEvaluate_no(int evaluate_no) {
		this.evaluate_no = evaluate_no;
	}

	public int getMate_confirm_no() {
		return mate_confirm_no;
	}

	public void setMate_confirm_no(int mate_confirm_no) {
		this.mate_confirm_no = mate_confirm_no;
	}

	public int getTo_member_no() {
		return to_member_no;
	}

	public void setTo_member_no(int to_member_no) {
		this.to_member_no = to_member_no;
	}

	public int getFrom_member_no() {
		return from_member_no;
	}

	public void setFrom_member_no(int from_member_no) {
		this.from_member_no = from_member_no;
	}

	public double getEvaluate_value() {
		return evaluate_value;
	}

	public void setEvaluate_value(double evaluate_value) {
		this.evaluate_value = evaluate_value;
	}

	public String getEvaluate_content() {
		return evaluate_content;
	}

	public void setEvaluate_content(String evaluate_content) {
		this.evaluate_content = evaluate_content;
	}
}
