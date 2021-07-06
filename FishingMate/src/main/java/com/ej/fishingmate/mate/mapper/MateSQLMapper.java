package com.ej.fishingmate.mate.mapper;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

import com.ej.fishingmate.vo.MateCategoryVO;
import com.ej.fishingmate.vo.MateConfirmVO;
import com.ej.fishingmate.vo.MateEvaluateVO;
import com.ej.fishingmate.vo.MateFreeboardCommentVO;
import com.ej.fishingmate.vo.MateFreeboardVO;
import com.ej.fishingmate.vo.MateGroupVO;
import com.ej.fishingmate.vo.MateWishVO;

public interface MateSQLMapper {

	//메이트 게시판 게시글 번호 받기 - 형준
	public int createMateFreeboardSequence();
	
	//메이트 게시판 글쓰기 - 형준
	public void insertMateFreeboardContent(MateFreeboardVO mateFreeboardVO);
	
	//메이트 카테고리 불러오기(1개) - 형준
	public MateCategoryVO selectOneMateCategory(int mate_category_no);
	
	//메이트 카테고리 불러오기 - 형준
	public ArrayList<MateCategoryVO> selectAllMateCategory();
	
	//메이트 게시판 글목록 불러오기 - 형준
	public ArrayList<MateFreeboardVO> selectMateAllContent(
			@Param("mate_category_no") int mate_category_no,
			@Param("fishing_category_no") int fishing_category_no,
			@Param("region_category_no") int region_category_no,
			@Param("pageNum") int pageNum);
	
	//메이트 게시판 글개수 불러오기 - 형준
	public int selectMateAllContentCount(
			@Param("mate_category_no") int mate_category_no,
			@Param("fishing_category_no") int fishing_category_no,
			@Param("region_category_no") int region_category_no);
	
	//메이트 게시판 글읽기 - 형준
	public MateFreeboardVO selectOneMateContent(int mate_freeboard_no);
	
	//메이트 게시판 조회수 늘리기 - 형준
	public void increaseContentReadCount(int mate_freeboard_no);
	
	//메이트 게시판 글 삭제 - 형준
	public void deleteMateContentByNo(int mate_freeboard_no);
	
	//메이트 게시판 글 수정 - 형준
	public void updateMateContentByNo(MateFreeboardVO mateFreeboardVO);
	
	//메이트 게시판 댓글쓰기 - 형준
	public void insertMateFreeboardComment(MateFreeboardCommentVO mateFreeboardCommentVO);
	
	//메이트 게시판 댓글 1개 불러오기 - 형준
	public MateFreeboardCommentVO selectMateOneCommentByNo(int mate_comment_no);
	
	//메이트 게시판 댓글 불러오기 - 형준
	public ArrayList<MateFreeboardCommentVO> selectMateAllCommentByNo(int mate_freeboard_no);
	
	//메이트 게시판 댓글 수 불러오기 - 형준
	public int selectMateCommentCountByNo(int mate_freeboard_no);
	
	//메이트 게시판 댓글 수정 - 형준
	public void updateMateCommentByNo(MateFreeboardCommentVO mateFreeboardCommentVO);
	
	//메이트 게시판 댓글 삭제 - 형준
	public void deleteMateCommentByNo(int mate_comment_no);
	
	//메이트 게시판 추천 수 올리기 - 형준
	public void increaseRecommendCount(
			@Param("mate_freeboard_no") int mate_freeboard_no,
			@Param("member_no") int member_no);
	
	//메이트 게시판 추천 수 내리기 - 형준
	public void decreaseRecommendCount(
			@Param("mate_freeboard_no") int mate_freeboard_no,
			@Param("member_no") int member_no);
	
	//메이트 게시판 추천 여부 확인 - 형준
	public int chkDoRecommend(
			@Param("member_no") int member_no,
			@Param("mate_freeboard_no") int mate_freeboard_no);
	
	//메이트 게시판 추천 수 불러오기 - 형준
	public int selectMateFreeboardRecommendCount(int mate_freeboard_no);
	
	//메이트 게시판 그룹 신청하기 - 형준
	public void insertMateGroup(MateGroupVO mateGroupVO);
	
	//메이트 게시판 그룹 신청 유무 확인 - 형준
	public int chkDoApplyGroup(
			@Param("member_no") int member_no,
			@Param("mate_freeboard_no") int mate_freeboard_no);
	
