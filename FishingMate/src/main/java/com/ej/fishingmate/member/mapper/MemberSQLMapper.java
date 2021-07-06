package com.ej.fishingmate.member.mapper;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.annotations.Param;
import org.springframework.web.bind.annotation.RequestParam;

import com.ej.fishingmate.vo.LottoUserVO;
import com.ej.fishingmate.vo.ManagerVO;
import com.ej.fishingmate.vo.MemberEvaluateVO;
import com.ej.fishingmate.vo.MemberFriendGroupVO;
import com.ej.fishingmate.vo.MemberFriendVO;
import com.ej.fishingmate.vo.MemberSendMessageVO;
import com.ej.fishingmate.vo.MemberVO;

public interface MemberSQLMapper {
	
	//회원 번호 받기 - 형준
	public int createMemberSequence();
	
	//회원가입 실행 - 정진
	public void insertMember(MemberVO memberVO);
	
	//회원가입 시 회원 평가 테이블에 기본 정보 입력 - 형준
	public void insertDefaultMemberEvaluate(int member_no);
	
	//로그인 실행 - 규석
	public MemberVO selectByIdAndPw(
			 @Param("id") String id, 
			 @Param("pw") String pw); 
	
	//------------------------- 멤버 불러오는 부분 하나로 합치기 -------------------------
	
	//특정 회원 정보 가져오기 - 형준
	public MemberVO selectMemberByMno(int member_no);
	
	//정보리스트 - 규석&명화&성호&수희
	public MemberVO memberSelectByNo(int member_no); 
	
	//리뷰 게시판 회원정보가져오기 - 정진
	public MemberVO reviewByNo(int no);
	
	// -주빈
	public MemberVO selectByNo(int member_no);
		
	//------------------------- 멤버 불러오는 부분 하나로 합치기 -------------------------
	
	// 매니저 불러오기 -주빈
	public ManagerVO selectAdm2(int manager_no);
	
	//회원 나이 구하기 - 형준
	public int selectMemberAge(int member_no);
	
	//회원 매너 점수 불러오기 - 형준
	public MemberEvaluateVO selectMemberEvaluate(int member_no);
	
	//-------------마이페이지 친구 -----
	//친구 신청-주빈
	public void insertFriend(MemberFriendVO memberFriendVO);
				  
	//닉네임(중복 불가)으로 친구검색-주빈
	public ArrayList<MemberVO> selectMemberNick(
			@Param("member_nick") String member_nick, 
			@Param("myNick") String myNick);
	
	//이름(동명이인 있을 수 있음)으로 친구검색-주빈
	public ArrayList<MemberVO> selectMemberName(
			@Param("member_name") String member_name, 
			@Param("myName") String myName);

	//친구신청 수락-주빈
	public void updateFriendConfirm(
			@Param("member_no") int member_no, 
			@Param("member_no2") int member_no2);
				
	//친구신청 거절-주빈
	public void updateFriendRejection(int friend_no);
						
	//친구리스트-주빈
	public ArrayList<MemberFriendVO> selectFriendList(int member_no);
		
	//확정된 친구리스트-주빈
	public ArrayList<MemberFriendVO> selectConfirmedFriendList(int member_no);
		
	public ArrayList<MemberFriendVO> selectConfirmedFriendListByGroupNo(@Param("member_no") int member_no , @Param("group_no") int group_no);
		
	//보낸친구요청(자기가 보낸 것)-주빈
	public ArrayList<MemberFriendVO> selectMeNo(int me_no);
		
	//받은친구요청(자기가 받은 것)-주빈
	public ArrayList<MemberFriendVO> selectYouNo(int you_no);
						
	//친구요청 수락여부-주빈
	public String selectFriendConfirm(
			@Param("member_no") int member_no, 
			@Param("member_no2") int member_no2);
		
	//친구정보-주빈 
	public MemberFriendVO selectFriendByFriendNo(int friend_no);
		
	//친구그룹 생성-주빈
	public void insertFrndGroup(MemberFriendGroupVO groupVO);
				
	//친구그룹 전체(자기가 만든 것) 불러오기-주빈
	public ArrayList<MemberFriendGroupVO> selectAllGroup(int member_no);
		
	//친구그룹 이름 불러오기-주빈
	public ArrayList<HashMap<String, Object>> selectGroupName(int friend_group_no);
		
	//친구그룹 이름 수정-주빈
	public void updateGroupName(MemberFriendGroupVO groupVO);
	
	//친구그룹 변경-주빈
	public void updateGroupSet(@Param("friend_no") int friend_no, 
							   @Param("friend_group_no") int friend_group_no);
	
	//-----메세지--------
	//회원쪽지보내기-주빈
	public void insertSendMessage(MemberSendMessageVO memberSendMessageVO);  
	
	//받은 메세지함-주빈
	public ArrayList<MemberSendMessageVO> selectInbox(int to_member_no);
				
	//보낸 메세지함-주빈
	public ArrayList<MemberSendMessageVO> selectSendMsg(int from_member_no);
	
	//받은 쪽지 본문 새창 읽기-주빈
	public MemberSendMessageVO selectInboxContent(MemberSendMessageVO messageVO);
	
	//보낸 쪽지 본문 새창 읽기-주빈
	public MemberSendMessageVO selectSendContent(MemberSendMessageVO messageVO); 
	
	//쪽지 읽기/수신확인-주빈
	public void updateReadCheck(MemberSendMessageVO messageVO);
		
	//받은 메시지 삭제 - 주빈
	public void deleteMessage(@RequestParam("sendmessage_no") int [] sendmessage_no);
	
	//로또 번호에 따른 경험치 배분
	public void updatelottolevelvalue(@Param("member_levelvalue") int member_levelvalue , @Param("member_no") int member_no);

	public void buylotto(int member_no);

	public void updatelevelhistory(@Param("history_value")int history_value, @Param("member_no")int member_no);
	//오늘 무료 로또 횟수
	public int todayfreelottocount(int member_no);

	public void updatechargehistory(@Param("history_value")int history_value, @Param("member_no")int member_no);
	//유저 카운트랑 당첨금액 업데이트해주자

	public void updatelottouserwon(LottoUserVO lottouserVO);
	
		
}
