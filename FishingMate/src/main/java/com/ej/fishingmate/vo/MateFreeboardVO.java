package com.ej.fishingmate.vo;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

public class MateFreeboardVO {
	private int mate_freeboard_no;
	private int member_no;
	private int mate_category_no;
	private int region_category_no;
	private int fishing_category_no;
	private String mate_freeboard_title;
	private String mate_freeboard_fishingholename;
	private String mate_freeboard_content;
	private int mate_freeboard_readcount;
	private Date mate_freeboard_writedate;
	private int mate_freeboard_postcode;
	private String mate_freeboard_roadAddress;
	private String mate_freeboard_jibunAddress;
	private String mate_freeboard_detailAddress;
	private String mate_freeboard_extraAddress;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date mate_freeboard_startdate;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date mate_freeboard_enddate;
	private int mate_freeboard_maxnumber;
	
	public MateFreeboardVO() {
		// TODO Auto-generated constructor stub
	}

	public MateFreeboardVO(int mate_freeboard_no, int member_no, int mate_category_no, int region_category_no,
			int fishing_category_no, String mate_freeboard_title, String mate_freeboard_fishingholename, String mate_freeboard_content,
			int mate_freeboard_readcount, Date mate_freeboard_writedate, int mate_freeboard_postcode, String mate_freeboard_roadAddress,
			String mate_freeboard_jibunAddress, String mate_freeboard_detailAddress, String mate_freeboard_extraAddress,
			Date mate_freeboard_startdate, Date mate_freeboard_enddate, int mate_freeboard_maxnumber) {
		super();
		this.mate_freeboard_no = mate_freeboard_no;
		this.member_no = member_no;
		this.mate_category_no = mate_category_no;
		this.region_category_no = region_category_no;
		this.fishing_category_no = fishing_category_no;
		this.mate_freeboard_title = mate_freeboard_title;
		this.mate_freeboard_content = mate_freeboard_content;
		this.mate_freeboard_readcount = mate_freeboard_readcount;
		this.mate_freeboard_writedate = mate_freeboard_writedate;
		this.mate_freeboard_postcode = mate_freeboard_postcode;
		this.mate_freeboard_roadAddress = mate_freeboard_roadAddress;
		this.mate_freeboard_jibunAddress = mate_freeboard_jibunAddress;
		this.mate_freeboard_detailAddress = mate_freeboard_detailAddress;
		this.mate_freeboard_extraAddress = mate_freeboard_extraAddress;
		this.mate_freeboard_startdate = mate_freeboard_startdate;
		this.mate_freeboard_enddate = mate_freeboard_enddate;
		this.mate_freeboard_maxnumber = mate_freeboard_maxnumber;
	}

	public int getMate_freeboard_no() {
		return mate_freeboard_no;
	}

	public void setMate_freeboard_no(int mate_freeboard_no) {
		this.mate_freeboard_no = mate_freeboard_no;
	}

	public int getMember_no() {
		return member_no;
	}

	public void setMember_no(int member_no) {
		this.member_no = member_no;
	}

	public int getMate_category_no() {
		return mate_category_no;
	}

	public void setMate_category_no(int mate_category_no) {
		this.mate_category_no = mate_category_no;
	}

	public int getRegion_category_no() {
		return region_category_no;
	}

	public void setRegion_category_no(int region_category_no) {
		this.region_category_no = region_category_no;
	}

	public int getFishing_category_no() {
		return fishing_category_no;
	}

	public void setFishing_category_no(int fishing_category_no) {
		this.fishing_category_no = fishing_category_no;
	}

	public String getMate_freeboard_title() {
		return mate_freeboard_title;
	}

	public void setMate_freeboard_title(String mate_freeboard_title) {
		this.mate_freeboard_title = mate_freeboard_title;
	}

	public String getMate_freeboard_fishingholename() {
		return mate_freeboard_fishingholename;
	}

	public void setMate_freeboard_fishingholename(String mate_freeboard_fishingholename) {
		this.mate_freeboard_fishingholename = mate_freeboard_fishingholename;
	}

	public String getMate_freeboard_content() {
		return mate_freeboard_content;
	}

	public void setMate_freeboard_content(String mate_freeboard_content) {
		this.mate_freeboard_content = mate_freeboard_content;
	}

	public int getMate_freeboard_readcount() {
		return mate_freeboard_readcount;
	}

	public void setMate_freeboard_readcount(int mate_freeboard_readcount) {
		this.mate_freeboard_readcount = mate_freeboard_readcount;
	}

	public Date getMate_freeboard_writedate() {
		return mate_freeboard_writedate;
	}

	public void setMate_freeboard_writedate(Date mate_freeboard_writedate) {
		this.mate_freeboard_writedate = mate_freeboard_writedate;
	}

	public int getMate_freeboard_postcode() {
		return mate_freeboard_postcode;
	}

	public void setMate_freeboard_postcode(int mate_freeboard_postcode) {
		this.mate_freeboard_postcode = mate_freeboard_postcode;
	}

	public String getMate_freeboard_roadAddress() {
		return mate_freeboard_roadAddress;
	}

	public void setMate_freeboard_roadAddress(String mate_freeboard_roadAddress) {
		this.mate_freeboard_roadAddress = mate_freeboard_roadAddress;
	}

	public String getMate_freeboard_jibunAddress() {
		return mate_freeboard_jibunAddress;
	}

	public void setMate_freeboard_jibunAddress(String mate_freeboard_jibunAddress) {
		this.mate_freeboard_jibunAddress = mate_freeboard_jibunAddress;
	}

	public String getMate_freeboard_detailAddress() {
		return mate_freeboard_detailAddress;
	}

	public void setMate_freeboard_detailAddress(String mate_freeboard_detailAddress) {
		this.mate_freeboard_detailAddress = mate_freeboard_detailAddress;
	}

	public String getMate_freeboard_extraAddress() {
		return mate_freeboard_extraAddress;
	}

	public void setMate_freeboard_extraAddress(String mate_freeboard_extraAddress) {
		this.mate_freeboard_extraAddress = mate_freeboard_extraAddress;
	}

	public Date getMate_freeboard_startdate() {
		return mate_freeboard_startdate;
	}

	public void setMate_freeboard_startdate(Date mate_freeboard_startdate) {
		this.mate_freeboard_startdate = mate_freeboard_startdate;
	}

	public Date getMate_freeboard_enddate() {
		return mate_freeboard_enddate;
	}

	public void setMate_freeboard_enddate(Date mate_freeboard_enddate) {
		this.mate_freeboard_enddate = mate_freeboard_enddate;
	}

	public int getMate_freeboard_maxnumber() {
		return mate_freeboard_maxnumber;
	}

	public void setMate_freeboard_maxnumber(int mate_freeboard_maxnumber) {
		this.mate_freeboard_maxnumber = mate_freeboard_maxnumber;
	}
}
