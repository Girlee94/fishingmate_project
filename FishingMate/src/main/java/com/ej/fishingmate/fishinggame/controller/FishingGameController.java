package com.ej.fishingmate.fishinggame.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.ej.fishingmate.fishinggame.service.FishingGameSerivceImpl;
import com.ej.fishingmate.vo.MemberVO;

@Controller
@RequestMapping("/fishingGame/*")
public class FishingGameController {
	
	@Autowired
	private FishingGameSerivceImpl fishingGameSerivce;

	//---------------------------- 낚시터 입장 관련 - 형준 -------------------------------
	@RequestMapping("fishingGame.do")
	public String fishingGame() {
		
		return "fishingGame/fishingGame";
	}
	
	//낚시터 퇴장 시 참여자 현황에서 회원 제거 - 형준
	@RequestMapping("deleteMemberProcess.do")
	public String deleteMemberProcess(HttpSession session) {
		
		MemberVO memberVO = (MemberVO)session.getAttribute("sessionUser");
		
		fishingGameSerivce.deleteMemberFromFishingGame(memberVO.getMember_no());
		
		return "redirect:../main/index.do";
	}
	
	//------------------------------ 낚시터 입장 관련 끝 ---------------------------------
}
