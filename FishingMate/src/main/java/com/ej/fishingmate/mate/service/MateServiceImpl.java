package com.ej.fishingmate.mate.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.commons.text.StringEscapeUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ej.fishingmate.commoncategory.mapper.CommonCategorySQLMapper;
import com.ej.fishingmate.mate.mapper.MateImageSQLMapper;
import com.ej.fishingmate.mate.mapper.MateSQLMapper;
import com.ej.fishingmate.member.mapper.MemberSQLMapper;
import com.ej.fishingmate.vo.FishingCategoryVO;
import com.ej.fishingmate.vo.FreshWaterRegionCategoryVO;
import com.ej.fishingmate.vo.MateCategoryVO;
import com.ej.fishingmate.vo.MateConfirmVO;
import com.ej.fishingmate.vo.MateEvaluateVO;
import com.ej.fishingmate.vo.MateFreeboardCommentVO;
import com.ej.fishingmate.vo.MateFreeboardImageVO;
import com.ej.fishingmate.vo.MateFreeboardVO;
import com.ej.fishingmate.vo.MateGroupVO;
import com.ej.fishingmate.vo.MateWishVO;
import com.ej.fishingmate.vo.MemberVO;
import com.ej.fishingmate.vo.RegionCategoryVO;
import com.ej.fishingmate.vo.SeaRegionCategoryVO;

@Service
public class MateServiceImpl {

	@Autowired
	private CommonCategorySQLMapper commonCategorySQLMapper;
	
	@Autowired
	private MateSQLMapper mateSQLMapper;
	
	@Autowired 
	MemberSQLMapper memberSQLMapper;
	
	@Autowired
	MateImageSQLMapper mateImageSQLMapper;
	
	//낚시 종류&지역 카테고리 불러오기 - 형준
	public HashMap<String, Object> getCommonCategory(){

		HashMap<String, Object> commonCategoryList = new HashMap<String, Object>();
		ArrayList<FishingCategoryVO> fishingCategoryList = commonCategorySQLMapper.selectFishingCategory();
		ArrayList<RegionCategoryVO> regionCategoryList = commonCategorySQLMapper.selectRegionCategory();
		
		commonCategoryList.put("fishingCategoryList", fishingCategoryList);
		commonCategoryList.put("regionCategoryList", regionCategoryList);
		
		return commonCategoryList;
	}
	
	//낚시 종류 카테고리 불러오기 - 형준
	public ArrayList<FishingCategoryVO> getFishingCategory(){
		
		return commonCategorySQLMapper.selectFishingCategory();
	}
	
	//낚시 종류에 따른 지역 카테고리 불러오기 (민물&바다) - 형준
	public HashMap<String, Object> getRegionCategory(int fishing_category_no){
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		if (fishing_category_no == 1) {
			//민물일때
			ArrayList<FreshWaterRegionCategoryVO> regionListVO = commonCategorySQLMapper.selectFreshWaterRegionCategory();
			map.put("regionListVO", regionListVO);
		} else {
			//바다일때
			ArrayList<SeaRegionCategoryVO> regionListVO = commonCategorySQLMapper.selectSeaRegionCategory();
			map.put("regionListVO", regionListVO);
		}
		return map;
	}
	
	//메이트 게시판 글쓰기 - 형준
	public void writeMateFreeboardContent(MateFreeboardVO mateFreeboardVO, ArrayList<MateFreeboardImageVO> mateFreeboardImageVOList) {
		
		int mate_freeboard_no = mateSQLMapper.createMateFreeboardSequence();
		
		//게시글 쓰기
		mateFreeboardVO.setMate_freeboard_no(mate_freeboard_no);
		mateSQLMapper.insertMateFreeboardContent(mateFreeboardVO);
		
		//게시글 이미지 삽입
		for(MateFreeboardImageVO mateFreeboardImageVO : mateFreeboardImageVOList) {
			mateFreeboardImageVO.setMate_freeboard_no(mate_freeboard_no);
			mateImageSQLMapper.insertMateFreeboardImage(mateFreeboardImageVO);
		}
		
		//게시글 추가 시 작성자는 확정 그룹에 바로 추가
		mateSQLMapper.insertMateConfirmGroup(mate_freeboard_no, mateFreeboardVO.getMember_no());
	}
	
