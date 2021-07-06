package com.ej.fishingmate.member.controller;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ej.fishingmate.event.service.EventServiceImpl;
import com.ej.fishingmate.member.service.MemberServiceImpl;
import com.ej.fishingmate.vo.MemberVO;

@Controller
@RequestMapping("/member/*")
@ResponseBody
public class RestMemberController {

	@Autowired
	private MemberServiceImpl memberService;
	@Autowired
	private EventServiceImpl eventService;
	
	@RequestMapping("getSessionMemberNo.do")
	public HashMap<String, Object> getSessionMemberNo(HttpSession session){
		HashMap<String, Object> map = new HashMap<String, Object>();
		
		MemberVO memberVO = (MemberVO)session.getAttribute("sessionUser");
		
		if (memberVO != null) {
			map.put("member_no", memberVO.getMember_no());
		}
		
		return map;
	}
	//마이페이지 위시리스트 목록-주빈
	@RequestMapping("myPageWishlist.do")
	public ArrayList<HashMap<String, Object>> myPageWishlist(@RequestParam(defaultValue="0") int member_no){
		ArrayList<HashMap<String, Object>> mPgWishlist = eventService.selectMyWishlist(member_no);
				
		return mPgWishlist;
	}
	
	@RequestMapping("getSessionMemberinfo.do")
	public HashMap<String, Object> getSessionMemberinfo(HttpSession session){
		
		MemberVO memberVO =(MemberVO)session.getAttribute("sessionUser");
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		if(memberVO != null) {
			map.put("memberNo", memberVO.getMember_no());
			map.put("memberNick", memberVO.getMember_nick());
			map.put("memberLevelvalue", memberVO.getMember_levelvalue());
		}else {
			map.put("memberNo", null);
		}
		
	return map;	
	}
}