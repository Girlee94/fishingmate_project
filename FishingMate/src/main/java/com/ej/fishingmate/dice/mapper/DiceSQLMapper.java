package com.ej.fishingmate.dice.mapper;

import org.apache.ibatis.annotations.Param;

import com.ej.fishingmate.vo.DiceGameVO;

public interface DiceSQLMapper {
	
	//주사위 배팅하기
	public void insertDice(DiceGameVO diceGameVO);
	
	public void calculateMemberLevelValue(@Param("value") int value , @Param("member_no") int member_no);
	
	public void increaseJackPot(int value);
	//내 경험치
	public int getMyLevelValue(int member_no);
	//잭팟 머니
	public int getCurrentJackpotMoney();
	
	public void initJackpotMoney();
}