	//메이트 카테고리 불러오기 - 형준
	public ArrayList<MateCategoryVO> getAllMateCategory(){
		
		return mateSQLMapper.selectAllMateCategory();
	}
	
	//메이트 게시판 글목록 불러오기 - 형준
	public ArrayList<HashMap<String, Object>> getMateAllContent(int mate_category_no, int fishing_category_no, int region_category_no, int pageNum){
		
		ArrayList<HashMap<String, Object>> mateAllContentList = new ArrayList<HashMap<String,Object>>();
		ArrayList<MateFreeboardVO> mateAllList = mateSQLMapper.selectMateAllContent(mate_category_no, fishing_category_no, region_category_no, pageNum);
		
		for(MateFreeboardVO mateFreeboardVO : mateAllList) {
			HashMap<String, Object> map = new HashMap<String, Object>();
			MemberVO memberVO = memberSQLMapper.selectMemberByMno(mateFreeboardVO.getMember_no());
			int mate_freeboard_no = mateFreeboardVO.getMate_freeboard_no();
			
			RegionCategoryVO regionCategoryVO = commonCategorySQLMapper.selectOneRegion(mateFreeboardVO.getRegion_category_no());
			FishingCategoryVO fishingCategoryVO = commonCategorySQLMapper.selectOneFishing(mateFreeboardVO.getFishing_category_no());
			MateCategoryVO mateCategoryVO = mateSQLMapper.selectOneMateCategory(mateFreeboardVO.getMate_category_no());
			int commentCount = mateSQLMapper.selectMateCommentCountByNo(mate_freeboard_no);
			MateFreeboardImageVO mateFreeboardImageVO = mateImageSQLMapper.selectMateFreeboardOneImage(mate_freeboard_no);
			if(mateFreeboardImageVO != null) {
				map.put("mateFreeboardImageVO", mateFreeboardImageVO);
			}
			int applyGroupCount = mateSQLMapper.selectMateApplyGroupCount(mate_freeboard_no);
			int confirmGroupCount = mateSQLMapper.selectMateConfrimGroupCount(mate_freeboard_no);
			
			map.put("mateFreeboardVO", mateFreeboardVO);
			map.put("member_nick", memberVO.getMember_nick());
			map.put("regionCategoryVO", regionCategoryVO);
			map.put("fishingCategoryVO", fishingCategoryVO);
			map.put("mateCategoryVO", mateCategoryVO);
			map.put("commentCount", commentCount);
			map.put("applyGroupCount", applyGroupCount);
			map.put("confirmGroupCount", confirmGroupCount);
			
			mateAllContentList.add(map);
		}
		
		return mateAllContentList;
	}
	
	//메이트 게시판 글개수 불러오기 - 형준
	public int getMateAllContentCount(int mate_category_no, int fishing_category_no, int region_category_no) {
		
		return mateSQLMapper.selectMateAllContentCount(mate_category_no, fishing_category_no, region_category_no);
	}
	
