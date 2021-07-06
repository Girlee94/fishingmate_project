package com.ej.fishingmate.infofreeboard.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.ej.fishingmate.infofreeboard.mapper.InfoFreeboardImageSQLMapper;
import com.ej.fishingmate.infofreeboard.mapper.InfoFreeboardSQLMapper;
import com.ej.fishingmate.member.mapper.MemberSQLMapper;
import com.ej.fishingmate.vo.InfoCategoryListVO;
import com.ej.fishingmate.vo.InfoCategoryVO;
import com.ej.fishingmate.vo.InfoFreeboardCommentVO;
import com.ej.fishingmate.vo.InfoFreeboardImageVO;
import com.ej.fishingmate.vo.InfoFreeboardRecommendVO;
import com.ej.fishingmate.vo.InfoFreeboardVO;
import com.ej.fishingmate.vo.LottoServerVO;
import com.ej.fishingmate.vo.LottoUserVO;
import com.ej.fishingmate.vo.MemberVO;

@Service
public class InfoFreeboardServiceImpl {

	@Autowired
	private InfoFreeboardSQLMapper infofreeboardSQLMapper;
	@Autowired
	private MemberSQLMapper memberSQLMapper;
	@Autowired
	private  InfoFreeboardImageSQLMapper infoFreeboardImageSQLMapper;
	
	
	
	//-----------------------게시글 작성
	public void writeinfoContent(InfoFreeboardVO infoFreeboardVO, ArrayList<InfoFreeboardImageVO> infofreeboardImageVOList, int info_category_no) {
		
		int info_freeboard_no = infofreeboardSQLMapper.createinfoFreeboardKey();
				
	   infoFreeboardVO.setInfo_freeboard_no(info_freeboard_no);
		
		infofreeboardSQLMapper.insertInfoFreeboardContent(infoFreeboardVO);
		
		InfoCategoryListVO infoCategoryListVO = new InfoCategoryListVO();
		
		infoCategoryListVO.setInfo_category_no(info_category_no);
		infoCategoryListVO.setInfo_freeboard_no(info_freeboard_no);
		
		infofreeboardSQLMapper.insertInfoCategoryList(infoCategoryListVO);
		
		for(InfoFreeboardImageVO infoFreeboardImageVO : infofreeboardImageVOList) {
			infoFreeboardImageVO.setInfo_freboard_no(info_freeboard_no);
			infoFreeboardImageSQLMapper.insert(infoFreeboardImageVO);
		
		
		}
		
	}

	//-----------------------게시글 불러오기
	public ArrayList<HashMap<String, Object>> getinfoFreeboardList(int info_category_no) {
		
	ArrayList<HashMap<String, Object>> result =new ArrayList<HashMap<String,Object>>();
		
	ArrayList<Integer> infofreeboardNoList= infofreeboardSQLMapper.selectAll(info_category_no);
	
	System.out.println("info_category_no"+info_category_no);
	for(int infoFreeboardNo : infofreeboardNoList) {
		
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		
		
		InfoFreeboardVO infoFreeboardVO = infofreeboardSQLMapper.selectinfoContentByNo(infoFreeboardNo);
		
		MemberVO memberVO = memberSQLMapper.memberSelectByNo(infoFreeboardVO.getMember_no());
	 	int recommendCount = infofreeboardSQLMapper.selectRecommendCountByinfoFreeboardNo(infoFreeboardVO.getInfo_freeboard_no());
		int commentCount = infofreeboardSQLMapper.selectCommentCountByNo(infoFreeboardVO.getInfo_freeboard_no());
		
		 
		
	map.put("memberVO", memberVO);
	map.put("infoFreeboardVO", infoFreeboardVO);
	map.put("recommendCount", recommendCount);
	map.put("commentCount", commentCount);
	
	result.add(map);
	}
	
		return result;
	}
	
