package com.ej.fishingmate.showoff.mapper;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

import com.ej.fishingmate.vo.ShowOffCommentVO;
import com.ej.fishingmate.vo.ShowOffFishVO;
import com.ej.fishingmate.vo.ShowOffImageVO;
import com.ej.fishingmate.vo.ShowOffLevelHistoryVO;
import com.ej.fishingmate.vo.ShowOffVO;
import com.ej.fishingmate.vo.TopListVO;

public interface ShowOffSQLMapper {
	
	//게시글 번호 생성 명화
	public int createFreeboardKey();
	//게시글 삽입 명화
	public void insert(ShowOffVO showoffVO);
	//게시글 이미지 삽입 명화
	public void imageinsert(ShowOffImageVO showoffImageVO);
	//게시글 글 불러오기 명화
	public ShowOffVO selectContentByNo(int no);
	//게시글 물고기 이름 불러오기 명화
	public String Fishname(int no);
	//게시글 물고기 이름 불러오기2 명화
	public String Fishname2(int no);
	//게시글 이미지 불러오기 명화
	public ArrayList<ShowOffImageVO> selectByFreeboardNo(int freeboard_no);
	//게시글 리스트 불러오기 명화
	public ArrayList<ShowOffVO> selectAll();
	//게시글 삭제 명화
	public void deleteContent(int freeboard_no);
	//게시글 수정 명화
	public void updateContent(ShowOffVO showoffVO);
	//게시글 이미지 삭제 명화
	public void imageDelete(@Param("freeboard_no") int freeboard_no);
	//추천 갯수 표시 명화
	public int selectRecommendCountByFreeboardNo(int freeboard_no);
	// 추천했나 확인 명화
	public int selectRecommendCountByFreeboardNoAndMemberNo(
			@Param("freeboard_no") int freeboard_no , 
			@Param("member_no") int member_no);
	//추천 하기 명화
	public void insertRecommend(@Param("freeboard_no") int freeboard_no , 
								@Param("member_no") int member_no);
	//추천 취소 명화
	public void deleteRecommend(
			@Param("freeboard_no") int freeboard_no , 
			@Param("member_no") int member_no);
	//댓글 목록 갯수 명화
	public int commentCount(int freeboard_no);
	//조회수 올리기 명화
	public void updateReadCount(int freeboard_no);
	//댓글 관련 명화
	public int selectCommentCountByNo(int no);
	//댓글 삽입 명화
	public void insertComment(ShowOffCommentVO commentVO);
	//댓글 리스트 명화
	public ArrayList<ShowOffCommentVO> selectContentCommentByNo(int no);
	//댓글 삭제 명화
	public void deleteComment(int commentno);
	//댓글 수정 명화
	public void updateComment(ShowOffCommentVO commentVO);
	//댓글 불러오기 명화
	public ShowOffCommentVO RecallComment(int showoff_comment_no);
	// 리스트 TOP3 명화
	public ArrayList<TopListVO> toplist();
	//어종 종류 불러오기 명화
	public ArrayList<ShowOffFishVO> selectFishList();
	//어종 점수 불러오기 명화
	public int selectScore(int fish_no);
	//어종 총합 불러오기 명화
	public int selectTotalFish();
	//어종별 갯수 불러오기 명화
	public int selectFish(int fish_no);
	// 경험치 불러오기 명화
	public double selectlevelvalue(int no);
	//경험치 증가 명화
	public void levelvalueadd(@Param("totalScore") double totalScore,
				@Param("member_no") int member_no);
	// 경험치 기록 명화
	public void levelvalueHistory(@Param("member_no") int member_no,
			@Param("showoff_freeboard_levelvalue") double showoff_freeboard_levelvalue,
			@Param("levelvalue") int levelvalue);
	//경험치 감소 명화
	public void levelvaluesub(@Param("totalScore") double totalScore,
			@Param("member_no") int member_no);
	//페이징 명화
	public ArrayList<ShowOffVO> selectFreeboardContent(
			@Param("searchWord") String searchWord , 
			@Param("searchType") String searchType ,
			@Param("pageNum") int pageNum 
			);
	//페이징2 명화
	public int selectContentCount();
	
}
