package com.ej.fishingmate.vo;

public class InfoCategoryVO {

		private int info_category_no;
		private String freeboard_category_name;
		public InfoCategoryVO() {
			super();
		}
		public InfoCategoryVO(int info_category_no, String freeboard_category_name) {
			super();
			this.info_category_no = info_category_no;
			this.freeboard_category_name = freeboard_category_name;
		}
		public int getInfo_category_no() {
			return info_category_no;
		}
		public void setInfo_category_no(int info_category_no) {
			this.info_category_no = info_category_no;
		}
		public String getFreeboard_category_name() {
			return freeboard_category_name;
		}
		public void setFreeboard_category_name(String freeboard_category_name) {
			this.freeboard_category_name = freeboard_category_name;
		}
		
}
