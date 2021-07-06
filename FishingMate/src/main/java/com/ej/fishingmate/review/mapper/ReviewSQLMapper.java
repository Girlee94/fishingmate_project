package com.ej.fishingmate.review.mapper;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

import com.ej.fishingmate.vo.ReviewCommentVO;
import com.ej.fishingmate.vo.ReviewVO;

public interface ReviewSQLMapper {
	
	public void insert(ReviewVO reviewVO);
	
	//리뷰 게시판 리스트
	public ArrayList<ReviewVO> reviewAll();
	
	//리뷰 게시판 리스트
	public ReviewVO reviewByNo(int no);

	//리뷰 게시글 삭제
	public void reviewDeleteByNo(int no);		
	
	//게시글 번호 생성
	public int createReviewKey();
		
	//게시글 수정
	public void reviewUpdateContent(ReviewVO reviewVO);
	
	//게시글 조회수
	public void reviewUpdateReadCount(int review_freeboard_no);
	
	//게시글 갯수
	public int reviewContentCount();
	
	//리뷰 게시판 댓글 삽입
	public void reviewInsertComment(ReviewCommentVO reviewCommentVO);

	public ArrayList<ReviewCommentVO> reviewCommentByFreeboardNo(int review_freeboard_no);
		
	public ReviewCommentVO reviewCommentByCommentNo(int review_comment_no);
	
	//리뷰 게시판 댓글 삭제
	public void reviewDeleteCommentByNo(int no);
	
	//리뷰 게시판 댓글 수정
	public void reviewModifyCommentByMnoAndCno(ReviewCommentVO reviewCommentVO);
	
	//리뷰 게시판 댓글 1개 불러오기
	public ReviewCommentVO reviewSelectCommentByMnoAndCno(
			@Param("member_no") int member_no,
			@Param("review_comment_no") int review_comment_no);
	
	//리뷰 게시판 댓글 갯수
	public int reviewSelectCommentCountByNo(int no);
	
	//추천 수 올리기
	public void upRecommendCount(@Param("review_freeboard_no")int review_freeboard_no,
								 @Param("member_no")int member_no);
	
	//추천 수 내리기
	public void downRecommendCount(@Param("review_freeboard_no")int review_freeboard_no,
			         			   @Param("member_no")int member_no);
	
	//추천 여부 확인
	public int checkRecommend(@Param("member_no")int member_no, 
							  @Param("review_freeboard_no")int review_freeboard_no);
	
	//추천수 불러오기
	public int selectReviewRecommendCount(int review_freeboard_no);
	
	
	

}
