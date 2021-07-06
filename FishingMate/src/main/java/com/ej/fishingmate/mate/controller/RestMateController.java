package com.ej.fishingmate.mate.controller;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ej.fishingmate.mate.service.MateServiceImpl;
import com.ej.fishingmate.member.service.MemberServiceImpl;
import com.ej.fishingmate.vo.MateCategoryVO;
import com.ej.fishingmate.vo.MateEvaluateVO;
import com.ej.fishingmate.vo.MateFreeboardCommentVO;
import com.ej.fishingmate.vo.MateFreeboardImageVO;
import com.ej.fishingmate.vo.MateGroupVO;
import com.ej.fishingmate.vo.MateWishVO;
import com.ej.fishingmate.vo.MemberVO;

@Controller
@RequestMapping("/mate/*")
@ResponseBody
public class RestMateController {

	@Autowired
	private MateServiceImpl mateService;
	
	@Autowired
	private MemberServiceImpl memberService;
	
	//------------------ 메이트 게시판 화면 카테고리 시작 - 형준 ----------------
	//메이트 카테고리 게시판 불러오기
	@RequestMapping("getMateCategoryList.do")
	public ArrayList<MateCategoryVO> getMateCategoryList(){
		
		return mateService.getAllMateCategory();
	}
	
	//메이트 게시판 글목록 불러오기(카테고리 포함)
	@RequestMapping("getAllMateContent.do")
	public HashMap<String, Object> getAllMateContent(@RequestParam(defaultValue = "0") int mate_category_no,
																@RequestParam(defaultValue = "0") int fishing_category_no,
																@RequestParam(defaultValue = "0") int region_category_no,
																@RequestParam(defaultValue = "1") int pageNum){
	//----------------------------------------------------------------------------------------------------------------------
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		
		ArrayList<HashMap<String, Object>> mateContentList = mateService.getMateAllContent(mate_category_no, fishing_category_no, region_category_no, pageNum);
		int contentCount = mateService.getMateAllContentCount(mate_category_no, fishing_category_no, region_category_no);
		
		int totalPageCount = (int)Math.ceil(contentCount/6.0);
		
		int currentPage = pageNum;
		
		int beginPage = ((currentPage-1)/5)*5 + 1;
		int endPage = ((currentPage-1)/5 + 1)*(5);
		
		if (endPage > totalPageCount) {
			endPage = totalPageCount;
		}
		
		map.put("beginPage", beginPage);
		map.put("endPage", endPage);
		map.put("currentPage", currentPage);
		map.put("totalPageCount", totalPageCount);
		map.put("mateContentList", mateContentList);
		map.put("contentCount", contentCount);
		
		return map;
	}
	
	//------------------ 메이트 게시판 화면 카테고리 끝 ----------------
	
	//------------------ 메이트 게시판&글쓰기 화면 카테고리 불러오기 시작 - 형준 ----------------
	@RequestMapping("getRegionCategoryList.do")
	public HashMap<String, Object> getRegionCategoryList(int select_fishing_value){
		
		HashMap<String, Object> regionCategoryList = mateService.getRegionCategory(select_fishing_value);
		
		return regionCategoryList;
	}
	
	
	//------------------ 메이트 게시판&글쓰기 화면 카테고리 불러오기 끝 ----------------
	
	//----------------------- 메이트 게시판 찜목록 관련 시작 - 형준 -----------------------
	//찜목록에 게시글 추가 - 형준
	@RequestMapping("doMateFreeboardToWishListProcess.do")
	public HashMap<String, Object> doMateFreeboardToWishListProcess(MateWishVO mateWishVO, HttpSession session) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		
		MemberVO memberVO = (MemberVO)session.getAttribute("sessionUser");
		
		mateWishVO.setMember_no(memberVO.getMember_no());
		int doWishListCount = mateService.doMateFreeboardInWishList(mateWishVO);
		
		map.put("doWishListCount", doWishListCount);
		
