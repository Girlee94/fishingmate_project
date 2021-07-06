package com.ej.fishingmate.event.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.commons.text.StringEscapeUtils;
import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ej.fishingmate.event.mapper.EventImageSQLMapper;
import com.ej.fishingmate.event.mapper.EventSQLMapper;
import com.ej.fishingmate.manager.mapper.ManagerSQLMapper;
import com.ej.fishingmate.member.mapper.MemberSQLMapper;
import com.ej.fishingmate.vo.EventImageVO;
import com.ej.fishingmate.vo.EventRecommendVO;
import com.ej.fishingmate.vo.EventVO;
import com.ej.fishingmate.vo.EventWishlistVO;
import com.ej.fishingmate.vo.ManagerVO;
import com.ej.fishingmate.vo.MemberVO;



@Service
public class EventServiceImpl {

	@Autowired
	private EventImageSQLMapper eventImageSQLMapper;
	@Autowired
	private EventSQLMapper eventSQLMapper;
	@Autowired
	private MemberSQLMapper memberSQLMapper;
	@Autowired
	private ManagerSQLMapper managerSQLMapper;
	
	
	//이벤트 게시판 글 작성-주빈
	public void writeContent(EventVO eventVO) {
		eventSQLMapper.insertEvent(eventVO);
	}
	
	
	//이벤트 이미지 업로드(파일) 추가,,
	public void writeContent(EventVO eventVO, ArrayList<EventImageVO> eventImageVOList) {
		//이벤트 게시판 크리에이트키 불러와서 eventVO에 셋팅? 담아주기? 이미지를 게시판에 같이 등록해야 하니깐,,	
		int event_freeboard_no = eventSQLMapper.createEventKey();
		eventVO.setEvent_freeboard_no(event_freeboard_no);
		//게시글 insert 불러오기,,
		eventSQLMapper.insertEvent(eventVO);
		//사진을 여러개 등록 가능하기 때문에 List로,, 글No별로 이미지 등록 	
		for(EventImageVO eventImageVO : eventImageVOList) {
			eventImageVO.setEvent_freeboard_no(event_freeboard_no);
			//이미지 등록 쿼리
			eventImageSQLMapper.insertImageEvent(eventImageVO);
		}
			
	}
	
	
	//이벤트 게시판 전체 불러오기-주빈
	public ArrayList<HashMap<String, Object>> getEventFreeboardList(int searchNo) {
		//[과제] 다형성 공부하기...!!! Object하고 연결....  힌트 : JAVA에서는 모든 클래스는  Object를 상속 받는다.
		//타입이 다른 걸 담아야 해서 일단 해시맵을 쓰고 또 리스트에 다시 담아야 해서 ArrayList<HashMap<K,V>>쓰고,
		//빈 걸 만들어서 담아주기로 함
		ArrayList<HashMap<String, Object>> result = new ArrayList<HashMap<String,Object>>();
		//ArrayList<EventVO> 를 만들어서 초기화함		
		ArrayList<EventVO> eventlist = null;
		
	    //진행시기별로 이벤트를 분류하려고 만든 것,, 오늘 날짜(접속일) 기준으로 진행중/예정/종료 이벤트 분류용
		switch(searchNo) { //이벤트 진행 시기별 검색
			//전체 이벤트
			case 1: eventlist = eventSQLMapper.selectEventAll(); 	break;
			//현재 진행중이벤트(시작일 또는 종료일이 오늘날짜 포함일 때)
			case 2: eventlist = eventSQLMapper.selectNowEvent();	break;
			//예정된 이벤트(오늘날짜보다 이후 시작인 이벤트)
			case 3: eventlist = eventSQLMapper.selectFrontEvent();	break;
			//종료된 이벤트(오늘날짜 이전에 종료된 이벤트)
			case 4: eventlist = eventSQLMapper.selectBackEvent();	break;
		}
				
		
		//***많이 헷갈린 부분***
		//리스트 끝날 때까지 EventVO 반복
		for(EventVO eventVO : eventlist) {
			//일단 비어있는 HashMap 선언해주고,,? 여기다 담을 거야,,
			HashMap<String, Object> map = new HashMap<String, Object>();
           
			System.out.println("여긴 머냐!!!!");
			//member_no가 필요함,, 왜냐면 닉네임이 필요해가지고,, 닉네임을 표시해야 하는데, 지금 member_no로 닉네임을 불러와야해서 member_no로 memberVO 가져올 것임,,
			int member_no = eventVO.getMember_no();
			System.out.println("[test]" + member_no);
			//멤버No로 멤버VO 불러오기->닉네임 쓰려고!
			MemberVO memberVO = memberSQLMapper.selectByNo(member_no);
			//eventVO에서 프리보드No불러오기
			int event_freeboard_no = eventVO.getEvent_freeboard_no();
			
			//게시글 당 좋아요 수 (카드 리스트에 띄울 것) -주빈
			int recommendCount = eventSQLMapper.selectRecommendCount(event_freeboard_no);
			
			//이미지가 여러개 등록 가능해서 리스트에 담은 것, 게시글 번호로 불러오기
			ArrayList<EventImageVO> imageList = eventImageSQLMapper.selectByEvntFboardNo(event_freeboard_no);

			//맵에 담기
			map.put("memberVO", memberVO);
			map.put("eventVO", eventVO);
			map.put("imageList", imageList);
			map.put("recommendCount", recommendCount);
			//맵을 리스트에 담기
			result.add(map);
		}
		
		
		return result;
	}
	
