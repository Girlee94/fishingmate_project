package com.ej.fishingmate.vo;

import java.util.Date;

public class ManagerVO {

	private int manager_no;
	private int grade_no;
	private String manager_id;
	private String manager_pw;
	private String manager_name;
	private String manager_nick;
	private String manager_phone;
	private String manager_email;
	private Date manager_register;
	
	public ManagerVO() {
		super();
	}

	public ManagerVO(int manager_no, int grade_no, String manager_id, String manager_pw, String manager_name,
			String manager_nick, String manager_phone, String manager_email, Date manager_register) {
		super();
		this.manager_no = manager_no;
		this.grade_no = grade_no;
		this.manager_id = manager_id;
		this.manager_pw = manager_pw;
		this.manager_name = manager_name;
		this.manager_nick = manager_nick;
		this.manager_phone = manager_phone;
		this.manager_email = manager_email;
		this.manager_register = manager_register;
	}

	public int getManager_no() {
		return manager_no;
	}

	public void setManager_no(int manager_no) {
		this.manager_no = manager_no;
	}

	public int getGrade_no() {
		return grade_no;
	}

	public void setGrade_no(int grade_no) {
		this.grade_no = grade_no;
	}

	public String getManager_id() {
		return manager_id;
	}

	public void setManager_id(String manager_id) {
		this.manager_id = manager_id;
	}

	public String getManager_pw() {
		return manager_pw;
	}

	public void setManager_pw(String manager_pw) {
		this.manager_pw = manager_pw;
	}

	public String getManager_name() {
		return manager_name;
	}

	public void setManager_name(String manager_name) {
		this.manager_name = manager_name;
	}

	public String getManager_nick() {
		return manager_nick;
	}

	public void setManager_nick(String manager_nick) {
		this.manager_nick = manager_nick;
	}

	public String getManager_phone() {
		return manager_phone;
	}

	public void setManager_phone(String manager_phone) {
		this.manager_phone = manager_phone;
	}

	public String getManager_email() {
		return manager_email;
	}

	public void setManager_email(String manager_email) {
		this.manager_email = manager_email;
	}

	public Date getManager_register() {
		return manager_register;
	}

	public void setManager_register(Date manager_register) {
		this.manager_register = manager_register;
	}
	
	
}
