package com.ej.fishingmate.vo;

public class LottoVO {

	private int lotto_number;
	private int lotto_no;
	
	

	public LottoVO(int lotto_number, int lotto_no) {
		super();
		this.lotto_number = lotto_number;
		this.lotto_no = lotto_no;
	}
	public LottoVO() {
		super();
	}
	public int getLotto_number() {
		return lotto_number;
	}
	public void setLotto_number(int lotto_number) {
		this.lotto_number = lotto_number;
	}
	public int getLotto_no() {
		return lotto_no;
	}
	public void setLotto_no(int lotto_no) {
		this.lotto_no = lotto_no;
	}
	
}
