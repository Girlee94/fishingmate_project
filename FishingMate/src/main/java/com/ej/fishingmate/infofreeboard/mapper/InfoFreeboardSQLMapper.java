package com.ej.fishingmate.infofreeboard.mapper;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.annotations.Param;

import com.ej.fishingmate.vo.InfoCategoryListVO;
import com.ej.fishingmate.vo.InfoCategoryVO;
import com.ej.fishingmate.vo.InfoFreeboardCommentVO;
import com.ej.fishingmate.vo.InfoFreeboardVO;
import com.ej.fishingmate.vo.LevelvalueHistoryVO;
import com.ej.fishingmate.vo.LottoServerVO;
import com.ej.fishingmate.vo.LottoUserVO;
import com.ej.fishingmate.vo.LottoVO;

public interface InfoFreeboardSQLMapper {

	public void insertInfoFreeboardContent(InfoFreeboardVO infoFreeboardVO);

	public ArrayList<Integer> selectAll(int info_category_no);
	
	public String selectCategoryName(int info_category_no);
	
	public int InfoFreeboardTotalNo();
 
	public InfoFreeboardVO selectinfoContentByNo(int info_freeboard_no);

	public void updateinfoContent(InfoFreeboardVO infoFreeboardVO);

	public void deleteinfoContent(int info_freeboard_no);


	public int createinfoFreeboardKey();

	public void insertinfoComment(InfoFreeboardCommentVO infoFreeboardCommentVO);

	public ArrayList<InfoFreeboardCommentVO> selectinfoAllCommentContentByNo(int info_freeboard_no);

	public void updateinfoCommentByMnoAndCno(InfoFreeboardCommentVO infoFreeboardCommentVO);

	public InfoFreeboardCommentVO selectCommentByMnoAndCno(
															@Param("member_no")int member_no, 
															@Param("info_comment_no")int info_comment_no);


	public void deleteinfoComment(InfoFreeboardCommentVO infoFreeboardCommentVO);

	
	//---------------------------추천
	
	public int selectRecommendCountByFreeboardNoAndMemberNo(
					@Param("info_freeboard_no") int info_freeboard_no , 
					@Param("member_no") int member_no);

	public void deleteRecommend(
					@Param("info_freeboard_no") int info_freeboard_no , 
					@Param("member_no") int member_no);

	public void insertRecommend(
			@Param("info_freeboard_no") int info_freeboard_no , 
			@Param("member_no") int member_no);

	public int selectRecommendCountByinfoFreeboardNo(int info_freeboard_no);

	public int selectCommentCountByNo(int info_freeboard_no);


	//-------------------------카테고리


	public ArrayList<InfoCategoryVO> selectCategoryList();

	public InfoCategoryVO selectCategoryByNo(int info_category_no);

	public void insertInfoCategoryList(InfoCategoryListVO infoCategoryListVO);

	// 리드카운트 증가
	public int updateinforeadcount(int info_freeboard_no);

	public ArrayList<Integer> selectAllList();

	public void deleteinfoCommentByFno(int info_comment_no);
//댓글 하나 불러오기
	public InfoFreeboardCommentVO selectInfoOneCommentByNo(int info_comment_no);

	//추천 해버리기ajax
	
	public int checkdoRecommend(@Param("member_no") int member_no,
								@Param("info_freeboard_no") int info_freeboard_no);

	public void insertLottoNo(int lotto_no);

	public int selectfreeCharging(int member_no);

	
	//로또 서비스 생성
	
	public void updatelottoserver(LottoServerVO lottoserverVO);

	
	//로또 서비스 정산
	public void settlelottoserver(LottoServerVO lottoserverVO, LottoUserVO lottouserVO);

	//로또 현재 라운드 불러오기
	public int selectCurrentRound();
	
	//로또 다음 라운드 생성
	public void insertnextround(LottoServerVO lottoserverVO);

	//로또 번호표 구매하ㅜ기
	public void buylottowithselectedNumber(LottoUserVO lottoUserVO);

	public int selectnowlottoround();
	
	//유저 로또 정보 불러오기
	public ArrayList<LottoUserVO> getmyallinfo(int member_no);

	
	//유저가 해당 라운드에 고른 로또 정보 가져오기
	public ArrayList<LottoUserVO> selectnumberbyroundandmemberno();
	
//시간 셋팅
	public LottoServerVO getNextTime();

	
	
//	public ArrayList<Integer> selectCategoryByFreeboardNo(int categoryNo);
}	


