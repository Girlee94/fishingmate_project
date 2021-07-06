package com.ej.fishingmate.manager.controller;

import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ej.fishingmate.event.service.EventServiceImpl;
import com.ej.fishingmate.manager.mapper.ManagerSQLMapper;
import com.ej.fishingmate.manager.service.ManagerServiceImpl;
import com.ej.fishingmate.vo.EventVO;
import com.ej.fishingmate.vo.ManagerVO;

@Controller
@ResponseBody
@RequestMapping("/manager/*")
public class RestManagerController {

	@Autowired
	private ManagerServiceImpl managerService;
	@Autowired
	private EventServiceImpl eventService;
	
	//매니저 no 불러오기 - 주빈
	@RequestMapping("getSessionManagerNo.do")
	public HashMap<String, Object> getSessionManagerNo(HttpSession session){
		HashMap<String, Object> map = new HashMap<String, Object>();
		ManagerVO managerVO = (ManagerVO)session.getAttribute("sessionAdmin");
		
		if(managerVO != null) {
			map.put("manager_no", managerVO.getManager_no());
		}
		
		return map;
	}
	
	//이벤트 게시판 승인-주빈
	@RequestMapping("adminApprove.do")
	public void adminApprove(@RequestParam(defaultValue="0") int event_freeboard_no, EventVO eventVO, HttpSession session) {
		ManagerVO managerVO = (ManagerVO)session.getAttribute("sessionAdmin");
		/*
		if(managerVO != null && eventVO.getEvent_freeboard_approve().equals("N")) {
			managerService.updateApproveY(event_freeboard_no);
		}
		*/
		if(managerVO != null) {
			managerService.updateApproveY(event_freeboard_no);
		}
	}
	
	//이벤트 게시판 승인 취소-주빈
	@RequestMapping("adminDerecog.do")
	public void adminDerecog(@RequestParam(defaultValue="0") int event_freeboard_no, EventVO eventVO, HttpSession session) {
		ManagerVO managerVO = (ManagerVO)session.getAttribute("sessionAdmin");
		/*
		if(managerVO != null && eventVO.getEvent_freeboard_approve().equals("Y")) {
			managerService.updateApproveN(event_freeboard_no);
		}
		*/
		if(managerVO != null) {
			managerService.updateApproveN(event_freeboard_no);
		}

	}
	
	@RequestMapping("getAdminApprove.do")
	public HashMap<String, Object> getAdminApprove(@RequestParam(defaultValue="0") int event_freeboard_no){
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		String AdminApp = managerService.getAdminApprove(event_freeboard_no);
		
		map.put("AdminApp", AdminApp);
		
		return map;
		
	}
	
}
