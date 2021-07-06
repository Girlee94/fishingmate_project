package com.ej.fishingmate.showoff.controller;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ej.fishingmate.showoff.service.ShowOffServicelmpl;
import com.ej.fishingmate.vo.MemberVO;
import com.ej.fishingmate.vo.ShowOffCommentVO;

@Controller
@RequestMapping("/Showoff/*")
@ResponseBody
public class RestShowOffController {
	@Autowired
	private ShowOffServicelmpl showOffServicel;
	
	@RequestMapping("writeComment.do")
	public void writeComment(HttpSession session, ShowOffCommentVO showOffCommentVO) {
		
		MemberVO memberVO = (MemberVO)session.getAttribute("sessionUser");
		showOffCommentVO.setMember_no(memberVO.getMember_no());
		
		showOffServicel.writeComment(showOffCommentVO);
		
	}
	@RequestMapping("getCommentList.do")
	public ArrayList<HashMap<String, Object>> getCommentList(int freeboard_no){
		
		return showOffServicel.getContenCommentByNo(freeboard_no);
		
	}
	@RequestMapping("UpdateComment.do")
	public void UpdateComment(ShowOffCommentVO showOffCommentVO) {
		showOffServicel.updateComment(showOffCommentVO);
	}
	@RequestMapping("deleteComment.do")
	public void deleteComment(int comment_no) {
		showOffServicel.deleteCommentByMno(comment_no);
	}
	@RequestMapping("CommentRecall.do")
	public HashMap<String, Object> CommentRecall(int comment_no) {
		 return showOffServicel.RecallComment(comment_no);
	}
	@RequestMapping("recommend.do")
	public void ReCommend(HttpSession session , int freeboard_no) {
			
		MemberVO sessionUser = (MemberVO)session.getAttribute("sessionUser");
		int member_no = sessionUser.getMember_no();
			
		showOffServicel.recommend(freeboard_no, member_no);		
	}
	@RequestMapping("getRecommendData.do")
	public HashMap<String,Object> getRecommandData(HttpSession session , int freeboard_no){
		
		HashMap<String,Object> map = new HashMap<String,Object>();
		
		map.put("result", "success");
		
		int recommendCount = showOffServicel.getRecommendCount(freeboard_no);
		map.put("recommendTotalCount" , recommendCount);
		
		MemberVO memberVO = (MemberVO)session.getAttribute("sessionUser");

		if(memberVO != null) {
			int member_no = memberVO.getMember_no();
			int myRecommendCount = showOffServicel.getMyRecommendCount(freeboard_no, member_no);
			map.put("myRecommendCount", myRecommendCount);
		}else {
			map.put("myRecommendCount", 0);
		}
		
		return map;
	}
	@RequestMapping("mainPage.do")
	public HashMap<String,Object> mainPage(String search_word , String search_type , 
			@RequestParam(defaultValue = "1") int page_num) {
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		//할것 많음!!!!! 
		ArrayList<HashMap<String, Object>> freeboardList = 
				showOffServicel.getFreeboardList(search_word , search_type , page_num);
		
		int count = showOffServicel.getContentCount();
		
		int totalPageCount = (int)Math.ceil(count/4.0);
		int currentPage = page_num;
		
		int beginPage = ((currentPage-1)/5)*5 + 1;
		int endPage = ((currentPage-1)/5 + 1)*(5);
		
		if(endPage > totalPageCount) {
			endPage = totalPageCount;
		}
		map.put("beginPage", beginPage);
		map.put("endPage", endPage);
		map.put("currentPage", currentPage);
		map.put("totalPageCount", totalPageCount);
		map.put("freeboardList", freeboardList);
		map.put("contentCount", count);
	
		
		return map;
	}
	

}
