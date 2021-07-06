 package com.ej.fishingmate.member.controller;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.ej.fishingmate.event.service.EventServiceImpl;
import com.ej.fishingmate.member.service.MemberServiceImpl;
import com.ej.fishingmate.vo.EventWishlistVO;
import com.ej.fishingmate.vo.MemberEvaluateVO;
import com.ej.fishingmate.vo.MemberFriendGroupVO;
import com.ej.fishingmate.vo.MemberFriendVO;
import com.ej.fishingmate.vo.MemberSendMessageVO;
import com.ej.fishingmate.vo.MemberVO;

@Controller
@RequestMapping("member/*")
public class MemberController {
	
	@Autowired
	private MemberServiceImpl memberService;
	@Autowired
	private EventServiceImpl eventService;
	
	//로그인 페이지 이동 - 정진
	@RequestMapping("loginPage.do")
	public String loginPage() {
		
		return "member/loginPage";
	}
	
	//회원가입 페이지 이동 - 정진
	@RequestMapping("joinMemberPage.do")
	public String joinMemberPage() {
		
		return "member/joinMemberPage";
	}
	
	//회원가입 실행 - 정진
	@RequestMapping("joinMemberProcess.do")
	public String joinMemberProcess(MemberVO memberVO) {
		
		//회원번호 생성 후 VO객체에 부여 - 형준
		int member_no = memberService.getMemberNo();
		memberVO.setMember_no(member_no);
		
		memberService.joinMember(memberVO);
		
		return "member/joinMemberSuccess";
	}
	
	//로그인 실행 - 규석
	@RequestMapping("loginProcess.do")
	public String loginProcess(MemberVO memberVO , HttpSession session) {
		
		MemberVO sessionMember = memberService.login(memberVO);
		
		if(sessionMember != null) {
		
			session.setAttribute("sessionUser", sessionMember);
		
			return "redirect:../main/index.do";
		}else {
			//실패!!!
			return "member/loginFail";
		}
		
		
	}
	
	//로그아웃 실행 - 형준
	@RequestMapping("logoutProcess.do")
	public String logoutProcess(HttpSession session) {
		
		session.invalidate();
		
		return "redirect:../main/index.do";
	}
	
	//-----------------------------------------------------------------------------------------------
	//마이페이지 열기- 주빈
	@RequestMapping("myPage.do")
	public String myPage(int member_no, Model model) {
		
		MemberVO memberVO = memberService.selectMemberByMno(member_no);
		
		//회원 매너점수 불러오기 - 형준
		MemberEvaluateVO memberEvaluateVO = memberService.getMemberEvaluate(member_no); 
		double evaluteValueRate = (memberEvaluateVO.getMember_evaluate_value()/10)*100;
		
		
		model.addAttribute("memberVO", memberVO);
		model.addAttribute("memberEvaluateVO", memberEvaluateVO);
		model.addAttribute("evaluteValueRate", evaluteValueRate);
		
		return "member/myPage";
	}
	
	//위시리스트 페이지- 주빈
	@RequestMapping("wishlist.do")
	public String wishlist(int member_no, Model model) {
		 
		ArrayList<HashMap<String, Object>> myWishList = eventService.selectMyWishlist(member_no);
		
		model.addAttribute("myWishList", myWishList);
		
		return "member/wishlist";
	}
	
	//마이페이지 위시리스트 목록에서 찜해제-주빈
	@RequestMapping("deleteWishlist.do")
	public String deleteWishlist(EventWishlistVO wishlistVO) {
		
		eventService.deleteWishlist(wishlistVO);
		
		return "redirect:./wishlist.do?member_no="+ wishlistVO.getMember_no();
	}
	
	//마이페이지 메이트 위시리스트 이동 - 형준
	@RequestMapping("mateWishListPage.do")
	public String mateWishListPage() {
		
		return "member/mateWishListPage";
	}
	
