package com.ej.fishingmate.review.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.commons.lang3.StringEscapeUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ej.fishingmate.member.mapper.MemberSQLMapper;
import com.ej.fishingmate.review.mapper.ReviewImageSQLMapper;
import com.ej.fishingmate.review.mapper.ReviewSQLMapper;
import com.ej.fishingmate.vo.MemberVO;
import com.ej.fishingmate.vo.ReviewCommentVO;
import com.ej.fishingmate.vo.ReviewImageVO;
import com.ej.fishingmate.vo.ReviewVO;

@Service
public class ReviewServiceImpl {
	
	@Autowired
	private ReviewSQLMapper reviewSQLMapper;

	@Autowired
	private MemberSQLMapper memberSQLMapper;
	
	@Autowired
	private ReviewImageSQLMapper reviewImageSQLMapper;
	
	//리뷰 게시판 작성
	public void reviewWriteContent(ReviewVO reviewVO , ArrayList<ReviewImageVO> reviewImageVOList) {
		int review_freeboard_no = reviewSQLMapper.createReviewKey();
		reviewVO.setReview_freeboard_no(review_freeboard_no);
		reviewSQLMapper.insert(reviewVO);
		
		for(ReviewImageVO reviewImageVO : reviewImageVOList) {
			reviewImageVO.setReview_freeboard_no(review_freeboard_no);
			reviewImageSQLMapper.reviewImageInsert(reviewImageVO);			
		}		
	}
	//리뷰 게시판 이미지 삭제
	public void deleteContentImage(int review_freeboard_no) {
		reviewImageSQLMapper.imageDelete(review_freeboard_no);
	}
	
	
	//리뷰 게시판 불러오기
	public ArrayList<HashMap<String, Object>> getReviewList(){
		
		ArrayList<HashMap<String, Object>> result =
				new ArrayList<HashMap<String,Object>>();
		
		ArrayList<ReviewVO> reviewlist = reviewSQLMapper.reviewAll();
		
		for(ReviewVO reviewVO : reviewlist) {
			
			HashMap<String, Object> map = new HashMap<String, Object>();
			
			ArrayList<ReviewImageVO> reviewImageVOList =
					reviewImageSQLMapper.reviewSelectByFreeboardNo(reviewVO.getReview_freeboard_no());
			
			int memberNo = reviewVO.getMember_no();
			MemberVO memberVO = memberSQLMapper.reviewByNo(memberNo);
			int commtentCount = reviewSQLMapper.reviewSelectCommentCountByNo(reviewVO.getReview_freeboard_no());
			
			map.put("reviewImageVOList", reviewImageVOList);
			map.put("commentCount", commtentCount);
			map.put("memberVO", memberVO);
			map.put("reviewVO", reviewVO);
			
			result.add(map);						
		}
		
		return result;
	}
	//리뷰 게시판 읽기
	public HashMap<String, Object> getReviewContent(int review_freeboard_no, boolean isEscapeHtml){
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		
		ReviewVO reviewVO = reviewSQLMapper.reviewByNo(review_freeboard_no);
		int member_no = reviewVO.getMember_no();
		
		if(isEscapeHtml) {
			String content = reviewVO.getReview_freeboard_content();
			
			content = StringEscapeUtils.escapeHtml4(content);
			content = content.replaceAll("\n", "<br>");
			
			reviewVO.setReview_freeboard_content(content);
		}
		
		ArrayList<ReviewImageVO> reviewImageVOList =
				reviewImageSQLMapper.reviewSelectByFreeboardNo(review_freeboard_no);
		
		MemberVO memberVO = memberSQLMapper.reviewByNo(member_no);		
		
		map.put("reviewImageVOList", reviewImageVOList);
		map.put("memberVO", memberVO);
		map.put("reviewVO", reviewVO);
		
		return map;
	}
	
	//리뷰 게시판 삭제
	public void reviewDeleteContent(int review_freeboard_no) {
		
		reviewSQLMapper.reviewDeleteByNo(review_freeboard_no);
	}
	
