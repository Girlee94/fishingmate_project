package com.ej.fishingmate.manager.mapper;

import com.ej.fishingmate.vo.EventVO;
import com.ej.fishingmate.vo.ManagerVO;

public interface ManagerSQLMapper {

	//관리자 크리에이트 키 - 주빈
	public int createManagerKey();
	
	//관리자 등록? -주빈
	public void insertmanager(ManagerVO managerVO);
	
	//관리자 로그인-주빈
	public ManagerVO selectByIdAndPwAdm(ManagerVO managerVO);
	
	//관리자 번호로 매니저 VO 불러오기-주빈 
	public ManagerVO selectByManagerNo(int manager_no);
	
	//축제 게시글 읽기 -주빈
	public EventVO selectEventByNo(int event_freeboard_no);
	
	//축제 게시글 관리자 수정-주빈
	public void updateEventVO(EventVO eventVO);

	//축제 게시글 관리자 승인-주빈
	public void updateApprove(int event_freeboard_no);
	
	//축제 게시글 관리자 승인 취소-주빈
	public void updateDerecog(int event_freeboard_no);
	
	//관리자 승인이 되었는지 아닌지 판단-주빈
	public String selectAdminApprove(int event_freeboard_no);
	
	//관리자 승인 된 글만 불러오기-주빈
	public EventVO selectAdmApChecked(String event_freeboard_approve);
	
	//승인 전 글만 불러오기-주빈
	public EventVO selectAdmApBefore(String event_freeboard_approve);
	
}
