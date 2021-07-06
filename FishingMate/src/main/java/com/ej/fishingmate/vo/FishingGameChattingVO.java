package com.ej.fishingmate.vo;

import java.util.Date;

public class FishingGameChattingVO {
	private int chatting_no;
	private int member_no;
	private String chatting_content;
	private Date chatting_writedate;
	
	public FishingGameChattingVO() {
		// TODO Auto-generated constructor stub
	}

	public FishingGameChattingVO(int chatting_no, int member_no, String chatting_content, Date chatting_writedate) {
		super();
		this.chatting_no = chatting_no;
		this.member_no = member_no;
		this.chatting_content = chatting_content;
		this.chatting_writedate = chatting_writedate;
	}

	public int getChatting_no() {
		return chatting_no;
	}

	public void setChatting_no(int chatting_no) {
		this.chatting_no = chatting_no;
	}

	public int getMember_no() {
		return member_no;
	}

	public void setMember_no(int member_no) {
		this.member_no = member_no;
	}

	public String getChatting_content() {
		return chatting_content;
	}

	public void setChatting_content(String chatting_content) {
		this.chatting_content = chatting_content;
	}

	public Date getChatting_writedate() {
		return chatting_writedate;
	}

	public void setChatting_writedate(Date chatting_writedate) {
		this.chatting_writedate = chatting_writedate;
	}
}
