package com.ej.fishingmate.vo;

public class LottoUserVO {

private int lotto_no;
private int lotto_round;
private int member_no;
private int lotto_num1;
private int lotto_num2;
private int lotto_num3;
private int lotto_num4;
private int lotto_num5;
private int lotto_num6;
private int lotto_batting_value;
private int won_sutza;
private int won;
public LottoUserVO() {
	super();
}
public LottoUserVO(int lotto_no, int lotto_round, int member_no, int lotto_num1, int lotto_num2, int lotto_num3,
		int lotto_num4, int lotto_num5, int lotto_num6, int lotto_batting_value, int won_sutza, int won) {
	super();
	this.lotto_no = lotto_no;
	this.lotto_round = lotto_round;
	this.member_no = member_no;
	this.lotto_num1 = lotto_num1;
	this.lotto_num2 = lotto_num2;
	this.lotto_num3 = lotto_num3;
	this.lotto_num4 = lotto_num4;
	this.lotto_num5 = lotto_num5;
	this.lotto_num6 = lotto_num6;
	this.lotto_batting_value = lotto_batting_value;
	this.won_sutza = won_sutza;
	this.won = won;
}
public int getLotto_no() {
	return lotto_no;
}
public void setLotto_no(int lotto_no) {
	this.lotto_no = lotto_no;
}
public int getLotto_round() {
	return lotto_round;
}
public void setLotto_round(int lotto_round) {
	this.lotto_round = lotto_round;
}
public int getMember_no() {
	return member_no;
}
public void setMember_no(int member_no) {
	this.member_no = member_no;
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
public int getLotto_batting_value() {
	return lotto_batting_value;
}
public void setLotto_batting_value(int lotto_batting_value) {
	this.lotto_batting_value = lotto_batting_value;
}
public int getWon_sutza() {
	return won_sutza;
}
public void setWon_sutza(int won_sutza) {
	this.won_sutza = won_sutza;
}
public int getWon() {
	return won;
}
public void setWon(int won) {
	this.won = won;
}


}