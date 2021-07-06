package com.ej.fishingmate.member.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ej.fishingmate.member.mapper.MemberSQLMapper;
import com.ej.fishingmate.vo.LevelvalueHistoryVO;
import com.ej.fishingmate.vo.MemberEvaluateVO;
import com.ej.fishingmate.vo.MemberFriendGroupVO;
import com.ej.fishingmate.vo.MemberFriendVO;
import com.ej.fishingmate.vo.MemberSendMessageVO;
import com.ej.fishingmate.vo.MemberVO;

@Service
public class MemberServiceImpl {
	
	@Autowired
	private MemberSQLMapper memberSQLMapper;
	
	//회원 번호 받기
	public int getMemberNo() {
		
		return memberSQLMapper.createMemberSequence();
	}
	
	//회원가입 실행 - 정진
	public void joinMember(MemberVO memberVO) {
		
		memberSQLMapper.insertMember(memberVO);
		memberSQLMapper.insertDefaultMemberEvaluate(memberVO.getMember_no());
	}
	
	//로그인 실행  - 규석
	public MemberVO login(MemberVO param) {
		
		String password = param.getMember_pw();
	
		MemberVO result = memberSQLMapper.selectByIdAndPw(param.getMember_id() , password);
		
		return result;
	}
	
	//멤버 No로 멤버VO찾기- 주빈
	public MemberVO selectMemberByMno(int member_no) {
		MemberVO memberVO = memberSQLMapper.selectMemberByMno(member_no);
		
		return memberVO;
	}
	
	//회원 매너 점수 불러오기 - 형준
	public MemberEvaluateVO getMemberEvaluate(int member_no) {
		
		return memberSQLMapper.selectMemberEvaluate(member_no);
	}
	//----------마이페이지 친구---------
	
		//닉네임(중복 불가)으로 친구검색-주빈
		public ArrayList<HashMap<String, Object>> searchFriendNick(String member_nick, String myNick, int member_no) {
			
			ArrayList<HashMap<String, Object>> result = new ArrayList<HashMap<String,Object>>();
			
			ArrayList<MemberVO> memberNickList = memberSQLMapper.selectMemberNick(member_nick, myNick);
			
			for(MemberVO memberVO : memberNickList) {
				HashMap<String, Object> map = new HashMap<String, Object>();
				map.put("memberVO", memberVO);
				
				String confirm = memberSQLMapper.selectFriendConfirm(member_no, memberVO.getMember_no());
				map.put("confirm", confirm);
				
				result.add(map);
			}
						
			return result;
		}
		
		//이름(동명이인 있을 수 있음)으로 친구검색-주빈
		public ArrayList<HashMap<String, Object>> getMemberName(String member_name, String myName, int member_no){
			
			ArrayList<HashMap<String, Object>> result = new ArrayList<HashMap<String,Object>>();
			
			ArrayList<MemberVO> memberNameList = memberSQLMapper.selectMemberName(member_name, myName);
			
			for(MemberVO memberVO : memberNameList) {
				HashMap<String, Object> map = new HashMap<String, Object>();
				map.put("memberVO", memberVO);
				
				String confirm = memberSQLMapper.selectFriendConfirm(member_no, memberVO.getMember_no());
				map.put("confirm", confirm);
				
				result.add(map);
			}
			
			return result;
		}
		
		//친구 신청-주빈
		public void insertFriend(MemberFriendVO memberFriendVO) {
			
			memberSQLMapper.insertFriend(memberFriendVO);
		}
		
		//친구신청 수락-주빈
		public void updateFriendConfirm(int friend_no) {
			
			MemberFriendVO memberFriendVO = memberSQLMapper.selectFriendByFriendNo(friend_no);
			int member_no = memberFriendVO.getMe_no();
			int member_no2 = memberFriendVO.getYou_no();
			
			memberSQLMapper.updateFriendConfirm(member_no, member_no2);
		}
		
