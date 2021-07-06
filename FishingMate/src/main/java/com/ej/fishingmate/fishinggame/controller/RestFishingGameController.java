package com.ej.fishingmate.fishinggame.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ej.fishingmate.fishinggame.service.FishingGameSerivceImpl;
import com.ej.fishingmate.member.service.MemberServiceImpl;
import com.ej.fishingmate.vo.FishCatchRateVO;
import com.ej.fishingmate.vo.FishingGameChattingVO;
import com.ej.fishingmate.vo.FishingGameLogVO;
import com.ej.fishingmate.vo.LevelvalueHistoryVO;
import com.ej.fishingmate.vo.MemberVO;

@Controller
@RequestMapping("fishingGame/*")
@ResponseBody
public class RestFishingGameController {

	@Autowired
	private FishingGameSerivceImpl fishingGameSerivce;
	
	@Autowired
	private MemberServiceImpl memberService;
	

	//---------------------------- 낚시터 입장 관련 - 형준 -------------------------------
	//낚시터 입장 시 참여자 현황에 회원 추가 - 형준
	@RequestMapping("addMemberIntoFishingGame.do")
	public void addMemberIntoFishingGame(int member_no) {
		
		if (fishingGameSerivce.chkExistFishingGameJoin(member_no) == 0) {
			fishingGameSerivce.addMemberIntoFishingGame(member_no);
		}
	}
	
	//낚시터 입장한 회원 불러오기 - 형준
	@RequestMapping("getFishingGameJoinMembers.do")
	public HashMap<String, Object> getFishingGameJoinMembers(){
		HashMap<String, Object> map = new HashMap<String, Object>();
		
		ArrayList<HashMap<String, Object>> joinMemberList = fishingGameSerivce.getFishingGameJoinMembers();
		int joinMemberCount = fishingGameSerivce.getFishingGameJoinMemberCount();
		
		map.put("joinMemberList", joinMemberList);
		map.put("joinMemberCount", joinMemberCount);
		
		return map;
	}
	
	//------------------------------ 낚시터 입장 관련 끝 ---------------------------------
	
	//---------------------------- 채팅 관련 - 형준 -------------------------------
	//채팅 입력 시 - 형준
	@RequestMapping("writeChattingProcess.do")
	public void writeChattingProcess(FishingGameChattingVO fishingGameChattingVO) {
		
		fishingGameSerivce.writeChatContent(fishingGameChattingVO);
	}
	
	//채팅 목록 불러오기 - 형준
	@RequestMapping("getChattingList.do")
	public HashMap<String, Object> getChattingList(@RequestParam(defaultValue = "0") int chatting_no){
		HashMap<String, Object> map = new HashMap<String, Object>();
		
		ArrayList<HashMap<String, Object>> chattingList  = fishingGameSerivce.getChattingList(chatting_no);
		
		map.put("chattingList", chattingList);
		
		return map;
	}
	
	//------------------------------ 채팅 관련 끝 --------------------------------
	
	//----------------------------- 구글 차트 이용 잡힌 어종 현황 - 형준 --------------------------------
	//어종별 잡힌 횟수 불러오기 - 형준
	@RequestMapping("getFishCatchCount.do")
	public HashMap<String, Object> getFishCatchCount(){
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		ArrayList<FishCatchRateVO> fishCatchCount = fishingGameSerivce.getFishCatchCount();
		ArrayList<HashMap<String, Object>> fishCatchCount2 = fishingGameSerivce.getFishCatchCount2();
				
		map.put("fishCatchCount", fishCatchCount);
		map.put("fishCatchCount2", fishCatchCount2);
				
		return map;
	}
	
	//어종별 잡힌 비율 불러오기 - 형준
	@RequestMapping("getFishCatchRatio.do")
	public HashMap<String, Object> getFishCatchRatio(){
		HashMap<String, Object> map = new HashMap<String, Object>();
		
		ArrayList<HashMap<String, Object>> fishCatchRatio = fishingGameSerivce.getFishCatchRatio();
		
		map.put("fishCatchRatio", fishCatchRatio);
		
		return map;
	}
		
	//------------------------------ 구글 차트 이용 잡힌 어종 현황 끝 -----------------------------------
	
	
	//------------------------------ 낚시터 관련 시작 ------------------------------
	//현재 접속 회원의 경험치 불러오기
	@RequestMapping("getMyCurrentLevelValue.do")
	public HashMap<String, Object> getMyCurrentLevelValue(int member_no){
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		
		MemberVO memberVO = memberService.selectMemberByMno(member_no);
		
		map.put("member_levelvalue", memberVO.getMember_levelvalue());
		
		return map;
	}
	
