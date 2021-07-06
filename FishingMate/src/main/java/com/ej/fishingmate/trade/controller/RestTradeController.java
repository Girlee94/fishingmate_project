package com.ej.fishingmate.trade.controller;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ej.fishingmate.trade.service.TradeServiceImpl;
import com.ej.fishingmate.vo.MemberVO;
import com.ej.fishingmate.vo.TradeCommentVO;
import com.ej.fishingmate.vo.TradeEvaluateVO;
import com.ej.fishingmate.vo.TradeListVO;
import com.ej.fishingmate.vo.TradeVO;

@Controller
@RequestMapping("/trade/*")
@ResponseBody
public class RestTradeController {
	
	@Autowired
	private TradeServiceImpl tradeService;
	//글 수정
	@RequestMapping("modifyContentProcess.do")
	public void modifyContentProcess(TradeVO tradeVO) {
		
		
		tradeService.modifyTradeContentByNo(tradeVO);
	}
	
	//리플
	@RequestMapping("writeComment.do")
	public void writeComment(TradeCommentVO tradeCommentVO, HttpSession session) {
		
		MemberVO memberVO = (MemberVO)session.getAttribute("sessionUser");
		int member_no = memberVO.getMember_no();
		
		tradeCommentVO.setMember_no(member_no);
		tradeService.writeComment(tradeCommentVO);
		
	}
	
	@RequestMapping("deleteComment.do")
	public void deleteComment(int trade_comment_no) {
		tradeService.deleteComment(trade_comment_no);
		
	}
	
	@RequestMapping("modifyCommentProcess.do")
	public void modifyCommentProcess(TradeCommentVO tradeCommentVO) {
		tradeService.modifyTradeCommentByNo(tradeCommentVO);
	}
	
	@RequestMapping("getCommentList.do")
	public HashMap<String, Object> getCommentList(int trade_freeboard_no){
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		ArrayList<HashMap<String, Object>> tradeCommentList = tradeService.getCommentList(trade_freeboard_no);
		int commentCount = tradeService.tradeCommentCount(trade_freeboard_no);
		
		map.put("tradeCommentList", tradeCommentList);
		map.put("commentCount", commentCount);
		
		return map;
		
	}
	
	//찜 추천
	@RequestMapping("doWish.do")
	public void doWish(int trade_freeboard_no, HttpSession session ) {
		
		MemberVO memberVO = (MemberVO)session.getAttribute("sessionUser");
		tradeService.upDownWishCount(trade_freeboard_no, memberVO.getMember_no());
		
	}
	
	@RequestMapping("getWishData.do")
	public HashMap<String, Object> getWishData (int trade_freeboard_no, HttpSession session){
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		
		MemberVO memberVO = (MemberVO)session.getAttribute("sessionUser");

		if (memberVO != null) {
			int wishCount= tradeService.getTradeFreeboardWishCount(trade_freeboard_no);
			map.put("wishTotalCount", wishCount);	
			int myWishCount = tradeService.chkWishCount(trade_freeboard_no, memberVO.getMember_no());
			map.put("myWishCount", myWishCount);
		}else {
			int wishCount= tradeService.getTradeFreeboardWishCount(trade_freeboard_no);
			map.put("wishTotalCount", wishCount);
			map.put("myWishCount", 0);
		}
		return map;
	}		
		//중고거래 신청  페이지
			
    	@RequestMapping("tradeApplyProcess.do")
		public void tradeApplyPage(HttpSession session, TradeListVO tradeListVO) {
				
			MemberVO memberVO = (MemberVO)session.getAttribute("sessionUser");
			int member_no = memberVO.getMember_no();
			tradeListVO.setMember_no(member_no);
			tradeService.writeApply(tradeListVO);
			
			

			}
    	
    	
    	//중고거래 신청 확인 리스트 페이지
    	@RequestMapping("tradeApplyConfirmListPage.do")
   		public ArrayList<HashMap<String, Object>> tradeApplyConfirmListPage(int trade_freeboard_no) {
    		
    		return tradeService.getapplyList(trade_freeboard_no);
    				
    	}
    	