		//친구신청 거절-주빈
		public void updateFriendRejection(int friend_no) {
			memberSQLMapper.updateFriendRejection(friend_no);
		}
		
		
		//**친구리스트-주빈
		public ArrayList<HashMap<String, Object>> getFriendList (int member_no){
			ArrayList<HashMap<String, Object>> result = new ArrayList<HashMap<String,Object>>();
				
			ArrayList<MemberFriendVO> friendList = memberSQLMapper.selectFriendList(member_no);

			for(MemberFriendVO friendVO : friendList) {
				HashMap<String, Object> map = new HashMap<String, Object>();
					
				MemberVO memberVO = null;
					
				if(friendVO.getMe_no() == member_no) {
					memberVO = memberSQLMapper.selectByNo(friendVO.getYou_no());
				}else {
					memberVO = memberSQLMapper.selectByNo(friendVO.getMe_no());
				}
					
					
				map.put("friendVO", friendVO);
				map.put("memberVO", memberVO);
					
				result.add(map);
			}
			return result;
		}
		
		//친구 그룹(전체) 리스트-주빈
		public ArrayList<MemberFriendGroupVO> getMemberFriendGroupList(int member_no){
			return memberSQLMapper.selectAllGroup(member_no);
		}
			
			
		//***확정된 친구리스트-주빈
		public HashMap<String, Object> selectConfirmedFriendList(int member_no){

			HashMap<String, Object> resultMap = new HashMap<String, Object>();
			
			ArrayList<HashMap<String, Object>> result = new ArrayList<HashMap<String,Object>>();
			ArrayList<HashMap<String, Object>> groupResult = new ArrayList<HashMap<String,Object>>();
			ArrayList<HashMap<String, Object>> basicResult = new ArrayList<HashMap<String,Object>>();
			ArrayList<MemberFriendVO> list = memberSQLMapper.selectConfirmedFriendList(member_no);
			
			for(MemberFriendVO memberFriendVO : list) {
				HashMap<String, Object> map = new HashMap<String, Object>();
											
				map.put("memberFriendVO", memberFriendVO);
				if(memberFriendVO.getMe_no() == member_no) {
					MemberVO youVO = memberSQLMapper.memberSelectByNo(memberFriendVO.getYou_no());
					map.put("youVO", youVO);
						
				}
				if(memberFriendVO.getYou_no() == member_no) {
					MemberVO meVO = memberSQLMapper.memberSelectByNo(memberFriendVO.getMe_no());
					map.put("meVO", meVO);
				}
				
				result.add(map);
			}
			
			resultMap.put("result", result);
			
			//내가 만든 그룹
			ArrayList<MemberFriendGroupVO> groupList = memberSQLMapper.selectAllGroup(member_no);
			for(MemberFriendGroupVO memberFriendGroupVO : groupList) {
				HashMap<String, Object> map = new HashMap<String, Object>();
				HashMap<String, Object> tempMap = null;
				ArrayList<HashMap<String, Object>> friendLists = new ArrayList<HashMap<String,Object>>();
				int group_no = memberFriendGroupVO.getFriend_group_no();
				String group_name = memberFriendGroupVO.getFriend_group_name();
				map.put("group_name", group_name);
				map.put("friend_group_no", group_no);
				
				ArrayList<MemberFriendVO> friendList = memberSQLMapper.selectConfirmedFriendListByGroupNo(member_no, group_no);
				for (MemberFriendVO memberFriendVO : friendList) {
					tempMap = new HashMap<String, Object>();
					MemberVO memberVO = null;
					
					if (member_no == memberFriendVO.getYou_no()) {
						memberVO = memberSQLMapper.memberSelectByNo(memberFriendVO.getMe_no());
						//continue;
					}else {
						memberVO = memberSQLMapper.memberSelectByNo(memberFriendVO.getYou_no());
					}
					
					tempMap.put("memberVO", memberVO);
					tempMap.put("memberFriendVO", memberFriendVO);
					
					friendLists.add(tempMap);
				}
				
				map.put("friendLists", friendLists);
				
				groupResult.add(map);
			}
			
			resultMap.put("groupResult", groupResult);
			
			//기본 그룹
			ArrayList<MemberFriendVO> basicList = memberSQLMapper.selectConfirmedFriendListByGroupNo(member_no, 0);
			for (MemberFriendVO memberFriendVO : basicList) {
				HashMap<String, Object> map = new HashMap<String, Object>();
				
				MemberVO memberVO = memberSQLMapper.memberSelectByNo(memberFriendVO.getYou_no());
				
				if (member_no == memberFriendVO.getYou_no()) {
					memberVO = memberSQLMapper.memberSelectByNo(memberFriendVO.getMe_no());
					//continue;
				}else {
					memberVO = memberSQLMapper.memberSelectByNo(memberFriendVO.getYou_no());
				}
							
				map.put("memberVO", memberVO);
				
				
				
				map.put("memberFriendVO", memberFriendVO);
				
				basicResult.add(map);
			}
			
			resultMap.put("basicResult", basicResult);
			
			//ArrayList<HashMap<String, Object>> innerList = new ArrayList<HashMap<String,Object>>();
//			HashMap<String, Object> resultMap = new HashMap<String, Object>();

//			MemberFriendGroupVO defaultgroupVO = new MemberFriendGroupVO();
//			defaultgroupVO.setFriend_group_name("기본 그룹");
//				
//			HashMap<String, Object> defaultMap = new HashMap<String, Object>();
//			defaultMap.put("groupVO", defaultgroupVO);
//				
//			result.add(defaultMap);
//				
//				
//			//그룹을 먼저 셀렉트
//			ArrayList<MemberFriendGroupVO> groupList = memberSQLMapper.selectAllGroup(member_no);
//				
//			for(MemberFriendGroupVO groupVO : groupList) {
//				HashMap<String, Object> map = new HashMap<String, Object>();
//				map.put("groupVO", groupVO);
//				result.add(map);
//			}
//			System.out.println(result);
//				
//			//반복문 돌려서
//			for(HashMap<String, Object> outerMap : result) {
//					
//				int group_no = ((MemberFriendGroupVO)outerMap.get("groupVO")).getFriend_group_no();
//					
//				ArrayList<MemberFriendVO> list = memberSQLMapper.selectConfirmedFriendListByGroupNo(member_no, group_no);
//					
//				ArrayList<HashMap<String, Object>> innerList = new ArrayList<HashMap<String,Object>>();
//					
//				for(MemberFriendVO memberFriendVO : list) {
//					HashMap<String, Object> map = new HashMap<String, Object>();
//												
//					map.put("memberFriendVO", memberFriendVO);
//					if(memberFriendVO.getMe_no() == member_no) {
//						MemberVO youVO = memberSQLMapper.memberSelectByNo(memberFriendVO.getYou_no());
//						map.put("youVO", youVO);
//							
//					}
//					if(memberFriendVO.getYou_no() == member_no) {
//						MemberVO meVO = memberSQLMapper.memberSelectByNo(memberFriendVO.getMe_no());
//						System.out.println(memberFriendVO.getYou_no());
//						map.put("meVO", meVO);
//					}
//					innerList.add(map);
//				}			
//					
//				outerMap.put("innerList", innerList);
//			}
				
//			resultMap.put("result", result);
//			resultMap.put("innerList", innerList);
				
				
				
			/*
			ArrayList<MemberFriendVO> list = memberSQLMapper.selectConfirmedFriendList(member_no);
				
			for(MemberFriendVO memberFriendVO : list) {
				HashMap<String, Object> map = new HashMap<String, Object>();
											
				map.put("memberFriendVO", memberFriendVO);
				if(memberFriendVO.getMe_no() == member_no) {
					MemberVO youVO = memberSQLMapper.memberSelectByNo(memberFriendVO.getYou_no());
					map.put("youVO", youVO);
						
				}
				if(memberFriendVO.getYou_no() == member_no) {
					MemberVO meVO = memberSQLMapper.memberSelectByNo(memberFriendVO.getMe_no());
					System.out.println(memberFriendVO.getYou_no());
					map.put("meVO", meVO);
				}
				result.add(map);
			}
			*/
				
			return resultMap;
		}
			
