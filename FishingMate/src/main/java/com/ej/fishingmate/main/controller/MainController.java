package com.ej.fishingmate.main.controller;

import java.util.ArrayList;
import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.ej.fishingmate.main.service.MainServiceImpl;
import com.ej.fishingmate.showoff.service.ShowOffServicelmpl;

@Controller
@RequestMapping("main/*")
public class MainController {

	@Autowired
	private ShowOffServicelmpl showoffservicelmpl;
	
	@Autowired
	private MainServiceImpl mainService;
	
	//메인 페이지 이동 - 형준
	@RequestMapping("index.do")
	public String index(Model model) {
		
		ArrayList<HashMap<String, Object>> latestQnaContentList = mainService.getLatestQnaContent();
		
		model.addAttribute("latestQnaContentList", latestQnaContentList);
		
		return "main/index";
	}
	
	// 자랑게시판 목록 이동- 명화
		@RequestMapping("boast.do")
		public String boast(Model model) {
			ArrayList<HashMap<String, Object>> showoffList = showoffservicelmpl.getshowoffList();
			ArrayList<HashMap<String, Object>> toplist= showoffservicelmpl.getTopList();
			model.addAttribute("showoffList", showoffList);
			model.addAttribute("toplist",toplist);
			model.addAttribute("num",2);
			return"boast/showOff";
		}
	
}
