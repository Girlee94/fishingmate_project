package com.ej.fishingmate.infofreeboard.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;

import com.ej.fishingmate.infofreeboard.mapper.InfoFreeboardImageSQLMapper;
import com.ej.fishingmate.infofreeboard.mapper.InfoFreeboardSQLMapper;
import com.ej.fishingmate.member.mapper.MemberSQLMapper;
import com.ej.fishingmate.vo.LottoServerVO;
import com.ej.fishingmate.vo.LottoUserVO;
import com.ej.fishingmate.vo.LottoVO;

@Service
@EnableScheduling
public class LottoSchedulerImpl {

	@Autowired
	InfoFreeboardSQLMapper infofreeboardSQLMapper;
	@Autowired
	private MemberSQLMapper memberSQLMapper;

	// @Scheduled(cron = "10 * * * * *") //매분 10초
	@Scheduled(cron = "0 0/3 * * * *") // 10초 마다
	// @Scheduled(cron = "0 0 0/3 * * *") //매 0시부터 3시간 마다
	public void doLotto() {
		// ...이 안쪽코드는 3시간에 한번씩 자동으로 돕니다...

		LottoServerVO lottoserverVO = new LottoServerVO();
		LottoUserVO lottouserVO = new LottoUserVO();

		// 기존(현재) 회 차... MAX... 추첨... UPDATE...
		ArrayList<Integer> confirmedNumber = new ArrayList<Integer>();

		System.out.println("작동하는가");

		while (confirmedNumber.size() < 6) {
			int number = (int) (Math.random() * 45) + 1;

			if (!confirmedNumber.contains(number)) {

				confirmedNumber.add(number);
			}
		}
		int rotto_round = infofreeboardSQLMapper.selectCurrentRound();

		lottoserverVO.setLotto_num1(confirmedNumber.get(0));
		lottoserverVO.setLotto_num2(confirmedNumber.get(1));
		lottoserverVO.setLotto_num3(confirmedNumber.get(2));
		lottoserverVO.setLotto_num4(confirmedNumber.get(3));
		lottoserverVO.setLotto_num5(confirmedNumber.get(4));
		lottoserverVO.setLotto_num6(confirmedNumber.get(5));
		lottoserverVO.setLotto_round(rotto_round);

		
		infofreeboardSQLMapper.updatelottoserver(lottoserverVO);

		// 정산....

		ArrayList<LottoUserVO> memberselectnoList = infofreeboardSQLMapper.selectnumberbyroundandmemberno();

	
		for (LottoUserVO lottoUserVO : memberselectnoList) {
			
			

			int count = 0;

			if (confirmedNumber.contains(lottoUserVO.getLotto_num1())) {
				count++;
				//System.out.println(count);
			}
			if (confirmedNumber.contains(lottoUserVO.getLotto_num2())) {
				count++;
				//System.out.println(count);
			}
			if (confirmedNumber.contains(lottoUserVO.getLotto_num3())) {
				count++;
				//System.out.println(count);
			}
			if (confirmedNumber.contains(lottoUserVO.getLotto_num4())) {
				count++;
				//System.out.println(count);
			}
			if (confirmedNumber.contains(lottoUserVO.getLotto_num5())) {
				count++;
				//System.out.println(count);
			}
			if (confirmedNumber.contains(lottoUserVO.getLotto_num6())) {
				count++;
				
				//System.out.println(count);
			}

			//....맞춘 회수... 대비 비용... 
			int member_no = lottoUserVO.getMember_no();
			
			int updatelottolevelvalue = 0;
			if(count == 0) {
				updatelottolevelvalue = 0;
			}				
			else if(count ==1) {
				updatelottolevelvalue = 10000;
			}
			else if (count ==2) {
				updatelottolevelvalue = 50000;
			}
			else if(count ==3) {
				updatelottolevelvalue = 100000;
			}
			else if(count ==4) {
				updatelottolevelvalue = 5000000;
			}
			else if(count ==5) {
				updatelottolevelvalue = 40000000;
				
			}
			else if (count ==6) {
				updatelottolevelvalue = 100000000;
			}			
			
			memberSQLMapper.updatelottolevelvalue(updatelottolevelvalue, member_no);
			memberSQLMapper.updatechargehistory(updatelottolevelvalue, member_no);
			lottoUserVO.setWon_sutza(count); 
			lottoUserVO.setWon(updatelottolevelvalue);		
			
			/*
			System.out.println("[1] " + lottouserVO.getWon_sutza());
			System.out.println("[2] " + lottouserVO.getWon());
			System.out.println("[3] " + lottouserVO.getMember_no());
			System.out.println("[4] " + lottouserVO.getWon_sutza());
			System.out.println("[5] " + lottouserVO.getLotto_no());
			*/
			memberSQLMapper.updatelottouserwon(lottoUserVO);

			
			
			
			
			System.out.println("테스트"+lottoUserVO.getWon());
			System.out.println("테스트"+lottoUserVO.getWon_sutza());
		}

		
		
		//// 다음 회차 insert...
		infofreeboardSQLMapper.insertnextround(lottoserverVO);
		//
		//infofreeboardSQLMapper.battinglottotimer()

	}
}
