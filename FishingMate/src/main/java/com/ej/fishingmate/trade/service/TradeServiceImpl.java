package com.ej.fishingmate.trade.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.commons.text.StringEscapeUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ej.fishingmate.member.mapper.MemberSQLMapper;
import com.ej.fishingmate.trade.mapper.TradeImageSQLMapper;
import com.ej.fishingmate.trade.mapper.TradeSQLMapper;
import com.ej.fishingmate.vo.ItemCategoryVO;
import com.ej.fishingmate.vo.MemberVO;
import com.ej.fishingmate.vo.TradeCommentVO;
import com.ej.fishingmate.vo.TradeEvaluateVO;
import com.ej.fishingmate.vo.TradeImageVO;
import com.ej.fishingmate.vo.TradeListVO;
import com.ej.fishingmate.vo.TradeVO;

@Service
public class TradeServiceImpl {
	
	@Autowired
	private TradeSQLMapper tradeSQLMapper;
	
	@Autowired
	private TradeImageSQLMapper tradeImageSQLMapper;
	
	@Autowired
	private MemberSQLMapper memberSQLMapper;
	
	public ArrayList<ItemCategoryVO> getItemList(){
		
		ArrayList<ItemCategoryVO> list = tradeSQLMapper.selectItemCategoryList();
		
		System.out.println(list);
		return list;
	}
	
	public void writeContent(TradeVO tradeVO, ArrayList<TradeImageVO> tradeImageVOList) {
		
		
		int trade_freeboard_no=tradeSQLMapper.createFreeboardKey();
		tradeVO.setTrade_freeboard_no(trade_freeboard_no);
		tradeSQLMapper.insert(tradeVO);
				
		for(TradeImageVO tradeImageVO: tradeImageVOList) {
			tradeImageVO.setTrade_freeboard_no(trade_freeboard_no);
			tradeImageSQLMapper.insert(tradeImageVO);
		}
	}
	
	public ArrayList<HashMap<String, Object>> getTradeList(){
		

		//제목 가격 작성자 작성날짜//찜  조회수 안함
		ArrayList<HashMap<String, Object>> result = new ArrayList<HashMap<String,Object>>();
		ArrayList<TradeVO> tradelist = tradeSQLMapper.selectAll();
		
		for(TradeVO tradeVO : tradelist) {
			
			HashMap<String , Object> map = new HashMap<String, Object>();
			
			int memberNo = tradeVO.getMember_no();
			int freeboardNo = tradeVO.getTrade_freeboard_no();
			
			MemberVO memberVO = memberSQLMapper.memberSelectByNo(memberNo);
			ArrayList<TradeImageVO> tradeImageVO = tradeImageSQLMapper.selectByFreeboardNo(freeboardNo);
			
			int wishcount = tradeSQLMapper.selectTradeFreeboardWishCount(freeboardNo);
			tradeVO.setTrade_freeboard_wishcount(wishcount);
			
			int itemNo = tradeVO.getItem_category_no();
			ItemCategoryVO itemCategoryVO = tradeSQLMapper.selectItemByNo(itemNo);
			
			//거래완료인지 판매중인지
			int completePurchaseCount= tradeSQLMapper.completePurchaseCount(freeboardNo);
			String tradeStatus ="";
			
			if(completePurchaseCount > 0) {
				tradeStatus="판매완료";
			}else {
				tradeStatus="판매중";
			}
			
			
			map.put("tradeImageVO", tradeImageVO);
			map.put("memberVO", memberVO);
			map.put("tradeVO", tradeVO);
			map.put("itemCategoryVO", itemCategoryVO);
			map.put("tradeStatus", tradeStatus);

			
			result.add(map);		
			
		}
		return result;
		
	}
	
