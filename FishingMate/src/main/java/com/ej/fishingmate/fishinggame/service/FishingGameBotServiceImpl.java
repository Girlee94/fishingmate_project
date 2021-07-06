package com.ej.fishingmate.fishinggame.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;

import com.ej.fishingmate.fishinggame.mapper.FishingGameSQLMapper;

@Service
@EnableScheduling
public class FishingGameBotServiceImpl {

	@Autowired
	private FishingGameSQLMapper fishingGameSQLMapper;
	
	
	//스케쥴은 파라미터를 받지 못함	
	@Scheduled(cron = "0/10 * * * * *")
	public void FishingGameBotTime() {
		
	}

}
