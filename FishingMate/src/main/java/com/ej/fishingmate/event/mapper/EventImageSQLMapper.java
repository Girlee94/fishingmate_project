package com.ej.fishingmate.event.mapper;

import java.util.ArrayList;

import com.ej.fishingmate.vo.EventImageVO;

public interface EventImageSQLMapper {

	//축제게시판 이미지업로드-주빈
	public void insertImageEvent(EventImageVO eventImageVO);
	
	//축제게시판 게시글 번호로 등록된 이미지 불러오기-주빈 
	public ArrayList<EventImageVO> selectByEvntFboardNo(int event_freeboard_no);
	
}