	public HashMap<String, Object> getContent(int trade_freeboard_no, boolean isEscapeHtml){
		
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		
		TradeVO tradeVO = tradeSQLMapper.selectContentByNo(trade_freeboard_no);
		
		if(isEscapeHtml) {
			String content = tradeVO.getTrade_freeboard_content();
			
			content = StringEscapeUtils.escapeHtml4(content);
			content = content.replaceAll("\n", "<br>");
			
			tradeVO.setTrade_freeboard_content(content);;
		}
		
		
		int memberNo = tradeVO.getMember_no();
		MemberVO memberVO = memberSQLMapper.memberSelectByNo(memberNo);
		
		tradeSQLMapper.contentReadCount(trade_freeboard_no);
		
		ArrayList<TradeImageVO> tradeImageVO = tradeImageSQLMapper.selectByFreeboardNo(trade_freeboard_no);
		
		int itemNo = tradeVO.getItem_category_no();
		ItemCategoryVO itemCategoryVO = tradeSQLMapper.selectItemByNo(itemNo);
		

		System.out.println("조회수"+tradeVO.getTrade_freeboard_readcount());
		map.put("tradeVO", tradeVO);
		map.put("memberVO", memberVO);
		map.put("tradeImageVO", tradeImageVO);
		map.put("itemCategoryVO", itemCategoryVO);
	
		return map;
	}
	//게시글 수정
	public void modifyTradeContentByNo(TradeVO tradeVO) {
		tradeSQLMapper.modifyTradeContentByNo(tradeVO);
	}
	//게시글 삭제
	public void deleteTradeContent(int trade_freeboard_no) {
		tradeSQLMapper.deleteContentByNo(trade_freeboard_no);
	}
	
	//리플
	public void writeComment(TradeCommentVO tradeCommentVO) {
		
		tradeSQLMapper.insertComment(tradeCommentVO);
		
	}
	
	
	public ArrayList<HashMap<String, Object>> getCommentList(int trade_freeboard_no){
		
		ArrayList<HashMap<String, Object>> result = new ArrayList<HashMap<String, Object>>();
		ArrayList<TradeCommentVO> commentlist = tradeSQLMapper.selectCommentByNo(trade_freeboard_no);
		
		for(TradeCommentVO tradeCommentVO :commentlist) {
			
			HashMap<String, Object> map = new HashMap<String, Object>();
			MemberVO memberVO = memberSQLMapper.memberSelectByNo(tradeCommentVO.getMember_no());
			
			map.put("tradeCommentVO", tradeCommentVO);
			map.put("memberVO", memberVO);
			
			result.add(map);
		}
		
		return result;
		
	}
	
	public int tradeCommentCount(int trade_freeboard_no) {
		return tradeSQLMapper.tradeCommentCount(trade_freeboard_no);
	}
	
	public void deleteComment(int no) {
		tradeSQLMapper.deleteComment(no);
	}
	
	public void modifyTradeCommentByNo(TradeCommentVO tradeCommentVO) {
		tradeSQLMapper.modifyTradeCommentByNo(tradeCommentVO);
	}
	
	//찜 추천-----------------------------------------------------------
	   //찜 올리기 내리기
	public void upDownWishCount(int trade_freeboard_no, int member_no) {
		int chkWishCount = tradeSQLMapper.chkWishCount(trade_freeboard_no, member_no);
		if(chkWishCount > 0 ) {
			tradeSQLMapper.decreaseWishitem(trade_freeboard_no, member_no);
		}else {
			tradeSQLMapper.increaseWishitem(trade_freeboard_no, member_no);
		}
	}
	  //찜 여부
	public int chkWishCount(int trade_freeboard_no, int member_no) {
		return tradeSQLMapper.chkWishCount(trade_freeboard_no, member_no);
	}
	 //찜 수
	public int getTradeFreeboardWishCount(int trade_freeboard_no) {
		return tradeSQLMapper.selectTradeFreeboardWishCount(trade_freeboard_no);
	}
	// 거래 신청
	public void writeApply(TradeListVO tradeListVO){
		
		
		tradeSQLMapper.insertApply(tradeListVO);
		
	}
	
	public int applyStatus(int member_no, int trade_freeboard_no){
		
		
		int count = tradeSQLMapper.selectTradeListByMemberNoCount(member_no, trade_freeboard_no);
		
		return count;
	}
	
