package com.ej.fishingmate.fishshare.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("fishingshare/*")
public class FishingShareController {
	
	@RequestMapping("fishingshare.do")
	public String fishingshare() {
		return "fishingshare/fishingshare";
	}
}
