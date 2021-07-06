package com.ej.fishingmate.fishinggame.service;

import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.Random;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ej.fishingmate.fishinggame.mapper.FishingGameSQLMapper;
import com.ej.fishingmate.member.mapper.MemberSQLMapper;
import com.ej.fishingmate.vo.FishCatchRateVO;
import com.ej.fishingmate.vo.FishingGameChattingVO;
import com.ej.fishingmate.vo.FishingGameJoinMemberVO;
import com.ej.fishingmate.vo.FishingGameLogVO;
import com.ej.fishingmate.vo.FishingGameProbabilityVO;
import com.ej.fishingmate.vo.FishingGameTopLogVO;
import com.ej.fishingmate.vo.LevelvalueHistoryVO;
import com.ej.fishingmate.vo.MemberVO;

@Service
public class FishingGameSerivceImpl {

	@Autowired
	private FishingGameSQLMapper fishingGameSQLMapper;
	
	@Autowired
	private MemberSQLMapper memberSQLMapper;
	
	//---------------------------- 낚시터 입장 관련 - 형준 -------------------------------
	//낚시터 입장 시 참여자 현황에 회원 추가 - 형준
	public void addMemberIntoFishingGame(int member_no) {
		
		fishingGameSQLMapper.insertMemberIntoFishingGame(member_no);
	}
	
	//낚시터에 입장한 회원인지 확인 - 형준
	public int chkExistFishingGameJoin(int member_no) {
		
		return fishingGameSQLMapper.chkExistFishingGameJoin(member_no);
	}
	
	//낚시터 입장한 회원 불러오기 - 형준
	public ArrayList<HashMap<String, Object>> getFishingGameJoinMembers(){
		
		ArrayList<HashMap<String, Object>> joinMemberList = new ArrayList<HashMap<String, Object>>();
		ArrayList<FishingGameJoinMemberVO> list = fishingGameSQLMapper.selectFishingGameJoinMembers();
		
		for(FishingGameJoinMemberVO fishingGameJoinMemberVO : list) {
			HashMap<String, Object> map = new HashMap<String, Object>();
			
			MemberVO memberVO = memberSQLMapper.selectMemberByMno(fishingGameJoinMemberVO.getMember_no());
			
			map.put("fishingGameJoinMemberVO", fishingGameJoinMemberVO);
			map.put("member_levelvalue", memberVO.getMember_levelvalue());
			map.put("member_nick", memberVO.getMember_nick());
			
			joinMemberList.add(map);
		}
		
		return joinMemberList;
	}
	
	//낚시터 입장한 회원 수 불러오기 - 형준
	public int getFishingGameJoinMemberCount() {
		
		return fishingGameSQLMapper.selectFishingGameJoinMemberCount();
	}
	
	//낚시터 퇴장 시 참여자 현황에 회원 제거 - 형준
	public void deleteMemberFromFishingGame(int member_no) {
		
		fishingGameSQLMapper.deleteMemberFromFishingGame(member_no);
	}
	
	//------------------------------ 낚시터 입장 관련 끝 ---------------------------------
	
	//---------------------------- 채팅 관련 - 형준 -------------------------------
	//채팅 입력 시 - 형준
	public void writeChatContent(FishingGameChattingVO fishingGameChattingVO) {
		
		fishingGameSQLMapper.insertChatContent(fishingGameChattingVO);
	}
	
	//채팅 목록 불러오기 - 형준
	public ArrayList<HashMap<String, Object>> getChattingList(int chatting_no){
		ArrayList<HashMap<String, Object>> chattingList = new ArrayList<HashMap<String, Object>>();
		ArrayList<FishingGameChattingVO> list = fishingGameSQLMapper.selectChattingList(chatting_no);
		
		Collections.reverse(list);
		
		for(FishingGameChattingVO fishingGameChattingVO : list) {
			HashMap<String, Object> map = new HashMap<String, Object>();
			
			MemberVO memberVO = memberSQLMapper.memberSelectByNo(fishingGameChattingVO.getMember_no());
			
			map.put("fishingGameChattingVO", fishingGameChattingVO);
			map.put("member_nick", memberVO.getMember_nick());
			
			chattingList.add(map);
		}
		
		return chattingList;
	}
	
	
	//------------------------------ 채팅 관련 끝 --------------------------------
	
	//----------------------------- 구글 차트 이용 잡힌 어종 현황 - 형준 --------------------------------
	//어종별 잡힌 횟수 불러오기 - 형준
	public ArrayList<FishCatchRateVO> getFishCatchCount(){
		
		ArrayList<FishCatchRateVO> list = fishingGameSQLMapper.selectFishCatchCount();
		
		return list;
	}
	
	//test - 어종별
	public ArrayList<HashMap<String, Object>> getFishCatchCount2() {
		
		ArrayList<HashMap<String, Object>> result = fishingGameSQLMapper.selectFishCatchCount2();

		return result;
	}
	
	//어종별 잡힌 비율 불러오기 - 형준
	public ArrayList<HashMap<String, Object>> getFishCatchRatio(){
		
		return fishingGameSQLMapper.selectFishCatchRatio();
	}
		
	//------------------------------ 구글 차트 이용 잡힌 어종 현황 끝 -----------------------------------
	
