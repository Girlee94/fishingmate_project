package com.ej.fishingmate.event.controller;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ej.fishingmate.event.service.EventServiceImpl;
import com.ej.fishingmate.vo.EventRecommendVO;
import com.ej.fishingmate.vo.EventWishlistVO;
import com.ej.fishingmate.vo.MemberVO;

@Controller
@ResponseBody
@RequestMapping("/event/*")
public class RestEventController {
	
	@Autowired
	private EventServiceImpl eventService;
	
	//세션정보 불러오기 
	@RequestMapping("getSessionMemberNo.do")
	public HashMap<String, Object> getSessionMemberNo(HttpSession session) {
		MemberVO memberVO = (MemberVO)session.getAttribute("sessionUser");
		int member_no = memberVO.getMember_no();
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		
		map.put("result", "success");
		
		if(memberVO != null) {
			map.put("member_no", member_no);
		}
		
		return map;
	}
	
	//좋아요(추천)
	@RequestMapping("recommend.do")
	public void recommend(EventRecommendVO recommendVO, HttpSession session) {
		
		MemberVO memberVO = (MemberVO)session.getAttribute("sessionUser");
		int member_no = memberVO.getMember_no();
		recommendVO.setMember_no(member_no);
		
		eventService.Recommend(recommendVO);
		
	}
	
	//좋아요 해제
	@RequestMapping("deleteRecommend.do")
	public void deleteRecommend(EventRecommendVO recommendVO, HttpSession session) {
		MemberVO memberVO = (MemberVO)session.getAttribute("sessionUser");
		int member_no = memberVO.getMember_no();
		recommendVO.setMember_no(member_no);
		
		eventService.deleteRecommend(recommendVO);
	}
	
	//좋아요 카운트
	@RequestMapping("getRecommendData.do")
	public HashMap<String, Object> getRecommendData(int event_freeboard_no, HttpSession session) {
		MemberVO memberVO = (MemberVO)session.getAttribute("sessionUser");
				
		HashMap<String, Object> map = new HashMap<String, Object>();
		
		int recommendCount = eventService.getRecommendCount(event_freeboard_no);
		
		map.put("result", "success");
		map.put("recommendCount", recommendCount);
		
		if(memberVO != null) {
			int sessionNo = memberVO.getMember_no();
			int myRecommendCount = eventService.getMyRecommendCount(sessionNo, event_freeboard_no);
			map.put("myRecommendCount", myRecommendCount);
		}else {
			map.put("myRecommendCount", 0);
		}
		
		return map;
	}
	
	//찜하기(위시리스트)
	@RequestMapping("wishlist.do")
	public void wishlist(EventWishlistVO wishlistVO, HttpSession session) {
		MemberVO memberVO = (MemberVO)session.getAttribute("sessionUser");
		int member_no = memberVO.getMember_no();
		wishlistVO.setMember_no(member_no);
		
		eventService.insertWishlist(wishlistVO);
	}
	
	//찜하기 해제
	@RequestMapping("deleteWishlist.do")
	public void deleteWishlist(EventWishlistVO wishlistVO, HttpSession session) {
		MemberVO memberVO = (MemberVO)session.getAttribute("sessionUser");
		int member_no = memberVO.getMember_no();
		wishlistVO.setMember_no(member_no);
		
		eventService.deleteWishlist(wishlistVO);
	}

	//찜하기 카운트
	@RequestMapping("getWishlistData.do")
	public HashMap<String, Object> getWishlistData(int event_freeboard_no, HttpSession session) {
		MemberVO memberVO = (MemberVO)session.getAttribute("sessionUser");
						
		HashMap<String, Object> map = new HashMap<String, Object>();
		
		map.put("result", "success");
				
		if(memberVO != null) {
			int sessionNo = memberVO.getMember_no();
			int wishlistCount = eventService.getMyWishlistCount(sessionNo, event_freeboard_no);
			map.put("wishlistCount", wishlistCount);
		}else {
			map.put("wishlistCount", 0);
		}
		
		
		return map;
	}
}
