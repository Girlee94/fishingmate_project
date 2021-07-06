package com.ej.fishingmate.dice.controller;

import java.text.DecimalFormat;
import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ej.fishingmate.dice.service.DiceServiceImpl;
import com.ej.fishingmate.vo.DiceGameVO;
import com.ej.fishingmate.vo.MemberVO;

@Controller
@RequestMapping("/dice/*")
public class DiceController {
	
	@Autowired
	private DiceServiceImpl diceService;
	
	@RequestMapping("dicePage.do")
	public String dicePage(){
		
		return "dice/diceGame";
	}
	DecimalFormat comma = new DecimalFormat("###,###");

	@ResponseBody
	@RequestMapping("diceGame.do")
	public HashMap<String,Object> diceGame(HttpSession session) {
		HashMap<String,Object> map = new HashMap<String,Object>(); 
		
		MemberVO memberVO = (MemberVO) session.getAttribute("sessionUser");
		
		
		
		int currentJackpotMoney = diceService.getCurrentJackpotMoney();
		int myLevelValue = diceService.getMyLevelValue(memberVO.getMember_no());
		
		comma.format(myLevelValue);
		comma.format(currentJackpotMoney);
		
		map.put("currentJackpotMoney", comma.format(currentJackpotMoney));		
		map.put("myLevelValue", comma.format(myLevelValue));
		
		return map;		
	}

	@ResponseBody
	@RequestMapping("throwDice.do")
	public HashMap<String,Object> throwDice(HttpSession session , DiceGameVO diceGameVO , @RequestParam(defaultValue = "0") int bet2,@RequestParam(defaultValue = "0")int bet3,
																						  @RequestParam(defaultValue = "0")int bet23,@RequestParam(defaultValue = "0")int bet1) {
		HashMap<String,Object> map = new HashMap<String,Object>(); 
		
		int currentJackpotMoney = diceService.getCurrentJackpotMoney();
		
		comma.format(currentJackpotMoney);
		
		map.put("currentJackpotMoney", comma.format(currentJackpotMoney));
		
		
		int myTotalBetMoney = bet1+bet2+bet3+bet23;
		
		comma.format(myTotalBetMoney);
		
		MemberVO memberVO = (MemberVO) session.getAttribute("sessionUser");
		diceGameVO.setMember_no(memberVO.getMember_no());
		
		//내가 돈이 있냐???...없으면... 진행 X
		int myLevelValue = diceService.getMyLevelValue(memberVO.getMember_no());
		
		comma.format(myLevelValue);
		
		map.put("myLevelValue", comma.format(myLevelValue));
		
		if(myLevelValue < myTotalBetMoney) {
			
			map.put("result", "fail");
			map.put("reason", "레벨이 부족합니다.");
			
			return map;
		}
		
		
		//diceService.insertDiceGame(diceGameVO);
		
		//제한인가??
		
		
		int dice1 = (int)(Math.random()*6) + 1;
		int dice2 = (int)(Math.random()*6) + 1;
		int dice3 = (int)(Math.random()*6) + 1;
		int dice4 = (int)(Math.random()*6) + 1;
		int dice5 = (int)(Math.random()*6) + 1;
		
		//배팅		
		int diceAll = dice1+dice2+dice3+dice4+dice5;
		int one = 0;
		
		int totalPrice = 0;
		map.put("bet2", "lose");
		map.put("bet3", "lose");
		map.put("bet23", "lose");
		map.put("bet1", "lose");
		
		
		if (diceAll % 2 ==0) { // 2의배수
			//2배당..
			map.put("bet2", "win");
			totalPrice += (int)(bet2 * 2);
		}
		if (diceAll % 3 == 0) { // 3의 배수
			//2.5배당
			map.put("bet3", "win");
			totalPrice += (int)(bet3 * 2.5);
		}
		if (diceAll%2!=0 && diceAll%3!=0) { //2,3의 배수 모두 제외
			//2.5배당..
			map.put("bet23", "win");
			totalPrice += (int)(bet23 * 2.5);
		}
		//주사위 1 갯수 곱하기 시작
		if (dice1 == 1) {
			map.put("bet1", "win");
			one++;
		}
		if (dice2 == 1) {
			map.put("bet1", "win");
			one++;
		}
		if (dice3 == 1) {
			map.put("bet1", "win");
			one++;
		}
		if (dice4 == 1) {
			map.put("bet1", "win");
			one++;
		}
		if (dice5 == 1) {
			map.put("bet1", "win");
			one++;
		}
		map.put("bet1", "win");
		totalPrice += (int)(bet1 * one);
		// 1곱하기 끝
		 
		if (diceAll <= 15){ // 올 1 잭팟
			
			//잭팟 머니를 가져오고... 내 레벨에 더해주고... 잭팟 머니를 0으로 한다....
			diceService.calculateMemberLevelValue(currentJackpotMoney,memberVO.getMember_no());
			diceService.initJackpotMoney();
			map.put("Great", true);			
			map.put("currentJackpotMoney",0);
			
		}else{ 
			map.put("Great", false);
		}
	
		
		
		//떼어 먹기.... 땄을때만 수수료를....
		if(totalPrice - myTotalBetMoney > 0) {
			//땄을때...
			diceService.calculateMemberLevelValue((totalPrice - myTotalBetMoney) * 90 / 100 , memberVO.getMember_no());
			//10프로 가져가기
			diceService.increaseJackPot((totalPrice - myTotalBetMoney) * 10 / 100);
			
			
		}else {
			//잃었을때...
			diceService.calculateMemberLevelValue(totalPrice - myTotalBetMoney , memberVO.getMember_no());
		}
		
		
		//적자 흑자
	    int plma = (totalPrice-myTotalBetMoney);
	    map.put("plma", plma);
		
		map.put("dice1", dice1);
		map.put("dice2", dice2);
		map.put("dice3", dice3);
		map.put("dice4", dice4);
		map.put("dice5", dice5);
		
		map.put("winMoney", totalPrice);
		map.put("totalBetMoney", myTotalBetMoney);
		
		//사용자가 몇번을 선택했는가??....		
		
		//DB 경험치 증가 라던가... 혹은... 경험치가 빠져야 되....
		

		
		
		return map;
		
	}
	
	
}
