package com.ej.fishingmate.trade.controller;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;

import com.ej.fishingmate.trade.service.TradeServiceImpl;
import com.ej.fishingmate.vo.ItemCategoryVO;
import com.ej.fishingmate.vo.MemberVO;
import com.ej.fishingmate.vo.TradeCommentVO;
import com.ej.fishingmate.vo.TradeImageVO;
import com.ej.fishingmate.vo.TradeListVO;
import com.ej.fishingmate.vo.TradeVO;


@Controller
@RequestMapping("/trade/*")
public class TradeController {
	
	@Autowired
	private TradeServiceImpl tradeService;
	
	@RequestMapping("tradePage.do")
	private String tradePage(Model model){
		
		ArrayList<HashMap<String, Object>> tradeList = tradeService.getTradeList();
		ArrayList<ItemCategoryVO> itemCategoryList = tradeService.getItemList();
		
		model.addAttribute("tradeList",tradeList);	
		model.addAttribute("itemCategoryList", itemCategoryList);
		model.addAttribute("num",5);
		
		return "trade/tradePage";
	}
	
	@RequestMapping("productRegistration.do")
	public String productRegistration(Model model) {
		
		ArrayList<ItemCategoryVO> itemCategoryList = tradeService.getItemList();
		
		model.addAttribute("num",5);
		model.addAttribute("itemCategoryList", itemCategoryList);
		
		return "trade/productRegistration";
	}
	
	@RequestMapping("writeContentProcess.do")
	public String writeContentProcess(MultipartFile [] upload_files, TradeVO tradeVO, HttpSession session ) {
		
		ArrayList<TradeImageVO> tradeImageVOList = new ArrayList<TradeImageVO>();
		
		if(upload_files != null) {
			for(MultipartFile upload_file : upload_files) {
				
				if(upload_file.isEmpty()) {
					continue;
				}
				
				// 사진 이름 바꿔 저장
				String oriFileName = upload_file.getOriginalFilename();
				
				long cuttentTime= System.currentTimeMillis();
				UUID uuid = UUID.randomUUID();
				String uuidName= uuid.toString();
				String ext=oriFileName.substring(oriFileName.lastIndexOf("."));
				
				String randomFileName= uuidName+"_"+cuttentTime+ext;
				
				//날짜 별 폴더 자동생성
				Date date= new Date();
				SimpleDateFormat sdf= new SimpleDateFormat("yyyy/MM/dd");
				String newfolderName = sdf.format(date);
				
				String uploadFolderName = "C:/upload_files/"+newfolderName;
				
				File folder = new File(uploadFolderName);
				if(!folder.exists()) {
					folder.mkdirs();
				}
				
				String freeboardFileImageFileLocation =uploadFolderName+"/"+randomFileName;
				
				try {
					upload_file.transferTo(new File(freeboardFileImageFileLocation));
				}catch (Exception e) {
					e.printStackTrace();
				}
				
				TradeImageVO tradeImageVO=new TradeImageVO();
				
				
				tradeImageVO.setImage_location(newfolderName+"/"+randomFileName);
				tradeImageVO.setImage_original_filename(oriFileName);
				
				tradeImageVOList.add(tradeImageVO);				
				
			}
		}
		
		MemberVO sessionUser = (MemberVO)session.getAttribute("sessionUser");
		
		int sessionNo = sessionUser.getMember_no();
		tradeVO.setMember_no(sessionNo);
		
		tradeService.writeContent(tradeVO, tradeImageVOList);
		
		return "redirect:./tradePage.do";
	}
	
	@RequestMapping("readProductPage.do")
	public String readProductPage(Model model, int trade_freeboard_no, HttpSession session ) {
		
		HashMap<String, Object> tradeVO = tradeService.getContent(trade_freeboard_no, true);

		MemberVO sessionUser = (MemberVO)session.getAttribute("sessionUser"); 

		int completePurchaseCount =tradeService.completePurchaseCount(trade_freeboard_no);
		
		model.addAttribute("completePurchaseCount", completePurchaseCount);
		model.addAttribute("tradeVO", tradeVO);
		model.addAttribute("num",5);

		return "trade/readProductPage";
		
		
	}
	
	//댓글
//	@RequestMapping("writeComment.do")
//	public String writeComment(TradeCommentVO tradeCommentVO, HttpSession session) {
//		
//		MemberVO memberVO = (MemberVO)session.getAttribute("sessionUser");
//		int member_no = memberVO.getMember_no();
//		
//		tradeCommentVO.setMember_no(member_no);
//		tradeService.writeComment(tradeCommentVO);
//		
//		int trade_freeboard_no=tradeCommentVO.getTrade_freeboard_no();
//		
//		return "redirect:./readProductPage.do?trade_freeboard_no="+trade_freeboard_no;
//		
//	}
	
	//게시판 삭제
	@RequestMapping("contentDelete.do")
	public String contentDelete(int trade_freeboard_no) {
		
		tradeService.deleteTradeContent(trade_freeboard_no);
		return "redirect:./tradePage.do";
	}
	
		
		

	}
