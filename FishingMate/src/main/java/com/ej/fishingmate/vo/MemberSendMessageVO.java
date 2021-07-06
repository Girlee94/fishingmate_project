package com.ej.fishingmate.vo;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

public class MemberSendMessageVO {

	 private int sendmessage_no;
	 private int from_member_no;
	 private int to_member_no;
	 private String message_content;
	 @DateTimeFormat(pattern = "yyyy-MM-dd")
	 private Date message_senddate; 
	 @DateTimeFormat(pattern = "yyyy-MM-dd")
	 private Date message_readdate;
	 private String message_readcheck;
	
	 public MemberSendMessageVO() {
		super();
	}

	public MemberSendMessageVO(int sendmessage_no, int from_member_no, int to_member_no, String message_content,
			Date message_senddate, Date message_readdate, String message_readcheck) {
		super();
		this.sendmessage_no = sendmessage_no;
		this.from_member_no = from_member_no;
		this.to_member_no = to_member_no;
		this.message_content = message_content;
		this.message_senddate = message_senddate;
		this.message_readdate = message_readdate;
		this.message_readcheck = message_readcheck;
	}

	public int getSendmessage_no() {
		return sendmessage_no;
	}

	public void setSendmessage_no(int sendmessage_no) {
		this.sendmessage_no = sendmessage_no;
	}

	public int getFrom_member_no() {
		return from_member_no;
	}

	public void setFrom_member_no(int from_member_no) {
		this.from_member_no = from_member_no;
	}

	public int getTo_member_no() {
		return to_member_no;
	}

	public void setTo_member_no(int to_member_no) {
		this.to_member_no = to_member_no;
	}

	public String getMessage_content() {
		return message_content;
	}

	public void setMessage_content(String message_content) {
		this.message_content = message_content;
	}

	public Date getMessage_senddate() {
		return message_senddate;
	}

	public void setMessage_senddate(Date message_senddate) {
		this.message_senddate = message_senddate;
	}

	public Date getMessage_readdate() {
		return message_readdate;
	}

	public void setMessage_readdate(Date message_readdate) {
		this.message_readdate = message_readdate;
	}

	public String getMessage_readcheck() {
		return message_readcheck;
	}

	public void setMessage_readcheck(String message_readcheck) {
		this.message_readcheck = message_readcheck;
	}

	
	  
	 
}
