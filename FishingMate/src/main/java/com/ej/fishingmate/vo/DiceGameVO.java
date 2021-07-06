package com.ej.fishingmate.vo;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

public class DiceGameVO {
	
	private int dice_no;
	private int member_no;
	private int batting_kinds;
	private String dice_allone;
	private int dice_sum;
	private int dice_value;
	private Date dice_date;
	
	public DiceGameVO() {
		
	}

	public DiceGameVO(int dice_no, int member_no, int batting_kinds, String dice_allone, int dice_sum, int dice_value,
			Date dice_date) {
		super();
		this.dice_no = dice_no;
		this.member_no = member_no;
		this.batting_kinds = batting_kinds;
		this.dice_allone = dice_allone;
		this.dice_sum = dice_sum;
		this.dice_value = dice_value;
		this.dice_date = dice_date;
	}

	public int getDice_no() {
		return dice_no;
	}

	public void setDice_no(int dice_no) {
		this.dice_no = dice_no;
	}

	public int getMember_no() {
		return member_no;
	}

	public void setMember_no(int member_no) {
		this.member_no = member_no;
	}

	public int getBatting_kinds() {
		return batting_kinds;
	}

	public void setBatting_kinds(int batting_kinds) {
		this.batting_kinds = batting_kinds;
	}

	public String getDice_allone() {
		return dice_allone;
	}

	public void setDice_allone(String dice_allone) {
		this.dice_allone = dice_allone;
	}

	public int getDice_sum() {
		return dice_sum;
	}

	public void setDice_sum(int dice_sum) {
		this.dice_sum = dice_sum;
	}

	public int getDice_value() {
		return dice_value;
	}

	public void setDice_value(int dice_value) {
		this.dice_value = dice_value;
	}

	public Date getDice_date() {
		return dice_date;
	}

	public void setDice_date(Date dice_date) {
		this.dice_date = dice_date;
	}
	

}