	//리뷰 게시판 수정	
	public void reviewUpdateContent(ReviewVO reviewVO) {
		reviewSQLMapper.reviewUpdateContent(reviewVO);
	}
	
	//리뷰 게시판 조회수
	public void reviewIncreaseReadCount(int review_freeboard_no) {
		
		reviewSQLMapper.reviewUpdateReadCount(review_freeboard_no);
	}
	
	//리뷰 게시판 글 갯수
	public int getReviewContentCount() {
		
		int count = reviewSQLMapper.reviewContentCount();
		
		return count;
	}
	

	//리뷰게시판 댓글
	public void reviewInsertComment(ReviewCommentVO reviewCommentVO) {
		
		reviewSQLMapper.reviewInsertComment(reviewCommentVO);
	}
	
	
	//리뷰 게시판 댓글 불러오기
	public ArrayList<HashMap<String, Object>> getReviewCommentList(int review_freeboard_no) {
		
		ArrayList<HashMap<String, Object>> result = new ArrayList<HashMap<String,Object>>();
		
		ArrayList<ReviewCommentVO> reviewCommentlist = reviewSQLMapper.reviewCommentByFreeboardNo(review_freeboard_no);
		
		for(ReviewCommentVO reviewCommentVO : reviewCommentlist) {
			HashMap<String, Object> map = new HashMap<String, Object>();
			
			int member_no = reviewCommentVO.getMember_no();
			MemberVO memberVO = memberSQLMapper.reviewByNo(member_no);
			
			map.put("memberVO", memberVO);
			map.put("reviewCommentVO", reviewCommentVO);
			
			result.add(map);						
		}		
		return result;
	}
	
	//리뷰 게시판 댓글 달기
	public ReviewCommentVO getReviewComment(int review_comment_no) {
		ReviewCommentVO reviewCommentVO = reviewSQLMapper.reviewCommentByCommentNo(review_comment_no);
		
		return reviewCommentVO;
	}

	//리뷰 게시판 댓글 지우기
	public void reviewDeleteCommentByNo(int review_comment_no) {
		
		reviewSQLMapper.reviewDeleteCommentByNo(review_comment_no);
		
	}
	//리뷰 게시판 댓글 수정하기
	public void reviewModifyCommentByMnoAndCno(ReviewCommentVO reviewCommentVO) {
		
		reviewSQLMapper.reviewModifyCommentByMnoAndCno(reviewCommentVO);
	}
	
	//리뷰 게시판 댓글 1개 불러오기
	public ReviewCommentVO getReviewCommentByMnoAndCno(int member_no, int review_comment_no) {
		
		return reviewSQLMapper.reviewSelectCommentByMnoAndCno(member_no, review_comment_no);
	}
	
	//리뷰 게시판 댓글 수
	public int getReviewCommentCountByNo(int review_freeboard_no) {
		
		return reviewSQLMapper.reviewSelectCommentCountByNo(review_freeboard_no);
	}
	
	//리뷰 게시판 추천수 업 다운
	public void reviewRecommendCount(int review_freeboard_no, int member_no) {
		int checkRecommend = reviewSQLMapper.checkRecommend(member_no, review_freeboard_no);
		
		if(checkRecommend > 0) {
			reviewSQLMapper.downRecommendCount(review_freeboard_no, member_no);
		}else {
			reviewSQLMapper.upRecommendCount(review_freeboard_no, member_no);
		}
	}
	
	//리뷰 게시판 추천 여부 확인
	public int checkRecommend(int member_no, int review_freeboard_no) {
		
		return reviewSQLMapper.checkRecommend(member_no, review_freeboard_no);
	}
	
	//리뷰 게시판 추천 수 불러오기
	public int getReviewRecommendCount(int review_freeboard_no) {
		
		return reviewSQLMapper.selectReviewRecommendCount(review_freeboard_no);
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