	//-------------------------------------------------------------------------------------------------------
	//마이페이지 친구페이지-주빈
	@RequestMapping("friendPage.do")
	public String friendPage(Model model, String member_name, String member_nick, HttpSession session) {
	
		MemberVO memberVO = (MemberVO)session.getAttribute("sessionUser");
		
		if(memberVO != null) {
			//친구검색(이름)-주빈
			if(member_name != null) {
				String myName = memberVO.getMember_name();
				ArrayList<HashMap<String, Object>> nameList = memberService.getMemberName(member_name, myName, memberVO.getMember_no());
				model.addAttribute("nameList", nameList);
			}else {
				
			}
			//친구검색(닉네임)-주빈
			if(member_nick != null) {
				String myNick = memberVO.getMember_nick();
				ArrayList<HashMap<String, Object>> nickList = memberService.searchFriendNick(member_nick, myNick, memberVO.getMember_no());
				model.addAttribute("nickList", nickList);
			}else {
				
			}
				
			int member_no = memberVO.getMember_no();
			//확정된 친구리스트-주빈
			HashMap<String, Object> ConfirmedFriendList = memberService.selectConfirmedFriendList(member_no);
			model.addAttribute("ConfirmedFriendList", ConfirmedFriendList);
			
			//보낸친구요청(자기가 보낸 것)-주빈
			ArrayList<HashMap<String, Object>> meNo = memberService.selectMeNo(member_no);
			model.addAttribute("meNo", meNo);
			
			//***받은친구요청(자기가 받은 것)-주빈
			ArrayList<HashMap<String, Object>> youNo = memberService.selectYouNo(member_no);
			model.addAttribute("youNo", youNo);
			
			ArrayList<MemberFriendGroupVO> memberFriendGroupList = memberService.getMemberFriendGroupList(member_no);
			
			model.addAttribute("memberFriendGroupList", memberFriendGroupList);
			
			return "member/friendPage";
		}else {
			
			return "member/loginPage";
		}
				
	}
	
	//친구신청-주빈 
	@RequestMapping("insertFriend.do")
	public String insertFriend(MemberFriendVO memberFriendVO, HttpSession session) {
			
		MemberVO memberVO = (MemberVO)session.getAttribute("sessionUser");
		if(memberVO != null) {
			int me_no = memberVO.getMember_no();
			memberFriendVO.setMe_no(me_no);
			memberService.insertFriend(memberFriendVO);
			return "redirect:./friendPage.do";
		}else {
			return "member/loginPage";
		}
			
	}
	
	//친구신청 수락-주빈
	@RequestMapping("updateConfirm.do")
	public String updateConfirm(int friend_no) {
		
		memberService.updateFriendConfirm(friend_no);
		
		return "redirect:./friendPage.do";
	}
	
	//친구신청 거절-주빈
	@RequestMapping("updateRejection.do")
	public String updateRejection(int friend_no) {
		
		memberService.updateFriendRejection(friend_no);
		
		return "redirect:./friendPage.do";
	}
	
	//***친구그룹 생성-주빈
	@RequestMapping("setFrndGroup.do")
	public String setFrndGroup(MemberFriendGroupVO groupVO, HttpSession session) {
		
		MemberVO memberVO = (MemberVO)session.getAttribute("sessionUser");

		groupVO.setMember_no(memberVO.getMember_no());
		
		memberService.insertFrndGroup(groupVO);
		
		return "redirect:./friendPage.do";
	}
	
	//친구그룹 이름 불러오기-주빈
		@RequestMapping("getGroupName.do")
		public String getGroupName(int friend_group_no, int member_no) {
			
			ArrayList<HashMap<String, Object>> groupNameList = memberService.selectGroupName(friend_group_no, member_no);
			
			return "redirect:./friendPage.do";
		}
	
	//친구그룹 이름 수정-주빈
	@RequestMapping("setGroupNamePage.do")
	public String setGroupNamePage(MemberFriendGroupVO groupVO, Model model) {
		
		model.addAttribute("friend_group_no", groupVO.getFriend_group_no());
				
		return "member/setGroupNamePage";
	}
	
	//친구그룹 이름 수정-주빈
	@RequestMapping("setGroupName.do")
	public String setGroupName(MemberFriendGroupVO groupVO) {
		
		memberService.updateGroupName(groupVO);
		
		return "redirect:./friendPage.do";
	}
	
	
	//--------------------------------------------------------------------------------------------------------------
	//친구그룹 변경-주빈
		@RequestMapping("changeGroupPage.do")
		public String changeGroupPage(int friend_no, int friend_group_no) {
			memberService.updateGroupSet(friend_no, friend_group_no);
			return "redirect:./friendPage.do";
		}
		
		//--------------------------------------------------------------------------------------------------------------
		