    	//중고거래 거절
    	@RequestMapping("rejectProcess.do")
    	public void rejectProcess(int trade_list_no) {
    		
    		System.out.println(trade_list_no + " ---");
    		
    		tradeService.rejectTrade(trade_list_no);
    	}
    	
//    	@RequestMapping("notRejectProcess.do")
//        public void notRejectProcess(int trade_list_no) {
//    		
//    		
//    		tradeService.notRejectTrade(trade_list_no);
//    	} 
    	
    	//구매자에게 거절 알림창 띄우기
    	@RequestMapping("rejectPopup.do")
    	public HashMap<String, Object> rejectPopup(int trade_freeboard_no, int sessionMemberNo) {
    		//System.out.println("안녕"+tradeService.rejectPopup(trade_freeboard_no, sessionMemberNo));
    		HashMap<String, Object> map = new HashMap<String, Object>();
    		map.put("result",tradeService.rejectPopup(trade_freeboard_no, sessionMemberNo));
    		map.put("sellcomplete", tradeService.tradeCompleteSell(trade_freeboard_no));
    		 return map;
    		
    	}
    	
    	//거절후 재거래창 (기존 db 데이터 날리기)
//    	@RequestMapping("reTrade.do")
//    	public void reTrade(int trade_freeboard_no, int member_no) {
//    		tradeService.reTrade(trade_freeboard_no, member_no);
//    	}
    	
    	//구매 완료인지 구매신청인지 판별하는 코드
    	@RequestMapping("aboutPurchasebtn.do")
    	public HashMap<String, Object> aboutPurchaseBtn(int member_no,int trade_freeboard_no) {
    		
    		HashMap<String, Object> map = new HashMap<String, Object>();
    		int count = tradeService.applyStatus(member_no, trade_freeboard_no);
    		TradeVO tradeVO = tradeService.selectContentByNo(trade_freeboard_no);
    		
    		int completePurchaseCount =tradeService.completePurchaseCount(trade_freeboard_no);
    		map.put("count", count);
    		map.put("tradeVO", tradeVO);
    		map.put("completePurchaseCount", completePurchaseCount);
    		return map;

    	}
    	//판매중으로 바뀌기
    	@RequestMapping("sellProcess.do")
    	public void sellProcess(int trade_list_no) {
    		
    		
    		tradeService.sellTrade(trade_list_no);
    	}
    	
    	//구매자 이름
    	@RequestMapping("evaluteBuyerInfo.do")
    	public HashMap<String, Object> evaluteBuyerInfo(int trade_list_no){
    		System.out.println("안녕");
    		HashMap<String, Object> map = new HashMap<String, Object>();
    		String buyer_nick=tradeService.selectSellerName(trade_list_no);
    	    map.put("buyer_nick", buyer_nick);
    	    System.out.println(buyer_nick);
    	    return map;
    	}
    	
    	//평가 정보
    	@RequestMapping("evaluateInfo.do")
    	public void evaluateInfo(HttpSession session, TradeEvaluateVO tradeEvaluateVO, int trade_list_no) {
    				System.out.println("실행");	
    		MemberVO seller_member = (MemberVO)session.getAttribute("sessionUser");
    		int seller_member_no= seller_member.getMember_no();
    		tradeEvaluateVO.setSeller_member_no(seller_member_no);
    		tradeService.evaluateInfo(tradeEvaluateVO, trade_list_no);
    		//여기서 정보가 SELECT UPDATE
    	}
    	
    	
    	@RequestMapping("getCountByDate.do")
    	public ArrayList<HashMap<String, Object>> getCountByDate(){
    		return tradeService.getCountByDate();
    	}
    	
    	@RequestMapping("getCountByGender.do")
    	public ArrayList<HashMap<String, Object>> getCountByGender(){
    		return tradeService.getCountByGender();
    	}
    	
    	
    	
}



