	//메이트 게시판 글읽기 - 형준
	public HashMap<String, Object> getOneMateContent(int sessionMemberNo, int mate_freeboard_no, boolean isEscapeHtml){
		HashMap<String, Object> oneContent = new HashMap<String, Object>();
		MateFreeboardVO mateFreeboardVO = mateSQLMapper.selectOneMateContent(mate_freeboard_no);
		int member_no = mateFreeboardVO.getMember_no();
		
		if(isEscapeHtml) {
			String content = mateFreeboardVO.getMate_freeboard_content();
			
			content = StringEscapeUtils.escapeHtml4(content);
			content = content.replaceAll("\n", "<br>");
			
			mateFreeboardVO.setMate_freeboard_content(content);
		}
		
		MemberVO memberVO = memberSQLMapper.selectMemberByMno(member_no);
		RegionCategoryVO regionCategoryVO = commonCategorySQLMapper.selectOneRegion(mateFreeboardVO.getRegion_category_no());
		FishingCategoryVO fishingCategoryVO = commonCategorySQLMapper.selectOneFishing(mateFreeboardVO.getFishing_category_no());
		MateCategoryVO mateCategoryVO = mateSQLMapper.selectOneMateCategory(mateFreeboardVO.getMate_category_no());
		//int commentCount = mateSQLMapper.selectMateCommentCountByNo(mate_freeboard_no);
		ArrayList<MateFreeboardImageVO> mateFreeboardImageVOList = mateImageSQLMapper.selectMateFreeboardImage(mate_freeboard_no);
		int applyGroupCount = mateSQLMapper.selectMateApplyGroupCount(mate_freeboard_no);
		int confirmGroupCount = mateSQLMapper.selectMateConfrimGroupCount(mate_freeboard_no);
		
		//확정 그룹에 포함된 회원인지 체크
		if (mateSQLMapper.chkMemberIntoMateConfirmGroup(sessionMemberNo, mate_freeboard_no) != null) {
			int mate_confirm_no = mateSQLMapper.chkMemberIntoMateConfirmGroup(sessionMemberNo, mate_freeboard_no);
			oneContent.put("mate_confirm_no", mate_confirm_no);
		}
		
		oneContent.put("mateFreeboardVO", mateFreeboardVO);
		oneContent.put("memberVO", memberVO);
		oneContent.put("regionCategoryVO", regionCategoryVO);
		oneContent.put("fishingCategoryVO", fishingCategoryVO);
		oneContent.put("mateCategoryVO", mateCategoryVO);
		oneContent.put("mateFreeboardImageVOList", mateFreeboardImageVOList);
		oneContent.put("applyGroupCount", applyGroupCount);
		oneContent.put("confirmGroupCount", confirmGroupCount);
		
		return oneContent;
	}
	
	//메이트 게시판 조회수 늘리기 - 형준
	public void increaseMateReadCount(int mate_freeboard_no) {
		
		mateSQLMapper.increaseContentReadCount(mate_freeboard_no);
	}
	
	//메이트 게시판 글 삭제 - 형준
	public void deleteMateContentByNo(int mate_freeboard_no) {
		mateSQLMapper.deleteMateContentByNo(mate_freeboard_no);
		mateImageSQLMapper.deleteMateFreeboardImage(mate_freeboard_no);
	}
	
	//메이트 게시판 글 수정 - 형준
	public void updateMateContent(MateFreeboardVO mateFreeboardVO) {
		mateSQLMapper.updateMateContentByNo(mateFreeboardVO);
	}
	
	//메이트 게시판 댓글 쓰기 - 형준
	public void writeMateFreeboardComment(MateFreeboardCommentVO mateFreeboardCommentVO) {
		
		mateSQLMapper.insertMateFreeboardComment(mateFreeboardCommentVO);
	}
	
	//메이트 게시판 댓글 삭제 - 형준
	public void deleteMateCommentByNo(int mate_comment_no) {
		
		mateSQLMapper.deleteMateCommentByNo(mate_comment_no);
	}
	
	//메이트 게시판 댓글 수정 - 형준
	public void updateMateCommentByNo(MateFreeboardCommentVO mateFreeboardCommentVO) {
		
		mateSQLMapper.updateMateCommentByNo(mateFreeboardCommentVO);
	}
	
	//메이트 게시판 댓글 1개 불러오기 - 형준
	public HashMap<String, Object> getOneMateFreeboardComment(int mate_comment_no) {
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		MateFreeboardCommentVO mateFreeboardCommentVO = mateSQLMapper.selectMateOneCommentByNo(mate_comment_no);
		MemberVO memberVO = memberSQLMapper.memberSelectByNo(mateFreeboardCommentVO.getMember_no());
		
		map.put("mateFreeboardCommentVO", mateFreeboardCommentVO);
		map.put("member_nick", memberVO.getMember_nick());
		
		return map;
	}
	
	//메이트 게시판 댓글개수 불러오기 - 형준
	public int getMateFreeboardCommentCount(int mate_freeboard_no) {
		
		return mateSQLMapper.selectMateCommentCountByNo(mate_freeboard_no);
	}
	