	//메이트 게시판 그룹 신청현황 불러오기 - 형준
	public ArrayList<MateGroupVO> selectMateApplyGroup(int mate_freeboard_no);
	
	//메이트 게시판 그룹 신청현황 인원 수 불러오기 - 형준
	public int selectMateApplyGroupCount(int mate_freeboard_no);
	
	//메이트 게시판 그룹 신청 거절하기 - 형준
	public void denyMateApplyGroup(
			@Param("member_no") int member_no,
			@Param("mate_freeboard_no") int mate_freeboard_no);
	
	//메이트 게시판 확정 그룹 인원 수 불러오기 - 형준
		public int selectMateConfrimGroupCount(int mate_freeboard_no);
	
	//메이트 게시판 확정 그룹에 회원 추가 - 형준
	public void insertMateConfirmGroup(
			@Param("mate_freeboard_no") int mate_freeboard_no,
			@Param("member_no") int member_no);
	
	//메이트 게시판 확정 그룹에 추가 시 회원의 요청상태 변경 - 형준
	public void updateApplyGroupApprove(
			@Param("member_no") int member_no,
			@Param("mate_freeboard_no") int mate_freeboard_no);
	
	//메이트 게시판 확정 그룹에 추가된 회원인지 확인 여부 - 형준
	public Integer chkMemberIntoMateConfirmGroup(
			@Param("member_no") int member_no,
			@Param("mate_freeboard_no") int mate_freeboard_no);
	
	//메이트 게시판 확정 그룹에서 회원 제거 - 형준
	public void deleteMateConfirmGroup(int mate_confirm_no);
	
	//메이트 게시판 확정 그룹에서 제거 시 회원 요청 상태 변경 - 형준
	public void updateApplyGroupDeny(
			@Param("member_no") int member_no,
			@Param("mate_freeboard_no") int mate_freeboard_no);
	
	//메이트 게시판 모집 취소 시 모집상태 변경 - 형준
	public void updateMateFreeboardStatusToCancel(int mate_freeboard_no);
	
	//------------------- 메이트 게시판 모집 완료 시 ---------------------------
	//메이트 게시판 모집상태 변경 - 형준
	public void updateMateFreeboardStatusToComplete(int mate_freeboard_no);
	
	//메이트 게시판 확정된 그룹 목록 불러오기 - 형준
	public ArrayList<MateConfirmVO> selectAllMateConfirmGroup(int mate_freeboard_no);
	
	//메이트 게시판 회원 간 평가하기(좋아요) - 형준
	public void evaluateGoodMateMember(MateEvaluateVO mateEvaluateVO);
	
	//메이트 게시판 회원 간 평가하기(나빠요) - 형준
	public void evaluateBadMateMember(MateEvaluateVO mateEvaluateVO);
	
	//평가한 점수 회원 매너점수에 부여 - 형준
	public void updateEvaluateValueFromMateEvaluate(MateEvaluateVO mateEvaluateVO);
	
	//메이트 게시판 평가여부 확인 - 형준
	public int chkEvaluateToMember(
			@Param("to_member_no") int to_member_no,
			@Param("from_member_no") int from_member_no,
			@Param("mate_confirm_no") int mate_confirm_no);
	
	//------------------- 메이트 게시판 모집 완료 시 끝 -------------------------	
	
	//------------------- 메이트 게시판 찜목록 관련 시작 - 형준 -----------------------
	//메이트 게시판 찜목록에 넣기 - 형준
	public void insertMateFreeboardInWishList(MateWishVO mateWishVO);
	
	//메이트 게시판 찜목록에서 제거 - 형준
	public void deleteMateFreeboardInWishList(MateWishVO mateWishVO);
	
	//메이트 게시판 찜목록 추가 여부 확인 - 형준
	public int chkInsertIntoWishList(
			@Param("member_no") int member_no,
			@Param("mate_freeboard_no") int mate_freeboard_no);
	
	//메이트 게시판 찜목록 불러오기 - 형준
	public ArrayList<MateWishVO> selectMateWishListByNo(int member_no);
	
	
	//------------------- 메이트 게시판 찜목록 관련 끝 ------------------------------
	
	
}
































