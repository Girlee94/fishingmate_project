  package com.ej.fishingmate.manager.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ej.fishingmate.event.mapper.EventImageSQLMapper;
import com.ej.fishingmate.event.mapper.EventSQLMapper;
import com.ej.fishingmate.manager.mapper.ManagerSQLMapper;
import com.ej.fishingmate.member.mapper.MemberSQLMapper;
import com.ej.fishingmate.vo.EventImageVO;
import com.ej.fishingmate.vo.EventVO;
import com.ej.fishingmate.vo.ManagerVO;
import com.ej.fishingmate.vo.MemberVO;

@Service
public class ManagerServiceImpl {

	@Autowired
	private ManagerSQLMapper managerSQLMapper;
	@Autowired
	private EventSQLMapper eventSQLMapper;
	@Autowired
	private MemberSQLMapper memberSQLMapper;
	@Autowired
	private EventImageSQLMapper eventImageSQLMapper;
	
	
	
	//관리자 등록-주빈
	public void insertmanager(ManagerVO managerVO) {
		//매니저No 크리에이트 키 int manager_no에 담기
		int manager_no = managerSQLMapper.createManagerKey();
		//managerVO에 매니저No 세팅.
		managerVO.setManager_no(manager_no);
		//매니저SQL맵퍼에서 매니저등록 불러오기
		managerSQLMapper.insertmanager(managerVO);
	}
	
	//관리자 로그인-주빈
	public ManagerVO managerLogin(ManagerVO managerVO) {
		//관리자 ID,PW로 select 한 정보(로그인 쿼리) 불러와서 매니저VO에 담기
		managerVO = managerSQLMapper.selectByIdAndPwAdm(managerVO);
		return managerVO;		
	}
	
	//관리자용 이벤트게시판 불러오기 -주빈
	public ArrayList<HashMap<String, Object>> getEventFreeboardList() {
		//서로 다른 타입의 오브젝트를 또 리스트에 담아야 해서 ArrayList<HashMap<K,V>>를 선언해서 담아주기로 한다.
		ArrayList<HashMap<String, Object>> result = new ArrayList<HashMap<String,Object>>();
		//이벤트SQL맵퍼에서 이벤트 게시판 전체(글만, 이미지X)리스트 불러와서 어레이리스트에 담기 
		ArrayList<EventVO> eventlist = eventSQLMapper.selectEventAll();
		//eventlist 끝날 때까지 eventVO반복
		for(EventVO eventVO : eventlist) {
			//해시맵을 선언하고 빈 그릇을 만들어서 담아줄 것임~준비~
			HashMap<String, Object> map = new HashMap<String, Object>();
			//이벤트VO에서 멤버No불러와서 int member_no에 담아주고, 멤버SQL맵퍼에서 회원번호로 멤버VO를 불러와서 그걸 멤버VO에 담는다
			int member_no = eventVO.getMember_no();
			MemberVO memberVO = memberSQLMapper.selectByNo(member_no);
			//이벤트VO에서 이벤트프리보드no불러왕서 int event_freeboard_no에 담고, 그걸로 해당 글 번호에 담긴 이미지를 불러와서 어레이 리스트에 담는다
			int event_freeboard_no = eventVO.getEvent_freeboard_no();
			ArrayList<EventImageVO> imageList = eventImageSQLMapper.selectByEvntFboardNo(event_freeboard_no);
			
		
			
			//맵에 멤버VO, 이벤트VO, 이미지리스트를 각각 담는다			
			map.put("memberVO", memberVO);
			map.put("eventVO", eventVO);
			map.put("imageList", imageList);
		
			//맵을 어레이리스트에 담는다
			result.add(map);
		}
		//맵을 담은 어레이리스트를 목록으로 불러온다~
		return result;
	}

	//관리자페이지 축제게시글 읽기(글1개)-주빈
	public HashMap<String, Object> getEventFreeboardContent(int event_freeboard_no) {
		//해시맵을 새로 선언해서 빈 그릇을 만들어서 담을 준비~,,
		HashMap<String, Object> map = new HashMap<String, Object>();
		//매니저SQL맵퍼에서 프리보드No로 이벤트게시판 글 불러오기를 해서 이벤트VO에 담는다 
		EventVO eventVO = managerSQLMapper.selectEventByNo(event_freeboard_no);
		//이미지SQL맵퍼에서 프리보드No로 등록된 이미지를 불러오기해서 이벤트이미지VO어레이리스트에 담는다
		ArrayList<EventImageVO> imageList = eventImageSQLMapper.selectByEvntFboardNo(event_freeboard_no);
		//이벤트VO에서 매니저No를 불러와서 int manager_no에 담고, 매니저SQL맵퍼에서 매니저No로 매니저VO를 불러와서 managerVO에 담는다
		int manager_no = eventVO.getManager_no();
		ManagerVO managerVO = managerSQLMapper.selectByManagerNo(manager_no);
		//이렇게 담아둔 걸 또 맵에다가 각각 담는다
		map.put("eventVO", eventVO);
		map.put("imageList", imageList);
		map.put("managerVO", managerVO);
		//그리고 맵을 리턴하면 게시글 불러오기~!
		return map;
	}

	//관리자 페이지 축제게시글 수정-주빈
	public void updateEvent(EventVO eventVO, ArrayList<EventImageVO> eventImageVOList) {
		//매니저SQL맵퍼에서 관리자이벤트 수정쿼리 불러오기
		managerSQLMapper.updateEventVO(eventVO);
		//이벤트VO에서 이벤트프리보드No를 불러와서 int event_freeboard_no에 담는다
		int event_freeboard_no = eventVO.getEvent_freeboard_no();
		//이벤트 이미지리스트(이미지가 여러개일 경우)가 끝날 때까지 이벤트 이미지VO 반복
		for(EventImageVO eventImageVO : eventImageVOList) {
			//이벤트 이미지VO에서 이벤트 프리보드No 세팅.
			eventImageVO.setEvent_freeboard_no(event_freeboard_no);
			//이벤트이미지SQL맵퍼에서 이미지를 등록(수정하고 싶을 경우 새로 등록)
			eventImageSQLMapper.insertImageEvent(eventImageVO);
		}	
	}

	//관리자 축제 게시글 승인-주빈
	public void updateApproveY(int event_freeboard_no) {
		
		managerSQLMapper.updateApprove(event_freeboard_no);
		
	}
	
	public void updateApproveN(int event_freeboard_no) {
		//매니저SQL맵퍼에서 승인된 글 승인 취소시키는 쿼리 불러오기
		managerSQLMapper.updateDerecog(event_freeboard_no);
	}
	
	
	
	
	//관리자 승인이 되었는지 아닌지 판단-주빈
	public String getAdminApprove(int event_freeboard_no) {
						
		return managerSQLMapper.selectAdminApprove(event_freeboard_no);
			
	}
}