	//메이트 게시판 댓글 불러오기 - 형준
	public ArrayList<HashMap<String, Object>> getMateAllComentByNo(int mate_freeboard_no){
		
		ArrayList<HashMap<String, Object>> commentList = new ArrayList<HashMap<String,Object>>();
		ArrayList<MateFreeboardCommentVO> list = mateSQLMapper.selectMateAllCommentByNo(mate_freeboard_no);
		
		for(MateFreeboardCommentVO mateFreeboardCommentVO : list) {
			HashMap<String, Object> map = new HashMap<String, Object>();
			MemberVO memberVO = memberSQLMapper.selectMemberByMno(mateFreeboardCommentVO.getMember_no());
			
			map.put("mateFreeboardCommentVO", mateFreeboardCommentVO);
			map.put("member_nick", memberVO.getMember_nick());
			
			commentList.add(map);
		}
		
		
		return commentList;
	}
	
	//메이트 게시판 추천 수 올리기&내리기
	public void doRecommendCount(int mate_freeboard_no, int member_no) {
		int chkDoRecommend = mateSQLMapper.chkDoRecommend(member_no, mate_freeboard_no);
		if (chkDoRecommend > 0) {
			mateSQLMapper.decreaseRecommendCount(mate_freeboard_no, member_no);
		} else {
			mateSQLMapper.increaseRecommendCount(mate_freeboard_no, member_no);
		}
	}
	
//	//메이트 게시판 추천 수 올리기 - 형준
//	public void increaseRecommendCount(int mate_freeboard_no, int member_no) {
//		
//		mateSQLMapper.increaseRecommendCount(mate_freeboard_no, member_no);
//	}
//	
//	//메이트 게시판 추천 수 내리기 - 형준
//	public void decreaseRecommendCount(int mate_freeboard_no, int member_no) {
//		
//		mateSQLMapper.decreaseRecommendCount(mate_freeboard_no, member_no);
//	}
	
	//메이트 게시판 추천 여부 확인 - 형준
	public int chkDoRecommend(int member_no, int mate_freeboard_no) {
		
		return mateSQLMapper.chkDoRecommend(member_no, mate_freeboard_no);
	}
	
	//메이트 게시판 추천 수 불러오기 - 형준
	public int getMateFreeboardRecommendCount(int mate_freeboard_no) {
		
		return mateSQLMapper.selectMateFreeboardRecommendCount(mate_freeboard_no);
	}
	
	//메이트 게시판 그룹 신청하기 - 형준
	public void applyMateGroup(MateGroupVO mateGroupVO) {
		
		mateSQLMapper.insertMateGroup(mateGroupVO);
	}
	
	//메이트 게시판 신청 여부 확인 - 형준
	public int chkApplyMateGroup(int member_no, int mate_freeboard_no) {
		
		return mateSQLMapper.chkDoApplyGroup(member_no, mate_freeboard_no);
	}
	
	//메이트 게시판 그룹 신청 현황 불러오기 - 형준
	public ArrayList<HashMap<String, Object>> getMateApplyGroup(int mate_freeboard_no){
		
		ArrayList<HashMap<String, Object>> applyGroupList = new ArrayList<HashMap<String,Object>>();
		ArrayList<MateGroupVO> list = mateSQLMapper.selectMateApplyGroup(mate_freeboard_no);
		
		for(MateGroupVO mateGroupVO : list) {
			HashMap<String, Object> map = new HashMap<String, Object>();
			int member_no = mateGroupVO.getMember_no();
			String member_gender = null;
			
			MemberVO memberVO = memberSQLMapper.selectMemberByMno(member_no);
			int member_age = memberSQLMapper.selectMemberAge(member_no);
			int mate_confirm_no = 0;
			
			//회원 성별 확인
			if (memberVO.getMember_gender().equals("F")) {
				member_gender = "여자";
			} else if (memberVO.getMember_gender().equals("M")) {
				member_gender = "남자";
			} else {
				member_gender = "그외";
			}
			
			//확정 그룹에 회원이 있을 경우 확정 그룹 번호 넘겨주기
			if (mateSQLMapper.chkMemberIntoMateConfirmGroup(member_no, mate_freeboard_no) != null) {
				mate_confirm_no = mateSQLMapper.chkMemberIntoMateConfirmGroup(member_no, mate_freeboard_no);
			}
			
			map.put("mateGroupVO", mateGroupVO);
			map.put("member_nick", memberVO.getMember_nick());
			map.put("member_age", member_age);
			map.put("member_gender", member_gender);
			map.put("mate_confirm_no", mate_confirm_no);
			
			applyGroupList.add(map);
		}
		
		return applyGroupList;
	}
	