	//------------------------------ 명화 --------------------------------------
	//물고기 뽑기 명화
	public String getRandomFish() {
		double tmpRandom = (Math.random() * 100);
		double tmpRatePrev = 0, tmpRateNext = 0;
		String result = null;
		//소수 둘째자리까지 절삭
		tmpRandom = Math.round(tmpRandom * 100) / 100.0;
		
		System.out.println("설정된 랜덤값" + tmpRandom);
		ArrayList<FishingGameProbabilityVO> showofflist = fishingGameSQLMapper.selectProbability();
		ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String, Object>>();
			for(FishingGameProbabilityVO fishingGameProbabilityVO: showofflist) {
				String fishName2 = fishingGameSQLMapper.selectFishName(fishingGameProbabilityVO.getFish_no());
				double fishProbability = fishingGameProbabilityVO.getProbability_fish();
				
				HashMap<String, Object> map = new HashMap<String, Object>();
				map.put("rate", fishProbability);
				map.put("value",fishName2);
				
				list.add(map);
				
		}
			for(int i = 0; i < list.size(); i++) {
				if(tmpRandom == 100) {
					//만약 난수가 100이라면 가장 마지막에있는 list 인덱스에 있는 value 적용
					result = (String)(list.get(list.size()-1).get("value"));
					break;
				} else {
					double rate = (double)list.get(i).get("rate");
					tmpRateNext = tmpRatePrev + rate;
					if(tmpRandom >= tmpRatePrev && tmpRandom < tmpRateNext) {
						result = (String)list.get(i).get("value");
						break;
					} else {
						tmpRatePrev = tmpRateNext;
					}
				}
			}
			if(result == null) {
				result="꽝";
				System.out.println(result + "이 낚였습니다.");
				return result;
			}else {
				System.out.println(result + "가 낚였습니다.");
				return result;
			}
		}
	
		//물고기 길이 뽑기 명화
		public HashMap<String, Object> getRandomFishLength(String fish_name) {
			HashMap<String, Object> map = new HashMap<String, Object>();
			
			Random oRandom = new Random();
			FishingGameProbabilityVO fishingGameProbabilityVO =
					fishingGameSQLMapper.selectFishLength(fish_name);
			
			double minLength = fishingGameProbabilityVO.getProbability_minlength();
			double maxLength = fishingGameProbabilityVO.getProbability_maxlength();
			
			//평균 크기 및 표준편차 구하기
			double averageLength = (minLength + maxLength)/2;
			double standardDeviation = (maxLength - averageLength)/2;
			
			double fishLength = (oRandom.nextGaussian()*standardDeviation) + averageLength;
			
			//물고기 길이 표준화
			double normalizeLength = (fishLength - minLength)/(maxLength - minLength);
			
			map.put("fishLength", fishLength);
			map.put("normalizeLength", normalizeLength);
			
			return map;
		}
		
		//물고기 게임 로그 삽입 명화
		public void writeFishingLog(FishingGameLogVO fishingGameLogVO) {
			
			fishingGameSQLMapper.insertFishingGameLog(fishingGameLogVO);
		}
		
		//물고기 게임 로그 불러오기 명화
		public ArrayList<HashMap<String, Object>> getFishingGameLogList(int member_no, int log_no){
			ArrayList<HashMap<String, Object>> result = new ArrayList<HashMap<String, Object>>();
			ArrayList<FishingGameLogVO> logList = fishingGameSQLMapper.selectGameLog(member_no, log_no);
			
			Collections.reverse(logList);
			
			for(FishingGameLogVO list : logList) {
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
		
		//물고기 번호 명화
		public int getFishNo(String fish_name) {

			return fishingGameSQLMapper.selectFishNo(fish_name);
		}
		
		// 어종 총 갯수 불러오기 명화
		public int getTotalFish() {
			
			return fishingGameSQLMapper.selectTotalFish();
		}
		
		//어종별 갯수 불러오기 명화
		public int getFish(int fish_no) {
			
			return fishingGameSQLMapper.selectFish(fish_no);
		}
		
		//경험치 증가 명화
		public void increaseLevelValue(double totalScore, int member_no) {
			fishingGameSQLMapper.increaseLevelValue(totalScore, member_no);
		}
		
		//경험치 감소 명화
		public void decreaseLevelValue(int member_no) {
			fishingGameSQLMapper.decreaseLevelValue(member_no);
		}
		
		//경험치 로그 삽입 명화
		public void insertLevelLog(LevelvalueHistoryVO levelvalueHistoryVO) {
			
			fishingGameSQLMapper.insertLevelHistoryLog(levelvalueHistoryVO);
		}

		//----------------------- 획득&소모한 경험치 조회 --------------------------------
		
		//획득한 경험치 조회 - 형준
		public double getMyObtainValue(int member_no) {
			
			Double obtainValue = fishingGameSQLMapper.selectMyObtainValue(member_no);
			
			if (obtainValue == null) {
				obtainValue = 0.0;
			}
			
			return obtainValue;
		}
	
		//낚시하기 한 횟수 조회 - 형준
		public int getTryFishingCount(int member_no) {
			
			return fishingGameSQLMapper.selectTryFishingCount(member_no);
		}
		
		//----------------------- 획득&소모한 경험치 조회 끝 ------------------------------
		
		//무료충전 횟수 명화
		public int selectfreeCharging(int member_no) {
			return fishingGameSQLMapper.selectfreeCharging(member_no);
		}
		//top5 불러오기 명화
				public ArrayList<HashMap<String, Object>> getTopLog() {
					ArrayList<HashMap<String, Object>> result = new ArrayList<HashMap<String,Object>>();
					ArrayList<FishingGameTopLogVO> toplist = fishingGameSQLMapper.selectTopLogValue();
					
					for(FishingGameTopLogVO fishingGameTopLogVO : toplist) {
						MemberVO memberVO=memberSQLMapper.memberSelectByNo(fishingGameTopLogVO.getMember_no());
						HashMap<String, Object> map = new HashMap<String, Object>();
						map.put("fishingGameTopLogVO", fishingGameTopLogVO);
						map.put("memberVO", memberVO);
						result.add(map);
					}
					return result;
				}
	
	//------------------------------ 명화 끝 ------------------------------------
}