		//메세지함-주빈
		@RequestMapping("messagePage.do")
		public String messagePage(Model model,@RequestParam(value = "message_type" , defaultValue = "2") int message_type ,HttpSession session) {
			
			MemberVO memberVO = (MemberVO)session.getAttribute("sessionUser");
			ArrayList<HashMap<String, Object>> friends = memberService.getFriendList(memberVO.getMember_no());
			model.addAttribute("message_type", message_type);
			model.addAttribute("friends", friends);
					
			
			if(memberVO != null) {
				ArrayList<HashMap<String, Object>> inBoxList = memberService.selectInbox(memberVO.getMember_no());
				model.addAttribute("inBoxList", inBoxList);
			}

			if(memberVO != null) {
				
				ArrayList<HashMap<String, Object>> sendMessageList = memberService.selectSendMsg(memberVO.getMember_no());
				
				model.addAttribute("sendMessageList", sendMessageList);
			}
			
			return "member/messagePage";
		}
		
		/*
		//받은 메세지함-주빈
		@RequestMapping("selectInbox.do")
		public String selectInbox(HttpSession session, MemberSendMessageVO memberSendMessageVO){
			
			MemberVO memberVO = (MemberVO)session.getAttribute("sessionUser");
			//memberSendMessageVO.setTo_member_no(memberVO.getMember_no()); && memberVO.getMember_no() == memberSendMessageVO.getTo_member_no()
			int to_member_no = memberVO.getMember_no();
			
			if(memberVO != null) {
				memberService.selectInbox(to_member_no);
			}
			
			
			return "redirect:./messagePage.do";
		}
		*/
		
		/*
		//보낸 메세지함-주빈
		@RequestMapping("sendMessage.do")
		public String sendMessage(HttpSession session, int message_type, Model model) {
			MemberVO memberVO = (MemberVO)session.getAttribute("sessionUser");
			
			if(memberVO != null) {
				
				ArrayList<HashMap<String, Object>> sendMessageList = memberService.selectSendMsg(memberVO.getMember_no());
				
				model.addAttribute("sendMessageList", sendMessageList);
			}
			return "redirect:./messagePage.do";
		}
		*/
		
				
		//회원쪽지보내기-주빈
		@RequestMapping("insertSendMessage.do")
		public String insertSendMessage(HttpSession session, MemberSendMessageVO memberSendMessageVO, int message_type) {
				
			
			MemberVO memberVO = (MemberVO)session.getAttribute("sessionUser");
			
			memberSendMessageVO.setFrom_member_no(memberVO.getMember_no());
			
			memberService.insertSendMessage2(memberSendMessageVO);
			
			return "redirect:./messagePage.do";
		}
		
		
		
		//쪽지 읽기/수신확인-주빈
		@RequestMapping("readMessage.do")
		public String readMessage(MemberSendMessageVO messageVO, Model model, HttpSession session) {
			memberService.updateReadCheck(messageVO);
			MemberVO memberVO = (MemberVO)session.getAttribute("sessionUser");
			
			messageVO.setTo_member_no(memberVO.getMember_no());
					
			MemberSendMessageVO inboxReadVO = memberService.selectInboxContent(messageVO);
			
			MemberVO fromMemberVO = memberService.selectMemberByMno(inboxReadVO.getFrom_member_no());
			String fromMemberNick = fromMemberVO.getMember_nick();
		
			System.out.println(inboxReadVO.getFrom_member_no());
			
			model.addAttribute("inboxReadVO", inboxReadVO);
			model.addAttribute("fromMemberNick", fromMemberNick);
			
			
			return "member/readMessage";
		}
		
		//보낸쪽지 확인/수신확인-주빈
		@RequestMapping("sendMsgRead.do")
		public String sendMsgRead(MemberSendMessageVO messageVO, Model model, HttpSession session) {
			memberService.updateReadCheck(messageVO);
			MemberVO memberVO = (MemberVO)session.getAttribute("sessionUser");
			
			messageVO.setFrom_member_no(memberVO.getMember_no());
			
			MemberSendMessageVO sendReadVO = memberService.selectSendContent(messageVO);
			
			MemberVO toMemberVO = memberService.selectMemberByMno(sendReadVO.getTo_member_no());
			String toMemberNick = toMemberVO.getMember_nick();
			
			System.out.println(sendReadVO);
			
			
			model.addAttribute("sendReadVO", sendReadVO);
			model.addAttribute("toMemberNick", toMemberNick);
			
			return "member/sendMsgRead";
		}
		
		//쪽지 삭제-주빈
		@RequestMapping("deleteMessageProcess.do")
		public String deleteMessageProcess(int[] sendmessage_no, Model model) {
				
			memberService.deleteMessageProcess(sendmessage_no);
				
			//model.addAttribute("message_type", 3);
				
			return "redirect:./messagePage.do?message_type=2";
		}
	
	
}