	//메이트 게시판 그룹 신청 현황 인원 수 불러오기 - 형준
	public int getApplyGroupCount(int mate_freeboard_no) {
		
		return mateSQLMapper.selectMateApplyGroupCount(mate_freeboard_no);
	}
	
	//메이트 게시판 그룹 신청 거절하기 - 형준
	public void denyMateApplyGroup(int member_no, int mate_freeboard_no) {
		
		mateSQLMapper.denyMateApplyGroup(member_no, mate_freeboard_no);
		mateSQLMapper.updateApplyGroupDeny(member_no, mate_freeboard_no);
	}
	
	//메이트 게시판 확정 그룹 인원 수 불러오기 - 형준
		public int getConfirmGroupCount(int mate_freeboard_no) {
			
			return mateSQLMapper.selectMateConfrimGroupCount(mate_freeboard_no);
		}
	
	//메이트 게시판 확정 그룹에 회원 추가 - 형준
	public void insertMateConfirmGroup(int mate_freeboard_no, int member_no) {
		
		mateSQLMapper.insertMateConfirmGroup(mate_freeboard_no, member_no);
		mateSQLMapper.updateApplyGroupApprove(member_no, mate_freeboard_no);
	}
	
	//메이트 게시판 확정 그룹에 회원 제거 - 형준
	public void deleteMateConfirmGroup(int mate_freeboard_no, int mate_confirm_no, int member_no) {
		
		mateSQLMapper.deleteMateConfirmGroup(mate_confirm_no);
		mateSQLMapper.updateApplyGroupDeny(member_no, mate_freeboard_no);
	}
	
	//메이트 게시판 모집 취소 시 모집 상태 변경 - 형준
	public void updateMateFreeboardStatusToCanel(int mate_freeboard_no) {
		
		mateSQLMapper.updateMateFreeboardStatusToCancel(mate_freeboard_no);
	}
	
	//------------------- 메이트 게시판 모집 완료 시 ---------------------------
	//메이트 게시판 모집상태 변경 - 형준
	public void updateMateFreeboardStatusToComplete(int mate_freeboard_no) {
		
		mateSQLMapper.updateMateFreeboardStatusToComplete(mate_freeboard_no);
	}
	
	//메이트 게시판 확정 그룹 목록 불러오기 - 형준
	public ArrayList<HashMap<String, Object>> getAllMateConfirmGroup(int mate_freeboard_no, int from_member_no){
		
		ArrayList<HashMap<String, Object>> mateConfirmGroupList = new ArrayList<HashMap<String,Object>>();
		ArrayList<MateConfirmVO> list = mateSQLMapper.selectAllMateConfirmGroup(mate_freeboard_no);
		
		for(MateConfirmVO mateConfirmVO : list) {
			HashMap<String, Object> map = new HashMap<String, Object>();
			int member_no = mateConfirmVO.getMember_no();
			String member_gender = null;
			
			MemberVO memberVO = memberSQLMapper.selectMemberByMno(member_no);
			int member_age = memberSQLMapper.selectMemberAge(member_no);
			int chkEvaluateToMember = mateSQLMapper.chkEvaluateToMember(member_no, from_member_no, mateConfirmVO.getMate_confirm_no());
			
			//회원 성별 확인
			if (memberVO.getMember_gender().equals("F")) {
				member_gender = "여자";
			} else if (memberVO.getMember_gender().equals("M")) {
				member_gender = "남자";
			} else {
				member_gender = "그외";
			}
		
			map.put("mateConfirmVO", mateConfirmVO);
			map.put("memberVO", memberVO);
			map.put("member_gender", member_gender);
			map.put("member_age", member_age);
			map.put("chkEvaluateToMember", chkEvaluateToMember);
			
			mateConfirmGroupList.add(map);
		}
		
		return mateConfirmGroupList;
	}
	
