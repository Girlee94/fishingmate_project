package com.ej.fishingmate.vo;

import java.util.Date;

public class LottoServerVO {

	private int lotto_round;
	private int lotto_num1;
	private int lotto_num2;
	private int lotto_num3;
	private int lotto_num4;
	private int lotto_num5;
	private int lotto_num6;
	private Date lotto_round_date;
	public LottoServerVO() {
		super();
	}
	public LottoServerVO(int lotto_round, int lotto_num1, int lotto_num2, int lotto_num3, int lotto_num4,
			int lotto_num5, int lotto_num6, Date lotto_round_date) {
		super();
		this.lotto_round = lotto_round;
		this.lotto_num1 = lotto_num1;
		this.lotto_num2 = lotto_num2;
		this.lotto_num3 = lotto_num3;
		this.lotto_num4 = lotto_num4;
		this.lotto_num5 = lotto_num5;
		this.lotto_num6 = lotto_num6;
		this.lotto_round_date = lotto_round_date;
	}
	public int getLotto_round() {
		return lotto_round;
	}
	public void setLotto_round(int lotto_round) {
		this.lotto_round = lotto_round;
	}
	public int getLotto_num1() {
		return lotto_num1;
	}
	public void setLotto_num1(int lotto_num1) {
		this.lotto_num1 = lotto_num1;
	}
	public int getLotto_num2() {
		return lotto_num2;
	}
	public void setLotto_num2(int lotto_num2) {
		this.lotto_num2 = lotto_num2;
	}
	public int getLotto_num3() {
		return lotto_num3;
	}
	public void setLotto_num3(int lotto_num3) {
		this.lotto_num3 = lotto_num3;
	}
	public int getLotto_num4() {
		return lotto_num4;
	}
	public void setLotto_num4(int lotto_num4) {
		this.lotto_num4 = lotto_num4;
	}
	public int getLotto_num5() {
		return lotto_num5;
	}
	public void setLotto_num5(int lotto_num5) {
		this.lotto_num5 = lotto_num5;
	}
	public int getLotto_num6() {
		return lotto_num6;
	}
	public void setLotto_num6(int lotto_num6) {
		this.lotto_num6 = lotto_num6;
	}
	public Date getLotto_round_date() {
		return lotto_round_date;
	}
	public void setLotto_round_date(Date lotto_round_date) {
		this.lotto_round_date = lotto_round_date;
	}
	
	
	
	
}