		//보낸친구요청(자기가 보낸 것)-주빈
		public ArrayList<HashMap<String, Object>> selectMeNo(int me_no){
			ArrayList<HashMap<String, Object>> result = new ArrayList<HashMap<String,Object>>();
				
			ArrayList<MemberFriendVO> list = memberSQLMapper.selectMeNo(me_no);
				
			for(MemberFriendVO memberFriendVO : list) {
				HashMap<String, Object> map = new HashMap<String, Object>();
				map.put("memberFriendVO", memberFriendVO);
				MemberVO memberVO = memberSQLMapper.selectByNo(memberFriendVO.getYou_no());
				map.put("memberVO", memberVO);
				result.add(map);
			}
						
			return result;
		}
			
		//받은친구요청(자기가 받은 것)-주빈
		public ArrayList<HashMap<String, Object>> selectYouNo(int you_no){
			ArrayList<HashMap<String, Object>> result = new ArrayList<HashMap<String,Object>>();
				
			ArrayList<MemberFriendVO> list = memberSQLMapper.selectYouNo(you_no);
				
			for(MemberFriendVO memberFriendVO : list) {
				HashMap<String, Object> map = new HashMap<String, Object>();
				map.put("memberFriendVO", memberFriendVO);
				MemberVO memberVO = memberSQLMapper.selectByNo(memberFriendVO.getMe_no());  
				map.put("memberVO", memberVO);
				result.add(map);
			}
				
			return result;
		}
					
