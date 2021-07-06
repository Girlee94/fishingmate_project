package com.ej.fishingmate.dice.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ej.fishingmate.dice.mapper.DiceSQLMapper;
import com.ej.fishingmate.vo.DiceGameVO;

@Service
public class DiceServiceImpl {
	
	@Autowired
	private DiceSQLMapper diceSQLMapper;
	
	
	public void insertDiceGame(DiceGameVO diceGameVO) {
		
		diceSQLMapper.insertDice(diceGameVO);
	}
	
	public void calculateMemberLevelValue(int value , int member_no) {
		diceSQLMapper.calculateMemberLevelValue(value , member_no);
	}
	
	public void increaseJackPot(int value) {
		diceSQLMapper.increaseJackPot(value);
	}
	
	public int getMyLevelValue(int member_no) {
		return diceSQLMapper.getMyLevelValue(member_no);
	}
	
	public int getCurrentJackpotMoney() {
		return diceSQLMapper.getCurrentJackpotMoney();
	}
	
	public void initJackpotMoney() {
		diceSQLMapper.initJackpotMoney();
	}
}