	//이벤트 게시판 조회수 업데이트 -주빈
	 public void increaseEventReadCount(int event_freeboard_no) {
		 eventSQLMapper.updateEventReadCount(event_freeboard_no);
	 }
		
	//축제글 작성자 글수정-주빈
	public void updateEventMember(int event_freeboard_no) {
		eventSQLMapper.updateEventMember(event_freeboard_no);
	}
	
	//축제글 관리자 승인/수정-주빈
	public void updateEventManager(int event_freeboard_no) {
		eventSQLMapper.updateEventManager(event_freeboard_no);
	}
	
	//축제 게시판 이미지 업로드-주빈   
	public ArrayList<EventImageVO> imageList (int event_freeboard_no){
		ArrayList<EventImageVO> imageList = eventImageSQLMapper.selectByEvntFboardNo(event_freeboard_no);
		return imageList;
	}
	
	//관리자가 승인한 축제글(1개 읽기 페이지) 불러오기-주빈
	public HashMap<String,Object> selectEventByApp(int event_freeboard_no, boolean isEscapeHtml) {
		//회원이 게시글을 축제게시판에 올리면 관리자페이지 리스트로 등록이 되는 구조//->그 다음 관리자가 승인하면 다시 회원게시판으로 이동//
		HashMap<String, Object> map = new HashMap<String, Object>();
		
		EventVO eventVO = eventSQLMapper.selectEventByApp(event_freeboard_no);
		
		if(isEscapeHtml) {
			String content = eventVO.getEvent_freeboard_content();
			
			content = StringEscapeUtils.escapeHtml4(content);
			content = content.replaceAll("\n", "<br>");
			
			eventVO.setEvent_freeboard_content(content);
		}
		
		
		
		//게시글 당 좋아요 수-주빈 
		int recommendCount = eventSQLMapper.selectRecommendCount(event_freeboard_no);
		//게시글 당 찜 개수 -주빈
		int wishlistCount = eventSQLMapper.selectWishlistCount(event_freeboard_no);
			//eventVO에서 memberNo불러오기
		int member_no = eventVO.getMember_no();
			//회원번호로 멤버VO 불러오기
		MemberVO memberVO = memberSQLMapper.selectByNo(member_no);
			//맵에 담기
			map.put("memberVO", memberVO);
			
			map.put("eventVO", eventVO);
			
			map.put("recommendCount", recommendCount);
		
			map.put("wishlistCount", wishlistCount);
				
		return map;
		
	}
	