		//친구그룹 생성-주빈
		public void insertFrndGroup(MemberFriendGroupVO groupVO) {
			memberSQLMapper.insertFrndGroup(groupVO);
		}
					
		//***친구그룹 이름 불러오기-주빈
		public ArrayList<HashMap<String, Object>> selectGroupName(int friend_group_no, int member_no) {
			ArrayList<HashMap<String, Object>> friendVO = new ArrayList<HashMap<String,Object>>();
				
			ArrayList<MemberFriendGroupVO> groupNameList = memberSQLMapper.selectAllGroup(member_no);
							
			for(MemberFriendGroupVO groupVO : groupNameList ) {
				HashMap<String, Object> map = new HashMap<String, Object>();
				map.put("groupVO", groupVO);
				MemberVO memberVO = memberSQLMapper.selectByNo(groupVO.getMember_no());
				map.put("memberVO", memberVO);
				friendVO.add(map);
			}
				
			return friendVO;
		}
			
		//친구그룹 이름 수정-주빈
		public void updateGroupName(MemberFriendGroupVO groupVO) {
			memberSQLMapper.updateGroupName(groupVO);
		}
			
		//친구그룹 변경-주빈
		public void updateGroupSet(int friend_no, int friend_group_no) {
			memberSQLMapper.updateGroupSet(friend_no, friend_group_no);
		}
		
		
		//-----메세지-----------
		//회원쪽지보내기-주빈
		public ArrayList<HashMap<String, Object>> insertSendMessage(MemberVO memberVO, MemberFriendGroupVO groupVO) {
			
			ArrayList<HashMap<String, Object>> friendVO = new ArrayList<HashMap<String,Object>>();
			ArrayList<MemberFriendVO> friendList = memberSQLMapper.selectConfirmedFriendListByGroupNo(memberVO.getMember_no(), groupVO.getFriend_group_no());
			
			for(MemberFriendVO mfriendVO : friendList) {
				HashMap<String, Object> map = new HashMap<String, Object>();
				map.put("mfriendVO", mfriendVO);
				MemberVO memberVO2 = memberSQLMapper.selectByNo(memberVO.getMember_no());
				map.put("memberVO2", memberVO2);
				friendVO.add(map);
				
				
			}
			//memberSQLMapper.insertSendMessage(memberVO.getMember_no()); 
			
			return friendVO;
		}
		
		public void insertSendMessage2(MemberSendMessageVO memberSendMessageVO) {
			memberSQLMapper.insertSendMessage(memberSendMessageVO);
		}
		