	//게시글 총 개수
	public int InfoFreeboardTotalNo() {
		return infofreeboardSQLMapper.InfoFreeboardTotalNo();
	}
	//------------------------------------졸렬하게 게시글 전체 가져오기
	
	public ArrayList<HashMap<String, Object>> getinfoallFreeboardList() {
		
	ArrayList<HashMap<String, Object>> result =new ArrayList<HashMap<String,Object>>();
		
	ArrayList<Integer> infofreeboardNoList= infofreeboardSQLMapper.selectAllList();
		
	for(int infoFreeboardNo : infofreeboardNoList) {
		
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		
		
		InfoFreeboardVO infoFreeboardVO = infofreeboardSQLMapper.selectinfoContentByNo(infoFreeboardNo);
		MemberVO memberVO = memberSQLMapper.memberSelectByNo(infoFreeboardVO.getMember_no());
	 	int recommendCount = infofreeboardSQLMapper.selectRecommendCountByinfoFreeboardNo(infoFreeboardVO.getInfo_freeboard_no());
		int commentCount = infofreeboardSQLMapper.selectCommentCountByNo(infoFreeboardVO.getInfo_freeboard_no());
		ArrayList<InfoFreeboardImageVO> imageFreeboardImageVO = infoFreeboardImageSQLMapper.selectByinfoFreeboardNo(infoFreeboardNo);
		
		int category_no = infoFreeboardVO.getInfo_category_no();
		String selectCategoryName = infofreeboardSQLMapper.selectCategoryName(category_no);
		
	map.put("infoimageVO",imageFreeboardImageVO);
	map.put("memberVO", memberVO);
	map.put("infoFreeboardVO", infoFreeboardVO);
	map.put("recommendCount", recommendCount);
	map.put("commentCount", commentCount);
	map.put("selectCategoryName", selectCategoryName);
	
	result.add(map);
	}
	
		return result;
	}

	//---------------------게시글 1개 가져오기
	public HashMap<String, Object> getinfocontent(int info_freeboard_no) {
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		
		InfoFreeboardVO infoFreeboardVO = infofreeboardSQLMapper.selectinfoContentByNo(info_freeboard_no);
		int member_no =infoFreeboardVO.getMember_no();
		
		ArrayList<InfoFreeboardImageVO> infofreeboardImageVOList=
				infoFreeboardImageSQLMapper.selectByinfoFreeboardNo(info_freeboard_no);
		
		
		MemberVO memberVO = memberSQLMapper.memberSelectByNo(member_no);
		//System.out.println(infofreeboardImageVOList);
		map.put("infofreeboardImageVOList", infofreeboardImageVOList);
		map.put("infoFreeboardVO", infoFreeboardVO);
		map.put("memberVO", memberVO);
		
		return map;
	}


	
	//------------------------게시글 수정
	public void updateinfoContent(InfoFreeboardVO infoFreeboardVO,ArrayList<InfoFreeboardImageVO> infofreeboardImageVOList) {
	
		infofreeboardSQLMapper.updateinfoContent(infoFreeboardVO);
	//---------게시글 이미지 추가하기
			
		for(InfoFreeboardImageVO infoFreeboardImageVO : infofreeboardImageVOList) {
			infoFreeboardImageVO.setInfo_freboard_no(infoFreeboardVO.getInfo_freeboard_no());
			infoFreeboardImageSQLMapper.updateContentImage(infoFreeboardImageVO);
		}
		
	}
	
	//------------------------게시글 삭제
	public void deleteinfoContent(int info_freeboard_no) {
		infofreeboardSQLMapper.deleteinfoContent(info_freeboard_no);
		
	}
	//------------------------댓글 작성

	public void writeinfoComment(InfoFreeboardCommentVO infoFreeboardCommentVO) {
		
		infofreeboardSQLMapper.insertinfoComment(infoFreeboardCommentVO);
		
		
	}
	//-----------------------댓글 불러오기

