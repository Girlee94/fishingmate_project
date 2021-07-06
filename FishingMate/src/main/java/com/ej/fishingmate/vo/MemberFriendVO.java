package com.ej.fishingmate.vo;

import java.util.Date;

public class MemberFriendVO {

	private int friend_no;
    private int friend_group_no;
    private int me_no;
    private int you_no;
    private String friend_confirm;
    private Date friend_adddate;
	
    public MemberFriendVO() {
		super();
	}

	public MemberFriendVO(int friend_no, int friend_group_no, int me_no, int you_no, String friend_confirm,
			Date friend_adddate) {
		super();
		this.friend_no = friend_no;
		this.friend_group_no = friend_group_no;
		this.me_no = me_no;
		this.you_no = you_no;
		this.friend_confirm = friend_confirm;
		this.friend_adddate = friend_adddate;
	}

	public int getFriend_no() {
		return friend_no;
	}

	public void setFriend_no(int friend_no) {
		this.friend_no = friend_no;
	}

	public int getFriend_group_no() {
		return friend_group_no;
	}

	public void setFriend_group_no(int friend_group_no) {
		this.friend_group_no = friend_group_no;
	}

	public int getMe_no() {
		return me_no;
	}

	public void setMe_no(int me_no) {
		this.me_no = me_no;
	}

	public int getYou_no() {
		return you_no;
	}

	public void setYou_no(int you_no) {
		this.you_no = you_no;
	}

	public String getFriend_confirm() {
		return friend_confirm;
	}

	public void setFriend_confirm(String friend_confirm) {
		this.friend_confirm = friend_confirm;
	}

	public Date getFriend_adddate() {
		return friend_adddate;
	}

	public void setFriend_adddate(Date friend_adddate) {
		this.friend_adddate = friend_adddate;
	}

	     
    
}
