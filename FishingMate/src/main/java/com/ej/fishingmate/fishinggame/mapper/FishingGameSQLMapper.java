package com.ej.fishingmate.fishinggame.mapper;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.annotations.Param;

import com.ej.fishingmate.vo.FishCatchRateVO;
import com.ej.fishingmate.vo.FishingGameChattingVO;
import com.ej.fishingmate.vo.FishingGameJoinMemberVO;
import com.ej.fishingmate.vo.FishingGameLogVO;
import com.ej.fishingmate.vo.FishingGameProbabilityVO;
import com.ej.fishingmate.vo.FishingGameTopLogVO;
import com.ej.fishingmate.vo.LevelvalueHistoryVO;
import com.ej.fishingmate.vo.MemberVO;

public interface FishingGameSQLMapper {
	
	//---------------------------- 낚시터 입장 관련 - 형준 -------------------------------
	//낚시터 입장 시 참여자 현황에 회원 추가 - 형준
	public void insertMemberIntoFishingGame(int member_no);
	
	//낚시터에 입장한 회원인지 확인 - 형준
	public int chkExistFishingGameJoin(int member_no);
	
	//낚시터 입장한 회원 불러오기 - 형준
	public ArrayList<FishingGameJoinMemberVO> selectFishingGameJoinMembers();
	
	//낚시터 입장한 회원 수 불러오기 - 형준
	public int selectFishingGameJoinMemberCount();
	
	//낚시터 퇴장 시 참여자 현황에 회원 제거 - 형준
	public void deleteMemberFromFishingGame(int member_no);
	
	//------------------------------ 낚시터 입장 관련 끝 ---------------------------------
	
	//---------------------------- 채팅 관련 - 형준 -------------------------------
	//채팅 입력 시 - 형준
	public void insertChatContent(FishingGameChattingVO fishingGameChattingVO);

	//채팅 목록 불러오기 - 형준
	public ArrayList<FishingGameChattingVO> selectChattingList(@Param("chatting_no") int chatting_no);

	
	//------------------------------ 채팅 관련 끝 --------------------------------
	
	//----------------------------- 구글 차트 이용 잡힌 어종 현황 - 형준 --------------------------------
	//어종별 잡힌 횟수 불러오기 - 형준
	public ArrayList<FishCatchRateVO> selectFishCatchCount();
	
	//test - 어종별 잡힌 횟수 불러오기 - 형준
	public ArrayList<HashMap<String, Object>> selectFishCatchCount2();
	
	//어종별 잡힌 비율 불러오기 - 형준
	public ArrayList<HashMap<String, Object>> selectFishCatchRatio();
	
	
	//------------------------------ 구글 차트 이용 잡힌 어종 현황 끝 -----------------------------------
	
	//------------------------------ 명화 --------------------------------------
	//물고기 확률 가져오기
	public ArrayList<FishingGameProbabilityVO> selectProbability();
	
	//물고기 이름 표시
	public String selectFishName(int fish_no);
	
	//물고기 번호 표시
	public int selectFishNo(String fish_name);
	
	//물고기 길이
	public FishingGameProbabilityVO selectFishLength(String fish_name);
	
	//게임 로그 삽입
	public void insertFishingGameLog(FishingGameLogVO fishingGameLogVO);
	
	//게임 로그 불러오기 명화
	public ArrayList<FishingGameLogVO> selectGameLog(
			@Param("member_no") int member_no,
			@Param("log_no") int log_no);
	
	//어종 총합 불러오기 명화
	public int selectTotalFish();
	
	//어종별 갯수 불러오기 명화
	public int selectFish(int fish_no);
	
	//경험치 증가 명화
	public void increaseLevelValue(@Param("totalScore") double totalScore,
				@Param("member_no") int member_no);
	
	//경험치 감소 명화
	public void decreaseLevelValue(int member_no);
	
	//경험치 로그 삽입 명화
	public void insertLevelHistoryLog(LevelvalueHistoryVO levelvalueHistoryVO);
	
	
	//----------------------- 획득&소모한 경험치 조회 --------------------------------
	//획득한 경험치 조회 - 형준
	public Double selectMyObtainValue(int member_no);
	
	//낚시하기 한 횟수 조회 - 형준
	public int selectTryFishingCount(int member_no);
	
	//----------------------- 획득&소모한 경험치 조회 끝 ------------------------------
	
	//무료충전 횟수 명화
	public int selectfreeCharging(int member_no);
	
	//top5 불러오기 명화
		public ArrayList<FishingGameTopLogVO> selectTopLogValue();
	
	
	//------------------------------ 명화 끝 ------------------------------------
}
