package com.ej.fishingmate.event.mapper;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

import com.ej.fishingmate.vo.EventRecommendVO;
import com.ej.fishingmate.vo.EventVO;
import com.ej.fishingmate.vo.EventWishlistVO;

public interface EventSQLMapper {

	//이벤트 게시판 크리에이트키-주빈
	public int createEventKey();
		
	//이벤트 게시판 글작성-주빈
	public void insertEvent(EventVO eventVO);
	
	//이벤트 게시판 전체 불러오기-주빈
	public ArrayList<EventVO> selectEventAll();
	
	//이벤트 게시판 조회수 업데이트 -주빈
	public void updateEventReadCount(int event_freeboard_no);
	
	//이벤트 게시판 작성자 글수정-주0빈
	public void updateEventMember(int event_freeboard_no);
	
	//이벤트 게시판 관리자 글승인/수정-주빈
	public void updateEventManager(int event_freeboard_no);
	
	//이벤트 게시판 관리자(가) 승인(한) 글 리스트 불러오기-주빈
	public EventVO selectEventByApp(int event_freeboard_no);
	
	//이벤트 게시글 읽기-주빈
	public EventVO selectByNo(int event_freeboard_no);
	
	//진행중 이벤트 검색-주빈
	public ArrayList<EventVO> selectNowEvent();
	//예정된 이벤트 검색-주빈
	public ArrayList<EventVO> selectFrontEvent();
	//종료된 이벤트 검색-주빈
	public ArrayList<EventVO> selectBackEvent();
	
	//이벤트 추천(좋아요)-주빈
	public void insertRecommend(EventRecommendVO recommendVO);
	//이벤트 좋아요 해제 -주빈
	public void deleteRecommend(EventRecommendVO recommendVO);
	//자기가 누른 이벤트 좋아요 수 카운트 -주빈
	public int selectMyRecommendCount(@Param("member_no") int member_no, @Param("event_freeboard_no") int event_freeboard_no);
	//이벤트 게시글 당 좋아요 전체 수 - 주빈
	public int selectRecommendCount(int event_freeboard_no);
	
	//이벤트 위시리스트 -주빈
	public void insertWishlist(EventWishlistVO wishlistVO);
	//이벤트 위시리스트 -주빈
	public void deleteWishlist(EventWishlistVO wishlistVO);
	
	//이벤트 글 자기가 찜했는지 여부 확인 - 주빈
	public int selectMyWishlistCount(@Param("member_no") int member_no, @Param("event_freeboard_no") int event_freeboard_no);
	//게시글당 찜 총 개수 카운트- 주빈
	public int selectWishlistCount(int event_freeboard_no);
	//자기가 찜한 위시리스트 목록 -주빈
	public ArrayList<EventWishlistVO> selectMyWishlist(int member_no);
	
}