	//메이트 게시판 회원 간 평가하기 - 형준
	public void evaluateMateMember(MateEvaluateVO mateEvaluateVO, int evaluate_type) {
		
		double evaluateValue = 0; 
		if(evaluate_type == 0) {
			//평가 좋아요
			mateSQLMapper.evaluateGoodMateMember(mateEvaluateVO);
			evaluateValue = 0.3;
		} else {
			//평가 나빠요
			mateSQLMapper.evaluateBadMateMember(mateEvaluateVO);
			evaluateValue = -0.3;
		}
		mateEvaluateVO.setEvaluate_value(evaluateValue);
		
		mateSQLMapper.updateEvaluateValueFromMateEvaluate(mateEvaluateVO);
	}
	
	
	//------------------- 메이트 게시판 모집 완료 시 끝 -------------------------
	
	//--------------------------------- 메이트 게시판 찜목록 관련 시작 - 형준 -------------------------------
	//메이트 게시판 찜목록에 넣기 - 형준
	public int doMateFreeboardInWishList(MateWishVO mateWishVO) {
		
		int chkInsertIntoWishList = mateSQLMapper.chkInsertIntoWishList(mateWishVO.getMember_no(), mateWishVO.getMate_freeboard_no());
		if (chkInsertIntoWishList > 0) {
			mateSQLMapper.deleteMateFreeboardInWishList(mateWishVO);
			return 0;
		} else {
			mateSQLMapper.insertMateFreeboardInWishList(mateWishVO);
			return 1;
		}
	}
	
	//메이트 게시판 찜목록 추가 여부 확인 - 형준
	public int chkInsertIntoWishList(int member_no, int mate_freeboard_no) {
		
		return mateSQLMapper.chkInsertIntoWishList(member_no, mate_freeboard_no);
	}
	
	//메이트 게시판 찜목록 불러오기 - 형준
	public ArrayList<HashMap<String, Object>> getMateWishListByNo(int member_no){
		
		ArrayList<HashMap<String, Object>> mateWishList = new ArrayList<HashMap<String, Object>>();
		ArrayList<MateWishVO> list = mateSQLMapper.selectMateWishListByNo(member_no);
		
		for(MateWishVO mateWishVO : list) {
			HashMap<String, Object> map = new HashMap<String, Object>();
			
			MateFreeboardVO mateFreeboardVO = mateSQLMapper.selectOneMateContent(mateWishVO.getMate_freeboard_no());
			int mate_freeboard_no = mateFreeboardVO.getMate_freeboard_no();
			
			MemberVO memberVO = memberSQLMapper.memberSelectByNo(mateFreeboardVO.getMember_no());
			FishingCategoryVO fishingCategoryVO = commonCategorySQLMapper.selectOneFishing(mateFreeboardVO.getFishing_category_no());
			RegionCategoryVO regionCategoryVO = commonCategorySQLMapper.selectOneRegion(mateFreeboardVO.getRegion_category_no());
			MateCategoryVO mateCategoryVO = mateSQLMapper.selectOneMateCategory(mateFreeboardVO.getMate_category_no());
			int commentCount = mateSQLMapper.selectMateCommentCountByNo(mate_freeboard_no);
			
			map.put("mateFreeboardVO", mateFreeboardVO);
			map.put("member_nick", memberVO.getMember_nick());
			map.put("fishingCategoryVO", fishingCategoryVO);
			map.put("regionCategoryVO", regionCategoryVO);
			map.put("mateCategoryVO", mateCategoryVO);
			map.put("commentCount", commentCount);
			
			mateWishList.add(map);
		}
		
		return mateWishList;
	}
	
	
	//------------------------------------ 메이트 게시판 찜목록 관련 끝 -----------------------------------
	
	
	
}