	public ArrayList<HashMap<String, Object>> getapplyList(int trade_freeboard_no){
		
		ArrayList<HashMap<String, Object>> result = new ArrayList<HashMap<String,Object>>();
		ArrayList<TradeListVO> list = tradeSQLMapper.selectTradeListByFreeboardNo(trade_freeboard_no);
		
		for(TradeListVO tradeListVO : list) {
			HashMap<String, Object> map = new HashMap<String, Object>();
			
			int buyer_member_no = tradeListVO.getMember_no();
			MemberVO memberVO = memberSQLMapper.selectByNo(buyer_member_no);
			
			int completePurchaseCount =tradeSQLMapper.completePurchaseCount(trade_freeboard_no);

			int ApplicantCount=tradeSQLMapper.numberOfApplicant(trade_freeboard_no);
			
			//매너점수 값
			double mannerValue=tradeSQLMapper.mannerValue(buyer_member_no);
			
			
			map.put("memberVO", memberVO);
			map.put("tradeListVO", tradeListVO);
			map.put("completePurchaseCount", completePurchaseCount);
			map.put("ApplicantCount", ApplicantCount);
			map.put("mannerValue", mannerValue);

			
			result.add(map);
		}
		return result;
	}
	
	//중고거래 승인신청
	public void rejectTrade(int trade_list_no) {
		tradeSQLMapper.rejectTradeByListNo(trade_list_no);
	}
	
	public void sellTrade(int trade_list_no) {
		tradeSQLMapper.sellTradeByListNo(trade_list_no);
	}
	
	
	//구매자에게 거절 알림창 띄우기
	public String rejectPopup(int trade_freeboard_no, int sessionMemberNo) {
		
		 return tradeSQLMapper.rejectPopupMemberNo(trade_freeboard_no, sessionMemberNo);
	}
	
	public int tradeCompleteSell(int trade_freeboard_no) {
		return tradeSQLMapper.tradeCompleteSell(trade_freeboard_no);
	}
	
	//재거래 하기 위해 기존 데이터 지우기
//	public void reTrade(int trade_freeboard_no, int member_no) {
//		tradeSQLMapper.updateApproveToN(trade_freeboard_no, member_no);
//	}
	
	//게시판 정보 가져오기 by no
	public TradeVO selectContentByNo(int trade_freeboard_no) {

       return tradeSQLMapper.selectContentByNo(trade_freeboard_no);
	}
	
	//구매자 이름
	public String selectSellerName(int trade_list_no) {
		TradeListVO tradeListVO = tradeSQLMapper.selectTradeListByTradeListNo(trade_list_no);
		int member_no = tradeListVO.getMember_no();
		MemberVO memberVO = memberSQLMapper.selectByNo(member_no);
		String member_nick = memberVO.getMember_nick();
		System.out.println("service에서"+member_nick);
		return member_nick;
	}
	
	//평가 정보
	public void evaluateInfo(TradeEvaluateVO tradeEvaluateVO, int trade_list_no) {
		TradeListVO tradeListVO = tradeSQLMapper.selectTradeListByTradeListNo(trade_list_no);
		int buyer_member_no = tradeListVO.getMember_no();
		tradeEvaluateVO.setBuyer_member_no(buyer_member_no);
		
		tradeSQLMapper.evaluateInfo(tradeEvaluateVO);
		double evaluateAvgByMemberNo= tradeSQLMapper.evaluateAvgByMemberNo(buyer_member_no);
		//반올림
		double evaluateAvgByMemberNoDecimal =Math.round(evaluateAvgByMemberNo*100)/100.0;
		
		tradeSQLMapper.memberEvaluateUpdate(evaluateAvgByMemberNoDecimal, buyer_member_no);
		tradeSQLMapper.completeEvaluate(trade_list_no);
		
		System.out.println("====");
		System.out.println("buyer_member_no"+buyer_member_no);
		System.out.println("평균"+evaluateAvgByMemberNoDecimal);
		System.out.println("====");
	}
	
	//구매완료 확인
	public int completePurchaseCount(int trade_freeboard_no) {
		return tradeSQLMapper.completePurchaseCount(trade_freeboard_no);
	}

	
	
	//통게용
	
	public ArrayList<HashMap<String, Object>> getCountByDate(){
		return tradeSQLMapper.getCountByDate();
	}
	
	public ArrayList<HashMap<String, Object>> getCountByGender(){
		return tradeSQLMapper.getCountByGender();
	}
	
}






