		//받은 메세지함-주빈
		public ArrayList<HashMap<String, Object>> selectInbox(int to_member_no){
			ArrayList<HashMap<String, Object>> inboxVO = new ArrayList<HashMap<String,Object>>();
			ArrayList<MemberSendMessageVO> inboxList = memberSQLMapper.selectInbox(to_member_no);
			
			for(MemberSendMessageVO messageVO : inboxList) {
				HashMap<String, Object> map = new HashMap<String, Object>();
				
				System.out.println(messageVO.getTo_member_no());
				
				MemberVO memberVO = memberSQLMapper.selectByNo(messageVO.getFrom_member_no());
				
				map.put("messageVO", messageVO);
				map.put("memberVO", memberVO);
				
				
				
				inboxVO.add(map);
			}
			return inboxVO;
		}
			
		//보낸 메세지함-주빈
		public ArrayList<HashMap<String, Object>> selectSendMsg(int from_member_no){
			ArrayList<HashMap<String, Object>> sendMessageVO = new ArrayList<HashMap<String,Object>>();
			ArrayList<MemberSendMessageVO> sendMessageList = memberSQLMapper.selectSendMsg(from_member_no);
			
			for(MemberSendMessageVO messageVO : sendMessageList) {
				HashMap<String, Object> map = new HashMap<String, Object>();
				
				MemberVO memberVO = memberSQLMapper.selectByNo(messageVO.getTo_member_no());
				System.out.println(messageVO.getTo_member_no());
				map.put("messageVO", messageVO);
				map.put("memberVO", memberVO);
				
				sendMessageVO.add(map);
			}
			return sendMessageVO;
		}
		
		//받은 쪽지 본문 새창 읽기-주빈
		public MemberSendMessageVO selectInboxContent(MemberSendMessageVO messageVO) {
			MemberSendMessageVO readMessageVO = memberSQLMapper.selectInboxContent(messageVO);
			
			return readMessageVO;
		}
			
		//보낸 쪽지 본문 새창 읽기-주빈
		public MemberSendMessageVO selectSendContent(MemberSendMessageVO messageVO) {
			MemberSendMessageVO readMessageVO = memberSQLMapper.selectSendContent(messageVO);
			
			return readMessageVO;
		} 	
		
		//쪽지 읽기/수신확인-주빈
		public void updateReadCheck(MemberSendMessageVO messageVO) {
			memberSQLMapper.updateReadCheck(messageVO);
		}
		
		
		public void deleteMessageProcess(int [] sendmessage_no) {
			memberSQLMapper.deleteMessage(sendmessage_no);
		}
		
		

		
		//규석 - 로또
		public void updatelottolevelvalue(int count  ,int member_levelvalue, int member_no) {

			 
			if(count == 0) {
				memberSQLMapper.updatelottolevelvalue(0, member_no);
			}
				
			else if(count ==1) {
			memberSQLMapper.updatelottolevelvalue(1000,  member_no);
			}
			else if (count ==2) {
				memberSQLMapper.updatelottolevelvalue(10000, member_no);
			}
			else if(count ==3) {
				memberSQLMapper.updatelottolevelvalue(100000, member_no);
			}
			else if(count ==4) {
				memberSQLMapper.updatelottolevelvalue(10000000, member_no);
			}
			else if(count ==5) {
				memberSQLMapper.updatelottolevelvalue(100000000, member_no);
			}
			else if (count ==6) {
				memberSQLMapper.updatelottolevelvalue(1000000000,member_no );
			}
		}

		

		public void updatefreelottohistory(int count, int member_no,LevelvalueHistoryVO levelvalueHistoryVO ) {
			if(count == 0) {
				memberSQLMapper.updatelevelhistory(0, member_no);
			}
				
			else if(count ==1) {
			memberSQLMapper.updatelevelhistory(1000,  member_no);
			}
			else if (count ==2) {
				memberSQLMapper.updatelevelhistory(10000, member_no);
			}
			else if(count ==3) {
				memberSQLMapper.updatelevelhistory(100000, member_no);
			}
			else if(count ==4) {
				memberSQLMapper.updatelevelhistory(10000000, member_no);
			}
			else if(count ==5) {
				memberSQLMapper.updatelevelhistory(100000000, member_no);
			}
			else if (count ==6) {
				memberSQLMapper.updatelevelhistory(1000000000,member_no );
			}
		}

		public int todayfreelottocount(int member_no) {
			return memberSQLMapper.todayfreelottocount(member_no);
		}

		
	}

