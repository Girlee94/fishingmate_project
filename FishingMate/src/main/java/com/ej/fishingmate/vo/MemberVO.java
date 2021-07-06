package com.ej.fishingmate.vo;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

public class MemberVO {
	
	private int member_no;
	private int level_no;
	private String member_id;
	private String member_pw;
	private String member_name;
	private String member_nick;
	private String member_gender;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date member_birth;
	private String member_phone;
	private String member_email;
	private Date member_signup;
	private int member_levelvalue;
	private String  member_roadAddress; 
	private String  member_jibunAddress; 
	private String  member_detailAddress; 
	private String  member_extraAddress;
	
	public MemberVO() {
		super();
	}

	public MemberVO(int member_no, int level_no, String member_id, String member_pw, String member_name,
			String member_nick, String member_gender, Date member_birth, String member_phone, String member_email,
			Date member_signup, int member_levelvalue, String member_roadAddress, String member_jibunAddress,
			String member_detailAddress, String member_extraAddress) {
		super();
		this.member_no = member_no;
		this.level_no = level_no;
		this.member_id = member_id;
		this.member_pw = member_pw;
		this.member_name = member_name;
		this.member_nick = member_nick;
		this.member_gender = member_gender;
		this.member_birth = member_birth;
		this.member_phone = member_phone;
		this.member_email = member_email;
		this.member_signup = member_signup;
		this.member_levelvalue = member_levelvalue;
		this.member_roadAddress = member_roadAddress;
		this.member_jibunAddress = member_jibunAddress;
		this.member_detailAddress = member_detailAddress;
		this.member_extraAddress = member_extraAddress;
	}

	public int getMember_no() {
		return member_no;
	}

	public void setMember_no(int member_no) {
		this.member_no = member_no;
	}

	public int getLevel_no() {
		return level_no;
	}

	public void setLevel_no(int level_no) {
		this.level_no = level_no;
	}

	public String getMember_id() {
		return member_id;
	}

	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}

	public String getMember_pw() {
		return member_pw;
	}

	public void setMember_pw(String member_pw) {
		this.member_pw = member_pw;
	}

	public String getMember_name() {
		return member_name;
	}

	public void setMember_name(String member_name) {
		this.member_name = member_name;
	}

	public String getMember_nick() {
		return member_nick;
	}

	public void setMember_nick(String member_nick) {
		this.member_nick = member_nick;
	}

	public String getMember_gender() {
		return member_gender;
	}

	public void setMember_gender(String member_gender) {
		this.member_gender = member_gender;
	}

	public Date getMember_birth() {
		return member_birth;
	}

	public void setMember_birth(Date member_birth) {
		this.member_birth = member_birth;
	}

	public String getMember_phone() {
		return member_phone;
	}

	public void setMember_phone(String member_phone) {
		this.member_phone = member_phone;
	}

	public String getMember_email() {
		return member_email;
	}

	public void setMember_email(String member_email) {
		this.member_email = member_email;
	}

	public Date getMember_signup() {
		return member_signup;
	}

	public void setMember_signup(Date member_signup) {
		this.member_signup = member_signup;
	}

	public int getMember_levelvalue() {
		return member_levelvalue;
	}

	public void setMember_levelvalue(int member_levelvalue) {
		this.member_levelvalue = member_levelvalue;
	}

	public String getMember_roadAddress() {
		return member_roadAddress;
	}

	public void setMember_roadAddress(String member_roadAddress) {
		this.member_roadAddress = member_roadAddress;
	}

	public String getMember_jibunAddress() {
		return member_jibunAddress;
	}

	public void setMember_jibunAddress(String member_jibunAddress) {
		this.member_jibunAddress = member_jibunAddress;
	}

	public String getMember_detailAddress() {
		return member_detailAddress;
	}

	public void setMember_detailAddress(String member_detailAddress) {
		this.member_detailAddress = member_detailAddress;
	}

	public String getMember_extraAddress() {
		return member_extraAddress;
	}

	public void setMember_extraAddress(String member_extraAddress) {
		this.member_extraAddress = member_extraAddress;
	}
	
}