	public ArrayList<HashMap<String, Object>> getinfoCommentBynO(int info_freeboard_no) {

		ArrayList<HashMap<String , Object>> result = new ArrayList<HashMap<String,Object>>();
		ArrayList<InfoFreeboardCommentVO> infocommentList = infofreeboardSQLMapper.selectinfoAllCommentContentByNo(info_freeboard_no);
		//System.out.println("111");
		//System.out.println(infocommentList);
		for(InfoFreeboardCommentVO list : infocommentList) {
			HashMap<String, Object> map = new HashMap<String, Object>();
		
			MemberVO memberVO = memberSQLMapper.memberSelectByNo(list.getMember_no());
			map.put("infoFreeboardCommentVO", list );
			map.put("memberVO", memberVO);
			result.add(map);
		}
		return result;
	}

	//--------------------------------댓글 수정
	public void modifyinfoCommentByMnoAndCno(InfoFreeboardCommentVO infoFreeboardCommentVO) {
	
		infofreeboardSQLMapper.updateinfoCommentByMnoAndCno(infoFreeboardCommentVO);
	}

	//----------------------------------댓글셀렉
	public InfoFreeboardCommentVO getinfoContentCommentBynO(int member_no, int info_comment_no) {
		return infofreeboardSQLMapper.selectCommentByMnoAndCno(member_no, info_comment_no);
	}
	//---------------------------------------------댓글삭제

	
	
	public void deleteinfoCommentByMno(InfoFreeboardCommentVO infoFreeboardCommentVO) {
		infofreeboardSQLMapper.deleteinfoComment(infoFreeboardCommentVO);
	}

	

	
	//-------------------------------------------정보 게시글 추천


		
	public void recommend(int info_freeboard_no, int member_no) {
		int count =infofreeboardSQLMapper.selectRecommendCountByFreeboardNoAndMemberNo(info_freeboard_no,member_no);
		System.out.println(count);
		if(count > 0 ) {
			infofreeboardSQLMapper.deleteRecommend(info_freeboard_no,member_no);
		}else {
			infofreeboardSQLMapper.insertRecommend(info_freeboard_no,member_no);
		}
		
	}

	public int getMyRecommendCount(int info_freeboard_no ,int member_no) {
		int count = infofreeboardSQLMapper.selectRecommendCountByFreeboardNoAndMemberNo(info_freeboard_no,member_no);
		return count;
	}

	public int getRecommendCount(int info_freeboard_no) {
		int count =infofreeboardSQLMapper.selectRecommendCountByinfoFreeboardNo(info_freeboard_no);
		
		return count;
	}

	public int getCommentCountByNo(int info_freeboard_no) {
		// TODO Auto-generated method stub
		return infofreeboardSQLMapper.selectCommentCountByNo(info_freeboard_no);
	}

	//카테고리
	public ArrayList<InfoCategoryVO> getinfoCategoryList() {
		
		ArrayList<InfoCategoryVO> list = infofreeboardSQLMapper.selectCategoryList();
		
		return list;
	}

	
	public int updateinforeadcount(int info_freeboard_no) {
		
		
		return infofreeboardSQLMapper.updateinforeadcount(info_freeboard_no);
	}

	public ArrayList<InfoFreeboardImageVO> getimagebyfno(int info_freeboard_no) {
			
		
		return infoFreeboardImageSQLMapper.selectByinfoFreeboardNo(info_freeboard_no);
	}

	public void deleteContentImage(int image_no) {
		
		infoFreeboardImageSQLMapper.deleteContentImage(image_no);
	}

	public void deleteinfoCommentByFno(int info_comment_no) {

		infofreeboardSQLMapper.deleteinfoCommentByFno(info_comment_no);
	}

	public HashMap<String, Object> getOneInfofreeboardComment(int info_comment_no) {
		
		HashMap<String, Object>map = new HashMap<String, Object>();
		InfoFreeboardCommentVO infoFreeboardCommentVO = infofreeboardSQLMapper.selectInfoOneCommentByNo(info_comment_no);
		MemberVO memberVO = memberSQLMapper.memberSelectByNo(infoFreeboardCommentVO.getMember_no());
		
		map.put("infoFreeboardCommentVO", infoFreeboardCommentVO);
		map.put("member_nick", memberVO.getMember_nick());
		
		
		
		return map;
	}

