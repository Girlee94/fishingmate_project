package com.ej.fishingmate.fishshare.mapper;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.annotations.Param;

import com.ej.fishingmate.vo.FishCatchRateVO;
import com.ej.fishingmate.vo.FishShareCountVO;
import com.ej.fishingmate.vo.FishShareLogVO;
import com.ej.fishingmate.vo.FishShareStorageVO;
import com.ej.fishingmate.vo.MemberVO;

public interface FishingShareSQLMapper {
	
	//회원 정보 불러오기 - 명화
	public MemberVO memberSelectByNo(int member_no);
	//구매하기 - 명화
	public void byefishshare(FishShareStorageVO fishShareStorageVO);
	//구매하기2 - 명화
	public void updatefishshare(FishShareStorageVO fishShareStorageVO);
	//판매하기 - 명화
	public void salefishshare(FishShareStorageVO fishShareStorageVO);
	//경험치 차감 - 명화
	public void decreasefishshare(FishShareStorageVO fishShareStorageVO);
	//경험치 증가 - 명화
	public void addfishshare(FishShareStorageVO fishShareStorageVO);
	//물고기 보유현황 - 명화
	public ArrayList<FishShareCountVO> selectfishcount(int member_no);
	//물고기 구매 확인 - 명화
	public int checkFishShare(FishShareStorageVO fishShareStorageVO);
	//물고기 보유 확인 - 명화
	public Integer checkFish(FishShareStorageVO fishShareStorageVO);
	//물고기 테이블 삭제 - 명화
	public void deleteFish(FishShareStorageVO fishShareStorageVO);
	//물고기 로그 삽입 - 명화
	public void insertFishLog(FishShareLogVO fishShareLogVO);
	//물고기 로그 불러오기 - 명화
	public ArrayList<FishShareLogVO> selectFishLog(
			@Param("member_no") int member_no,
			@Param("fishshare_log_no") int fishshare_log_no);
	//------------------------구글 차트 이용------------------------
	//어종별 잡힌 횟수 불러오기 - 명화
	public ArrayList<HashMap<String, Object>> selectFishCatchCount3(
			@Param("no") int no,
			@Param("isGetAll") boolean isGetAll);
}
