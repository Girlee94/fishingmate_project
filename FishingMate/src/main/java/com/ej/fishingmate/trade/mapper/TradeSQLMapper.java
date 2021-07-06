package com.ej.fishingmate.trade.mapper;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.annotations.Param;

import com.ej.fishingmate.vo.ItemCategoryVO;
import com.ej.fishingmate.vo.TradeCommentVO;
import com.ej.fishingmate.vo.TradeEvaluateVO;
import com.ej.fishingmate.vo.TradeListVO;
import com.ej.fishingmate.vo.TradeRecommendVO;
import com.ej.fishingmate.vo.TradeVO;

public interface TradeSQLMapper {
	
	public ArrayList<ItemCategoryVO> selectItemCategoryList();
	public void insert(TradeVO tradeVO);
	public int createFreeboardKey();
	
	public ArrayList<TradeVO> selectAll();
	
	//게시글 불러오기
	public TradeVO selectContentByNo(int trade_freeboard_no);
	
	//매너점수 값
	public double mannerValue(int buyer_member_no);
	
	//아이템카테고리 이름 불러오기
	public ItemCategoryVO selectItemByNo(int item_category_no);
	
	//게시글 수정
	public void modifyTradeContentByNo(TradeVO tradeVO);
	
	//게시판 삭제
	public void deleteContentByNo(int trade_freeboard_no);
	
	//게시판 조회수
	public int contentReadCount(int trade_freeboard_no);
	
	//댓글 입력
	public void insertComment(TradeCommentVO tradeCommentVO);
	
	//댓글 불러오기
	public ArrayList<TradeCommentVO> selectCommentByNo(int trade_freeboard_no);
	
	//댓글 수
	public int tradeCommentCount(int trade_freeboard_no);
	
	//댓글 삭제
	public void deleteComment(int no);
	
	//댓글 수정
	public void modifyTradeCommentByNo(TradeCommentVO tradeCommentVO);
	
	
	//찜 하기 추천 올리기
	public void increaseWishitem(
			@Param("trade_freeboard_no") int trade_freeboard_no,
			@Param("member_no") int member_no
			);
	//찜 취소 추천 내리기
	public void decreaseWishitem(
			@Param("trade_freeboard_no") int trade_freeboard_no,
			@Param("member_no") int member_no
			);
	
	//찜 추천 여부 확인
	public int chkWishCount(
			@Param("trade_freeboard_no") int trade_freeboard_no,
			@Param("member_no") int member_no
			);
	
	// 찜 추천 수 불러오기
	public int selectTradeFreeboardWishCount(int trade_freeboard_no);

	//중고거래신청입력
	public void insertApply(TradeListVO tradeListVO);
	
	public int selectTradeListByMemberNoCount(@Param("member_no") int member_no, @Param("trade_freeboard_no") int trade_freeboard_no);
	
	public ArrayList<TradeListVO> selectTradeListByFreeboardNo(int trade_freeboard_no);
	
	//신청자수
	public int numberOfApplicant(int trade_freeboard_no);
	
	//중고거래 APPROVE 바꾸기
	
	public void rejectTradeByListNo(int trade_list_no);
	
	public void sellTradeByListNo(int trade_list_no);

	
	//구매자에게 거절 알림창 띄우기
	public String rejectPopupMemberNo(@Param("trade_freeboard_no") int trade_freeboard_no, @Param("sessionMemberNo") int sessionMemberNo);
	
	//구매자 이름
	public TradeListVO selectTradeListByTradeListNo(int trade_list_no);
	
	//평가 정보
	public void evaluateInfo(TradeEvaluateVO tradeEvaluateVO);
	//매너점수 평균
	public double evaluateAvgByMemberNo(int buyer_member_no);
	
	//맴버 매너점수 업데이트
	public void memberEvaluateUpdate(@Param("member_evaluate_value") double member_evaluate_value, @Param("buyer_member_no") int buyer_member_no);
	//평가 완료
	public void completeEvaluate(int trade_list_no);
	
	
	public int completePurchaseCount(int trade_freeboard_no);
	//재거래 하기 위해 기존 데이터 지우기
	//public void updateApproveToN(@Param("trade_freeboard_no") int trade_freeboard_no, @Param("member_no") int member_no);
	
	
	public ArrayList<HashMap<String, Object>> getCountByDate();
	
	public ArrayList<HashMap<String, Object>> getCountByGender();
	
	public int tradeCompleteSell(int trade_freeboard_no);
	
	
	
	
	
	
	
	
	
}

















