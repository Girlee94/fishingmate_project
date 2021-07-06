package com.ej.fishingmate.fishshare.service;

import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ej.fishingmate.fishinggame.mapper.FishingGameSQLMapper;
import com.ej.fishingmate.fishshare.mapper.FishingShareSQLMapper;
import com.ej.fishingmate.member.mapper.MemberSQLMapper;
import com.ej.fishingmate.vo.FishCatchRateVO;
import com.ej.fishingmate.vo.FishShareCountVO;
import com.ej.fishingmate.vo.FishShareLogVO;
import com.ej.fishingmate.vo.FishShareStorageVO;
import com.ej.fishingmate.vo.MemberVO;

@Service
public class FishingShareServicelmpl {
	
	@Autowired
	private FishingShareSQLMapper fishingShareSQLMapper;
	@Autowired
	private FishingGameSQLMapper fishingGameSQLMapper;
	@Autowired
	private MemberSQLMapper memberSQLMapper;
	//회원 정보 불러오기 명화
	public MemberVO memberSelectByNo(int member_no) {
		return fishingShareSQLMapper.memberSelectByNo(member_no);
	}//구매하기 명화
	public void byefishshare(FishShareStorageVO fishShareStorageVO) {
		fishingShareSQLMapper.byefishshare(fishShareStorageVO);
	}//구매하기 명화
	public void updatefishshare(FishShareStorageVO fishShareStorageVO) {
		fishingShareSQLMapper.updatefishshare(fishShareStorageVO);
	}//판매하기 명화
	public void salefishshare(FishShareStorageVO fishShareStorageVO){
		fishingShareSQLMapper.salefishshare(fishShareStorageVO);
	}//경험치 차감 명화}
	public void decreasefishshare(FishShareStorageVO fishShareStorageVO) {
		fishingShareSQLMapper.decreasefishshare(fishShareStorageVO);
	}//물고기 보유현황 명화 
	public ArrayList<HashMap<String, Object>> selectfishcount(int member_no) {
		ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String, Object>>();
		ArrayList<FishShareCountVO> FishShareCountlist 
		= fishingShareSQLMapper.selectfishcount(member_no);
		
		for(FishShareCountVO fishShareCountVO : FishShareCountlist) {
			HashMap<String, Object> map = new HashMap<String, Object>();
			String Fishname=fishingGameSQLMapper.selectFishName(fishShareCountVO.getFish_no());
			map.put("fishShareCountVO", fishShareCountVO);
			map.put("Fishname", Fishname);
			list.add(map);
	}
		return list;
	}//경험치 증가 명화
	public void addfishshare(FishShareStorageVO fishShareStorageVO) {
		fishingShareSQLMapper.addfishshare(fishShareStorageVO);
	}//물고기 구매 확인 명화
	public int checkFishShare(FishShareStorageVO fishShareStorageVO) {
		return fishingShareSQLMapper.checkFishShare(fishShareStorageVO);
	}//물고기 보유 확인 명화
	public Integer checkFish(FishShareStorageVO fishShareStorageVO) {
		return fishingShareSQLMapper.checkFish(fishShareStorageVO);
	}//물고기 테이블삭제 명화
	public void deleteFish(FishShareStorageVO fishShareStorageVO) {
		fishingShareSQLMapper.deleteFish(fishShareStorageVO);
	}//물고기 로그 삽입 명화
	public void insertFishLog(FishShareLogVO fishShareLogVO) {
		System.out.println("2");
		fishingShareSQLMapper.insertFishLog(fishShareLogVO);
	}//주식 로그 불러오기 명화
	public ArrayList<HashMap<String, Object>> getFishShareLogList(int member_no, int log_no){
		ArrayList<HashMap<String, Object>> result = new ArrayList<HashMap<String, Object>>();
		ArrayList<FishShareLogVO> logList = fishingShareSQLMapper.selectFishLog(member_no, log_no);
		
		Collections.reverse(logList);
		
		for(FishShareLogVO list : logList) {
			HashMap<String, Object> map = new HashMap<String, Object>();
			MemberVO memberVO = memberSQLMapper.memberSelectByNo(list.getMember_no());
			String fish_name = fishingGameSQLMapper.selectFishName(list.getFish_no());
			
			map.put("fishingGameLogVO", list);
			map.put("member_nick", memberVO.getMember_nick());
			map.put("fish_name", fish_name);
			
			result.add(map);
		}
		return result;
	}
	//구글차트 불러오기 명화
	public ArrayList<HashMap<String, Object>> getFishCatchCount3(int no, boolean isGetAll) {
		
		ArrayList<HashMap<String, Object>> list = fishingShareSQLMapper.selectFishCatchCount3(no, isGetAll);

		return list;
	}
}
