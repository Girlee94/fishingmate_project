package com.ej.fishingmate.vo;

import java.util.Date;

public class EventWishlistVO {

	private int event_wishlist_no;
    private int event_freeboard_no;
    private int member_no;
    private Date event_wishlist_date;
	
    public EventWishlistVO() {
		super();
	}

	public EventWishlistVO(int event_wishlist_no, int event_freeboard_no, int member_no, Date event_wishlist_date) {
		super();
		this.event_wishlist_no = event_wishlist_no;
		this.event_freeboard_no = event_freeboard_no;
		this.member_no = member_no;
		this.event_wishlist_date = event_wishlist_date;
	}

	public int getEvent_wishlist_no() {
		return event_wishlist_no;
	}

	public void setEvent_wishlist_no(int event_wishlist_no) {
		this.event_wishlist_no = event_wishlist_no;
	}

	public int getEvent_freeboard_no() {
		return event_freeboard_no;
	}

	public void setEvent_freeboard_no(int event_freeboard_no) {
		this.event_freeboard_no = event_freeboard_no;
	}

	public int getMember_no() {
		return member_no;
	}

	public void setMember_no(int member_no) {
		this.member_no = member_no;
	}

	public Date getEvent_wishlist_date() {
		return event_wishlist_date;
	}

	public void setEvent_wishlist_date(Date event_wishlist_date) {
		this.event_wishlist_date = event_wishlist_date;
	}
	
    
}
