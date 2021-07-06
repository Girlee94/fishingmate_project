package com.ej.fishingmate.vo;

import java.util.Date;

public class MemberFriendGroupVO {

	private int friend_group_no;
    private int member_no;
    private String friend_group_name;
    private Date friend_group_adddate;
	
    public MemberFriendGroupVO() {
		super();
	}

	public MemberFriendGroupVO(int friend_group_no, int member_no, String friend_group_name, Date friend_group_adddate) {
		super();
		this.friend_group_no = friend_group_no;
		this.member_no = member_no;
		this.friend_group_name = friend_group_name;
		this.friend_group_adddate = friend_group_adddate;
	}

	public int getFriend_group_no() {
		return friend_group_no;
	}

	public void setFriend_group_no(int friend_group_no) {
		this.friend_group_no = friend_group_no;
	}

	public int getMember_no() {
		return member_no;
	}

	public void setMember_no(int member_no) {
		this.member_no = member_no;
	}

	public String getFriend_group_name() {
		return friend_group_name;
	}

	public void setFriend_group_name(String friend_group_name) {
		this.friend_group_name = friend_group_name;
	}

	public Date getFriend_group_adddate() {
		return friend_group_adddate;
	}

	public void setFriend_group_adddate(Date friend_group_adddate) {
		this.friend_group_adddate = friend_group_adddate;
	}
    
    
}