	public void doRecommendCount(int info_freeboard_no, int member_no) {
		int checkdoRecommend = infofreeboardSQLMapper.checkdoRecommend(member_no, info_freeboard_no);
		if (checkdoRecommend > 0) {
			infofreeboardSQLMapper.deleteRecommend(info_freeboard_no, member_no);
		}else {
			infofreeboardSQLMapper.insertRecommend(info_freeboard_no, member_no);
		}
		System.out.println(checkdoRecommend);
		
	}

	public int checkdoRecommend(int member_no, int info_freeboard_no) {
		// TODO Auto-generated method stub
		
		
		return infofreeboardSQLMapper.checkdoRecommend(member_no, info_freeboard_no);
	}

	public void insertLottoNo(int lotto_no) {

	 infofreeboardSQLMapper.insertLottoNo(lotto_no);
	}

	public int selectfreeCharging(int member_no) {
		// TODO Auto-generated method stub
		return infofreeboardSQLMapper.selectfreeCharging(member_no);
	}


	public void buylottowithselectnumber(LottoUserVO lottoUserVO , int member_levelvalue) {
	
		
		int nowlottoround = infofreeboardSQLMapper.selectnowlottoround();
		
		lottoUserVO.setLotto_round(nowlottoround);
		int memberno=lottoUserVO.getMember_no();
		
		System.out.println(member_levelvalue);
		
		if(member_levelvalue >= 10000) {
			infofreeboardSQLMapper.buylottowithselectedNumber(lottoUserVO);
			memberSQLMapper.buylotto(memberno);
			
		}else {
			System.out.println("응모할수 있는 경험치가 부족합니다.");
		}
		
		
		
	}


	public ArrayList<LottoUserVO> getmylottoinfo(int member_no) {
	
				return infofreeboardSQLMapper.getmyallinfo(member_no);
	}

	
	
//	public ArrayList<HashMap<String, Object>> selectCategoryByFreeboardNo(int categoryNo){
//				
//		ArrayList<HashMap<String, Object>> result= new ArrayList<HashMap<String,Object>>();
//		
//		ArrayList<Integer> freeboardNolist = infofreeboardSQLMapper.selectCategoryByFreeboardNo(categoryNo);
//		
//		for(int freeboardNo : freeboardNolist) {
//		HashMap<String, Object> map = new HashMap<String, Object>();
//			
//			InfoFreeboardVO infoFreeboardVO = infofreeboardSQLMapper.selectinfoContentByNo(freeboardNo);
//			int memberNo = infoFreeboardVO.getMember_no();
//			MemberVO memberVO = memberSQLMapper.memberSelectByNo(memberNo);
//			int inforecommendVO = infofreeboardSQLMapper.selectRecommendCountByinfoFreeboardNo(freeboardNo);
//			int infofreeboardcommentVO = infofreeboardSQLMapper.selectCommentCountByNo(freeboardNo);
//			
//			
//			
//			map.put("memberNo", memberNo);
//			map.put("infoFreeboardVO", infoFreeboardVO);
//			map.put("inforecommendVO", inforecommendVO);
//			map.put("infofreeboardcommentVO", infofreeboardcommentVO);
//		
//		
//			result.add(map);
//		}
//		
//		
//		return result;
//	}


	
	public LottoServerVO getRemainningNextTime() {
		
		LottoServerVO lottoServerVO = infofreeboardSQLMapper.getNextTime();
		
		
		
		return lottoServerVO; 
		
	}
//0601
	public LottoServerVO selectserverlottonum() {
		
		
		return null;
	}
	
	public int selectlottoround() {
	      // TODO Auto-generated method stub
	      return infofreeboardSQLMapper.selectCurrentRound();
	   }
}