	//축제 게시글 읽기 -주빈
	public EventVO readEventPage(int event_freeboard_no) {
		
		EventVO eventVO = eventSQLMapper.selectByNo(event_freeboard_no);
		
		return eventVO;
	}

	//축제 게시글 수정 -주빈
	public void updateEvent(EventVO eventVO, ArrayList<EventImageVO> eventImageVOList) {
		managerSQLMapper.updateEventVO(eventVO);
		//eventVO로 프리보드No불러오기
		int event_freeboard_no = eventVO.getEvent_freeboard_no();
		//List끝날 때까지 eventImageVO 반복 
		for(EventImageVO eventImageVO : eventImageVOList) {
			eventImageVO.setEvent_freeboard_no(event_freeboard_no);
			eventImageSQLMapper.insertImageEvent(eventImageVO);
		}	
		
	}
	
	//축제 게시글 좋아요 -주빈
	public void Recommend(EventRecommendVO recommendVO) {
				
		eventSQLMapper.insertRecommend(recommendVO);
	}
	
	//축제 게시글 좋아요 해제 -주빈
	public void  deleteRecommend(EventRecommendVO recommendVO) {
		
		eventSQLMapper.deleteRecommend(recommendVO);
	}
	
	//자기가 누른 좋아요 수 카운트 -주빈
	public int getMyRecommendCount(int sessionNo, int event_freeboard_no) {
		int countMyFavorite = eventSQLMapper.selectMyRecommendCount(sessionNo, event_freeboard_no); //<--로그인한 사람의 member_no를 sessionNo라는 이름으로 컨트롤러에서 받음.
		return countMyFavorite;
	}
	
	//이벤트 게시글 당 좋아요 전체 수 - 주빈
	public int getRecommendCount(int event_freeboard_no) {
		return eventSQLMapper.selectRecommendCount(event_freeboard_no);
	}
	
	//위시리스트 - 주빈
	public void insertWishlist(EventWishlistVO wishlistVO) {
		eventSQLMapper.insertWishlist(wishlistVO);
	}
	//위시리스트 해제- 주빈
	public void deleteWishlist(EventWishlistVO wishlistVO) {
		eventSQLMapper.deleteWishlist(wishlistVO);
	}
	
	//자기가 해당 게시글 찜했는지 여부 확인-주빈
	public int getMyWishlistCount(int sessionNo, int event_freeboard_no) {
		int countMyWishlist = eventSQLMapper.selectMyWishlistCount(sessionNo, event_freeboard_no);
		return countMyWishlist;
	}
	
	
	
	//자기가 찜한 위시리스트 목록 -주빈
	public ArrayList<HashMap<String, Object>> selectMyWishlist(int member_no){
		//찜한 기록이 1개가 아니라 여러개의 글에 찜한 기록에 대한 리스트이기 때문에 ArrayList<HashMap<K,V>>로 선언해서 담기로 함,,
		ArrayList<HashMap<String, Object>> result = new ArrayList<HashMap<String,Object>>();
		//ArrayList<EventWhishlistVO>에 memberNo별로 찜한 위시리스트 담기
		ArrayList<EventWishlistVO> wishList = eventSQLMapper.selectMyWishlist(member_no);
		
		//wishList 끝날 때까지 whishlistVO 반복,, 돌리기
		for(EventWishlistVO wishlistVO : wishList) {
			//HashMap<K,V> 선언해서  담기, 왜 해시맵이냐면 타입이 다른 거 담을 거야,,
			HashMap<String, Object> map = new HashMap<String, Object>();
			//wishlishVO에서 프리보드No불러와서 이벤트VO에 담기
			int event_freeboard_no = wishlistVO.getEvent_freeboard_no();
			EventVO eventVO = eventSQLMapper.selectByNo(event_freeboard_no);
			//맵에 wishlistVO랑 eventVO 담기
			map.put("wishlistVO", wishlistVO);
			map.put("eventVO", eventVO);
			//map을 ArrayList에 담기
			result.add(map);
		}
		//어레이리스트 해시맵을 목록으로 불러온다~		
		return result;
	}
}
