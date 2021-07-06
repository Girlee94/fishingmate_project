package com.ej.fishingmate.review.controller;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ej.fishingmate.review.service.ReviewServiceImpl;
import com.ej.fishingmate.vo.MemberVO;
import com.ej.fishingmate.vo.ReviewCommentVO;

@Controller
@RequestMapping("/review/*")
@ResponseBody
public class RestReviewController {
	
	@Autowired
	private ReviewServiceImpl reviewService;
	
	//----------------------------------댓글 시작 ------------------------------------------------
	//댓글 쓰기
	@RequestMapping("reviewWriteComment.do")
	public void reviewWriteComment(HttpSession session , ReviewCommentVO reviewCommentVO) {
		
		MemberVO memberVO = (MemberVO)session.getAttribute("sessionUser");
		reviewCommentVO.setMember_no(memberVO.getMember_no());
		
		reviewService.reviewInsertComment(reviewCommentVO);
	}
	//댓글 불러오기
	@RequestMapping("getReviewComment.do")
	public HashMap<String, Object> getReviewComment(int review_freeboard_no){
		HashMap<String, Object> map = new HashMap<String, Object>();
		
		int commentCount = reviewService.getReviewCommentCountByNo(review_freeboard_no);
		ArrayList<HashMap<String, Object>> CommentList = reviewService.getReviewCommentList(review_freeboard_no);
		
		map.put("commentCount", commentCount);
		map.put("CommentList", CommentList);
		
		return map;
	}
	
	//댓글 삭제
	@RequestMapping("reviewDeleteCommentProcess.do")
	public void reviewDeleteCommentProcess(int review_comment_no) {
		
		reviewService.reviewDeleteCommentByNo(review_comment_no);
	}
	
	//댓글 수정
	@RequestMapping("reviewModifyCommentProcess.do")
	public void reviewModifyCommentProcess(ReviewCommentVO reviewCommentVO) {
		
		reviewService.reviewModifyCommentByMnoAndCno(reviewCommentVO);
	}
	
	//댓글 한개 불러오기
	@RequestMapping("getReviewOneComment.do")
	public HashMap<String, Object> getReviewOneComment(int member_no, int review_comment_no){
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		
		map.put("reviewCommentVO", reviewService.getReviewCommentByMnoAndCno(member_no, review_comment_no));
		
		return map;
	}
	//----------------------------------댓글 끝 ------------------------------------------------
	
	//----------------------------------추천 시작-----------------------------------------------
	@RequestMapping("Recommend.do")
	public void Recommend(int review_freeboard_no, HttpSession session) {
		
		MemberVO memberVO = (MemberVO) session.getAttribute("sessionUser");
		reviewService.reviewRecommendCount(review_freeboard_no, memberVO.getMember_no());
	}
	@RequestMapping("getRecommend.do")
	public HashMap<String, Object> getRecommend(int review_freeboard_no , HttpSession session){
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		MemberVO memberVO = (MemberVO) session.getAttribute("sessionUser");
		
		map.put("result", "success");
		
		int recommendCount = reviewService.getReviewRecommendCount(review_freeboard_no);
		map.put("recommendCount", recommendCount);
		
		if(memberVO != null) {
			int checkRecommend = reviewService.checkRecommend(memberVO.getMember_no(), review_freeboard_no);
			map.put("checkRecommend", checkRecommend);
		}else {
			map.put("checkRecommend", 0);
		}
		
		return map;
	}
	
	
	//----------------------------------추천 끝-----------------------------------------------
	
	
	
}
