		return map;
	}
	
	//찜목록 추가 여부 확인 - 형준
	@RequestMapping("getWishListData.do")
	public HashMap<String, Object> getWishListData(int mate_freeboard_no, HttpSession session){
		HashMap<String, Object> map = new HashMap<String, Object>();
		
		MemberVO memberVO = (MemberVO)session.getAttribute("sessionUser");
		
		if (memberVO != null) {
			int chkInsertWishList = mateService.chkInsertIntoWishList(memberVO.getMember_no(), mate_freeboard_no);
			map.put("chkInsertWishList", chkInsertWishList);
		} else {
			map.put("chkInsertWishList", 0);
		}
		
		return map;
	}
	
	//찜목록 불러오기 - 형준
	@RequestMapping("getMateWishList.do")
	public HashMap<String, Object> getMateWishList(HttpSession session){
		HashMap<String, Object> map = new HashMap<String, Object>();
		
		MemberVO memberVO = (MemberVO)session.getAttribute("sessionUser");
		
		ArrayList<HashMap<String, Object>> mateWishList = mateService.getMateWishListByNo(memberVO.getMember_no());
		
		map.put("mateWishList", mateWishList);
		
		return map;
	}
	
	//찜목록 게시글 1개 읽기 - 형준
	@RequestMapping("getMateOneWishListContent.do")
	public HashMap<String, Object> getMateOneWishListContent(int mate_freeboard_no, HttpSession session){
		HashMap<String, Object> map = new HashMap<String, Object>();
		
		MemberVO memberVO = (MemberVO)session.getAttribute("sessionUser");
		
		HashMap<String, Object> oneMateContent = mateService.getOneMateContent(memberVO.getMember_no(), mate_freeboard_no, true);
		String member_nick = ((MemberVO)oneMateContent.get("memberVO")).getMember_nick();
		int recommedCount = mateService.getMateFreeboardRecommendCount(mate_freeboard_no);
		
		
		int chkApplyGroup = mateService.chkApplyMateGroup(memberVO.getMember_no(), mate_freeboard_no);
		
		int imgSize = ((ArrayList<MateFreeboardImageVO>) oneMateContent.get("mateFreeboardImageVOList")).size();
		
		oneMateContent.remove("memberVO");
		
		map.put("member_nick", member_nick);
		map.put("oneMateContent", oneMateContent);
		map.put("recommedCount", recommedCount);
		map.put("imgSize", imgSize);
		map.put("chkApplyGroup", chkApplyGroup);
		
		return map;
	}
	
	
	//----------------------- 메이트 게시판 찜목록 관련 끝 ------------------------------
	
	//-------------------------- 추천 시작 - 형준 -------------------------- 
	@RequestMapping("doRecommend.do")
	public void doRecommend(int mate_freeboard_no, HttpSession session) {
		
		MemberVO memberVO = (MemberVO)session.getAttribute("sessionUser");
		mateService.doRecommendCount(mate_freeboard_no, memberVO.getMember_no());
	}
	
	@RequestMapping("getRecommendData.do")
	public HashMap<String, Object> getRecommendData(int mate_freeboard_no, HttpSession session){
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		MemberVO memberVO = (MemberVO)session.getAttribute("sessionUser");
		
		map.put("result", "success");
		
		int recommedCount = mateService.getMateFreeboardRecommendCount(mate_freeboard_no);
		map.put("recommedCount", recommedCount);
		
		if (memberVO != null) {
			int chkDoRecommend = mateService.chkDoRecommend(memberVO.getMember_no(), mate_freeboard_no);
			map.put("chkDoRecommend", chkDoRecommend);
		} else {
			map.put("chkDoRecommend", 0);
		}
		
		return map;
	}
	//-------------------------- 추천 끝 --------------------------
	
	//-------------------------- 댓글 시작 - 형준 --------------------------
	
	//댓글 쓰기
	@RequestMapping("mateWriteCommentProcess.do")
	public void mateWriteCommentProcess(MateFreeboardCommentVO mateFreeboardCommentVO, HttpSession session) {
		
		MemberVO memberVO = (MemberVO)session.getAttribute("sessionUser");
		mateFreeboardCommentVO.setMember_no(memberVO.getMember_no());
		
		mateService.writeMateFreeboardComment(mateFreeboardCommentVO);
	}
	
	//댓글 삭제
	@RequestMapping("mateDeleteCommentProcess.do")
	public void mateDeleteCommentProcess(int mate_comment_no) {
		
		mateService.deleteMateCommentByNo(mate_comment_no);
	}
	
	//댓글 수정
	@RequestMapping("mateUpdateCommentProcess.do")
	public void mateUpdateCommentProcess(MateFreeboardCommentVO mateFreeboardCommentVO) {
		
		mateService.updateMateCommentByNo(mateFreeboardCommentVO);
	}
	
	//댓글 한개 불러오기
	@RequestMapping("getMateOneCommentData.do")
	public HashMap<String, Object> getMateOneCommentData(int mate_comment_no){
		
		return mateService.getOneMateFreeboardComment(mate_comment_no);
	}
	
	//댓글 불러오기
	@RequestMapping("getMateCommentData.do")
	public HashMap<String, Object> getMateCommentData(int mate_freeboard_no){
		HashMap<String, Object> map = new HashMap<String, Object>();
		
		int commentCount = mateService.getMateFreeboardCommentCount(mate_freeboard_no);
		ArrayList<HashMap<String, Object>> mateCommentList = mateService.getMateAllComentByNo(mate_freeboard_no);
		
		map.put("commentCount", commentCount);
		map.put("mateCommentList", mateCommentList);
		
		return map;
	}
	
	//-------------------------- 댓글 끝 --------------------------
	
	//-------------------------- 현재 신청인원 조회 - 형준 --------------------------
	@RequestMapping("getApplyGroupCount.do")
	public HashMap<String, Object> getApplyGroupCount(int mate_freeboard_no){
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		
		int applyGroupCount = mateService.getApplyGroupCount(mate_freeboard_no);
		map.put("applyGroupCount", applyGroupCount);
		
		return map;
	}
	
	//-------------------------- 현재 신청인원 조회 끝 - 형준 --------------------------
	//-------------------------- 메이트 게시판 그룹 신청하기 - 형준 ----------------------
	@RequestMapping("mateApplyGroupProcess.do")
	public void mateApplyGroupProcess(MateGroupVO mateGroupVO, HttpSession session) {
		
		MemberVO memberVO = (MemberVO)session.getAttribute("sessionUser");
		mateGroupVO.setMember_no(memberVO.getMember_no());
		
		mateService.applyMateGroup(mateGroupVO);
	}
	
	//-------------------------- 메이트 게시판 그룹 신청하기 끝 -------------------------
	
	//-------------------------- 신청 그룹 페이지 시작 - 형준 --------------------------
	//메이트 게시판 신청 그룹 목록 불러오기 - 형준
	@RequestMapping("getApplyGroupList.do")
	public HashMap<String, Object> getApplyGroupList(int mate_freeboard_no){
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		ArrayList<HashMap<String, Object>> applyGroupList = mateService.getMateApplyGroup(mate_freeboard_no);
		int confirmGroupCount = mateService.getConfirmGroupCount(mate_freeboard_no);
		int applyGroupCount = mateService.getApplyGroupCount(mate_freeboard_no);
		
		map.put("applyGroupList", applyGroupList);
		map.put("confirmGroupCount", confirmGroupCount);
		map.put("applyGroupCount", applyGroupCount);
		
		return map;
	}
	
	//메이트 게시판 그룹 신청 거절하기 - 형준
	@RequestMapping("denyMateApplyGroupProcess.do")
	public void denyMateApplyGroupProcess(int mate_freeboard_no, int member_no) {
		
		mateService.denyMateApplyGroup(member_no, mate_freeboard_no);
	}
	
	//메이트 게시판 확정 그룹에 회원 추가하기 - 형준
	@RequestMapping("insertMateConfirmGroupProcess.do")
	public void insertMateConfirmGroupProcess(int mate_freeboard_no, int member_no) {
		
		mateService.insertMateConfirmGroup(mate_freeboard_no, member_no);
	}
	
	//메이트 게시판 확정 그룹에 회원 제거하기 - 형준
	@RequestMapping("deleteMateConfirmGroupProcess.do")
	public void deleteMateConfirmGroupProcess(int mate_freeboard_no, int member_no, int mate_confirm_no) {
		
		mateService.deleteMateConfirmGroup(mate_freeboard_no, mate_confirm_no, member_no);
	}
	
	
	
	//-------------------------- 신청 그룹 페이지 끝 --------------------------
	
	//-------------------------- 확정 그룹 페이지 시작 - 형준 --------------------------
	//평가할 회원정보 가져오기
	@RequestMapping("getEvaluateToMemberNick.do")
	public HashMap<String, Object> getEvaluateToMemberNick(int member_no){
		HashMap<String, Object> map = new HashMap<String, Object>();
		
		MemberVO memberVO = memberService.selectMemberByMno(member_no);
		
		map.put("member_nick", memberVO.getMember_nick());
		
		return map;
	}
	
	
	
	//회원 간 평가하기
	@RequestMapping("evaluteMemberProcess.do")
	public void evaluteMemberProcess(MateEvaluateVO mateEvaluateVO, int evaluate_type, HttpSession session) {
		
		MemberVO memberVO = (MemberVO)session.getAttribute("sessionUser");
		mateEvaluateVO.setFrom_member_no(memberVO.getMember_no());
		
		mateService.evaluateMateMember(mateEvaluateVO, evaluate_type);
	}
	
	
	//-------------------------- 확정 그룹 페이지 끝 --------------------------
	
	
}