	//낚시하기 클릭 시 300 경험치 차감
	@RequestMapping("startFishing.do")
	public void startFishing(int member_no) {
		
		LevelvalueHistoryVO levelvalueHistoryVO = new LevelvalueHistoryVO();
		levelvalueHistoryVO.setHistory_value(-300);
		levelvalueHistoryVO.setLevelvalue_category_no(0);
		levelvalueHistoryVO.setMember_no(member_no);
		
		fishingGameSerivce.decreaseLevelValue(member_no);
		fishingGameSerivce.insertLevelLog(levelvalueHistoryVO);
		
	}
	
	//낚인 물고기 이름 불러오기
	@RequestMapping("getRandomFishName.do")
	public HashMap<String, Object> getRandomFishName(){
		HashMap<String, Object> map = new HashMap<String, Object>();
		
		String fishName = fishingGameSerivce.getRandomFish();
		
		map.put("fishName", fishName);
		
		return map;
	}
	
	//물고기 정규화
	@RequestMapping("fishNormalization.do")
	public HashMap<String, Object> fishNormalization(String fish_name){
		double totalScore;
		HashMap<String, Object> map = new HashMap<String, Object>();
		int FishNo=fishingGameSerivce.getFishNo(fish_name);
		int FishTotal= fishingGameSerivce.getTotalFish();
		int FishCount=fishingGameSerivce.getFish(FishNo);
		double countTotal= (double)FishTotal/FishCount;
		HashMap<String, Object> fishLengths=fishingGameSerivce.getRandomFishLength(fish_name);
		
		double normalizeLength = (double)fishLengths.get("normalizeLength");
		double fishLength = (double)fishLengths.get("fishLength");
		
		if(countTotal > 0 && countTotal != 1 && countTotal <100000 ) {
			totalScore = 40*countTotal*normalizeLength;
		}
		else {
			totalScore = 40;
		}
		
		map.put("totalScore", totalScore);
		map.put("fishLength", fishLength);
		map.put("FishNo", FishNo);
		return map;
	}
	
	//물고기 로그삽입
	@RequestMapping("writeFishLog.do")
	public void writeFishLog(FishingGameLogVO fishingGameLogVO, HttpSession session) {
		
		MemberVO memberVO = (MemberVO)session.getAttribute("sessionUser");
		int member_no = memberVO.getMember_no();
		
		if (fishingGameLogVO.getLog_value() != 0) {
			LevelvalueHistoryVO levelvalueHistoryVO = new LevelvalueHistoryVO();
			levelvalueHistoryVO.setHistory_value(fishingGameLogVO.getLog_value());
			levelvalueHistoryVO.setMember_no(member_no);
			levelvalueHistoryVO.setLevelvalue_category_no(1);
			
			fishingGameSerivce.increaseLevelValue(fishingGameLogVO.getLog_value(), member_no);
			fishingGameSerivce.insertLevelLog(levelvalueHistoryVO);
		}
		
		fishingGameLogVO.setMember_no(member_no);
		
		fishingGameSerivce.writeFishingLog(fishingGameLogVO);
	}
	
	//낚시게임 로그 불러오기
	@RequestMapping("getFishingGameLog.do")
	public ArrayList<HashMap<String, Object>> getFishingGameLog(@RequestParam(defaultValue = "0") int member_no, 
																@RequestParam(defaultValue = "0") int log_no){
		
		
		return fishingGameSerivce.getFishingGameLogList(member_no, log_no);
	}
	
	
	
	
	//획득&소모한 경험치 조회 - 형준
	@RequestMapping("getMyObtainValue.do")
	public HashMap<String, Object> getMyObtainValue(int member_no){
		HashMap<String, Object> map = new HashMap<String, Object>();
		
		double obtainValue = fishingGameSerivce.getMyObtainValue(member_no);
		int fishingCount = fishingGameSerivce.getTryFishingCount(member_no);
		int useValue = 300*fishingCount;
		
		obtainValue = (double)Math.round(obtainValue*100)/100;
		
		map.put("obtainValue", obtainValue);
		map.put("useValue", useValue);
		
		return map;
	}
	
	
	//경험치 무료충전
	@RequestMapping("valueCharging.do")
	public void valueCharging(int member_no) {
		double total=600;
		LevelvalueHistoryVO levelvalueHistoryVO = new LevelvalueHistoryVO();
		levelvalueHistoryVO.setHistory_value(total);
		levelvalueHistoryVO.setMember_no(member_no);
		levelvalueHistoryVO.setLevelvalue_category_no(6);
		fishingGameSerivce.insertLevelLog(levelvalueHistoryVO);
		fishingGameSerivce.increaseLevelValue(total,member_no);
	}
	
	//무료충전 횟수불러오기
	@RequestMapping("getFreeCharging.do")
	public int getFreeCharging(int member_no) {
		
		return fishingGameSerivce.selectfreeCharging(member_no);
	}
	//top5 불러오기 명화
	@RequestMapping("getTopValue.do")
	public ArrayList<HashMap<String, Object>> getTopValue(){
		
		return fishingGameSerivce.getTopLog();
	}
	
	
	
	//------------------------------ 낚시터 관련 끝 ------------------------------
	
}
