package com.ej.fishingmate.main.controller;

import java.util.ArrayList;
import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ej.fishingmate.main.service.MainServiceImpl;
import com.ej.fishingmate.showoff.service.ShowOffServicelmpl;
import com.ej.fishingmate.vo.ShowOffVO;

@Controller
@RequestMapping("main/*")
@ResponseBody
public class RestMainController {
   @Autowired
   private MainServiceImpl mainService;
   
   //게시판 최신 3개글 가져오기
   @RequestMapping("getLatestThreeContents.do")
   public HashMap<String, Object> getLatestThreeContents(int freeboard_type){
      
      HashMap<String, Object> map = new HashMap<String, Object>();
      
      ArrayList<HashMap<String, Object>> latestContentList = mainService.getLatestThreeContent(freeboard_type);
      
      //1 => 메이트, 2 => 정보, 3 => 자유, 4 => 중고거래, 5 => 자랑 (4.q&a/ 6.이벤트 빼기)
      switch (freeboard_type) {
      case 1:
         map.put("contextRoute", "mate/mateReadContentPage.do?mate_freeboard_no=");
         map.put("pageRoute", "mate/matePage.do");
         map.put("freeboardName", "메이트 게시판");
         map.put("titleColor", "#8691c0  ");
         break;
           
      case 2:
         map.put("contextRoute", "infofreeboard/readinfofreeboard.do?info_freeboard_no=");
         map.put("pageRoute", "infofreeboard/infofreeboard.do");
         map.put("freeboardName", "정보 게시판");
         map.put("titleColor", "#106612 ");
         break;
         
      case 3:
         map.put("contextRoute", "review/reviewReadContentPage.do?review_freeboard_no=");
         map.put("pageRoute", "review/reviewPage.do");
         map.put("freeboardName", "자유 게시판");
         map.put("titleColor", "#800000");
         break;
      
      case 4:
         map.put("contextRoute", "trade/readProductPage.do?trade_freeboard_no=");
         map.put("pageRoute", "trade/tradePage.do");
         map.put("freeboardName", "중고거래 게시판");
         map.put("titleColor", "#b95A87");
         break;
      
      case 0:
         map.put("contextRoute", "boast/showOffreadContentPage.do?freeboard_no=");
         map.put("pageRoute", "main/boast.do");
         map.put("freeboardName", "자랑 게시판");
         map.put("titleColor", "#32438e");
         break;
      /*   
      case 4:   
         map.put("contextRoute", "qna/password.do?qna_freeboard_no=");
         map.put("pageRoute", "qna/QnaListPage.do");
         map.put("freeboardName", "Q&A 게시판");
         break;
            
      case 6:
         map.put("contextRoute", "event/readNewsPage.do?event_freeboard_no=");
         map.put("pageRoute", "event/eventPage.do");
         map.put("freeboardName", "이벤트 게시판");
         break;
            
      default:
         break;
         */
      }
      
      
      map.put("latestContentList", latestContentList);
      
      return map;
   }

}