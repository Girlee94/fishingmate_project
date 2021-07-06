package com.ej.fishingmate.infofreeboard.controller;

import java.lang.reflect.Array;
import java.lang.reflect.Member;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ej.fishingmate.infofreeboard.service.InfoFreeboardServiceImpl;
import com.ej.fishingmate.member.service.MemberServiceImpl;
import com.ej.fishingmate.vo.InfoFreeboardCommentVO;
import com.ej.fishingmate.vo.InfoFreeboardVO;
import com.ej.fishingmate.vo.LevelvalueHistoryVO;
import com.ej.fishingmate.vo.LottoServerVO;
import com.ej.fishingmate.vo.LottoUserVO;
import com.ej.fishingmate.vo.MemberVO;

@Controller
@RequestMapping("/infofreeboard/*")
@ResponseBody
public class RestInfoFreeboardController {

   
   @Autowired
   private InfoFreeboardServiceImpl infofreeboardService;
   @Autowired
   private MemberServiceImpl memberService;
   //댓글쓰기
   @RequestMapping("infoWriteComment.do")
   public void infoWriteComment(HttpSession session, InfoFreeboardCommentVO infoFreeboardCommentVO) {
      
      MemberVO memberVO = (MemberVO)session.getAttribute("sessionUser");
      
      infoFreeboardCommentVO.setMember_no(memberVO.getMember_no());
      
      
      infofreeboardService.writeinfoComment(infoFreeboardCommentVO);
      
   }
   //댓글불러오기
   @RequestMapping("getInfoCommentData.do")
   public HashMap<String, Object>getInfoCommentData(int info_freeboard_no){
      HashMap<String, Object>map = new HashMap<String, Object>();
      
      int commentCount=infofreeboardService.getCommentCountByNo(info_freeboard_no);
      ArrayList<HashMap<String, Object>>infoCommentList=infofreeboardService.getinfoCommentBynO(info_freeboard_no);
      
      map.put("infoCommentList", infoCommentList);
      map.put("commentCount", commentCount);
      
      
      return map;
      
   }
   //데ㅐㅅ글삭제
   @RequestMapping("infoDeleteComment.do")
   public void infoDeleteComment(int info_comment_no) {
      
      infofreeboardService.deleteinfoCommentByFno(info_comment_no);
      
      
   }
   //댓글수정
   @RequestMapping("infoUpdateCommentProcess.do")
   public void infoUpdateComment(InfoFreeboardCommentVO infoFreeboardCommentVO) {
      
      infofreeboardService.modifyinfoCommentByMnoAndCno(infoFreeboardCommentVO);
   }
   //댓글 한개 불러오기
   @RequestMapping("getInfoOneCommentData.do")
   public HashMap<String, Object>getInfoOneCommentData(int info_comment_no){
      
   return infofreeboardService.getOneInfofreeboardComment(info_comment_no);
      
   }
   //추천 시작
   @RequestMapping("doRecommend.do")
   public void doRecommend(int info_freeboard_no, HttpSession session) {
      MemberVO memberVO = (MemberVO) session.getAttribute("sessionUser");
      infofreeboardService.doRecommendCount(info_freeboard_no, memberVO.getMember_no());
   }
   @RequestMapping("getRecommendData.do")
   public HashMap<String, Object>getRecommendData(int info_freeboard_no , HttpSession session){
      HashMap<String, Object>map = new HashMap<String, Object>();
      MemberVO memberVO=(MemberVO) session.getAttribute("sessionUser");
      map.put("result", "success");
      
      int recommendCount= infofreeboardService.getRecommendCount(info_freeboard_no);
      map.put("recommendCount", recommendCount);
      
      if(memberVO != null) {
         int checkdoRecommend = infofreeboardService.checkdoRecommend(memberVO.getMember_no(),info_freeboard_no);
         System.out.println(checkdoRecommend);
         map.put("checkdoRecommend",checkdoRecommend );
      }else {
         map.put("checkdoRecommend", 0);
      }
      
      
      
      return map;
   }
   @RequestMapping("lottocheckcount.do")
   public HashMap<String, Object> lottocheckcount(HttpSession session) {
      HashMap<String, Object> result = new HashMap<String, Object>();
      MemberVO memberVO = (MemberVO) session.getAttribute("sessionUser");
      
      int lottocheckcount = memberService.todayfreelottocount(memberVO.getMember_no());
   
      System.out.println(lottocheckcount);
      
      result.put("lottocheckcount", lottocheckcount);
      
      return result;
      
      
   }
   
   
   
   @RequestMapping("doLotto")
   public HashMap<String, Object> doLotto(int [] selectedNumber,HttpSession session){
      HashMap<String, Object> result = new HashMap<String, Object>();

      //로또 번호 생성....
      LevelvalueHistoryVO levelvalueHistoryVO = new LevelvalueHistoryVO(); 
      MemberVO memberVO = (MemberVO) session.getAttribute("sessionUser");
      
      
      ArrayList<Integer> confirmedNumber = new ArrayList<Integer>(); 
      
      while(confirmedNumber.size() < 6) {
         int number = (int)(Math.random()*45) + 1;
         
         if(!confirmedNumber.contains(number)) {
            confirmedNumber.add(number);
         }
      }

      //몇개 맞았는가??....
      int count = 0;
      for(int x : selectedNumber) {
         if(confirmedNumber.contains(x)) {
            count++;
         }   
            
      }
   
         memberService.updatelottolevelvalue(count, memberVO.getMember_levelvalue(), memberVO.getMember_no());
         memberService.updatefreelottohistory(count, memberVO.getMember_no(),levelvalueHistoryVO);
      
      int freelottocount = memberService.todayfreelottocount(memberVO.getMember_no());
      
      result.put("count", count);
      result.put("confirmedNumber", confirmedNumber);
      result.put("memberVO", memberVO);
      result.put("freelottocount", freelottocount);
      
      return result;
   }
   @RequestMapping("getFreeCharging.do")
   public int getFreeCharging(int member_no) {
      
      return infofreeboardService.selectfreeCharging(member_no);
   }
   
   //--로또 하는 회원 정보 가져오기
   @RequestMapping("getlottomemberinfo")
   public MemberVO getlottomemberinfo(MemberVO memberVO, HttpSession session) {
   
      
      MemberVO member=(MemberVO) session.getAttribute("sessionUser");
      if(member != null) {
      
      int member_no = member.getMember_no();
      
      
      return memberService.selectMemberByMno(member_no);
      }else {
         return null;
      }
   }
   @RequestMapping("dobattinglotto.do")
   public void dobattinglotto(HttpSession session, int [] selectedNumber) {

      MemberVO member=(MemberVO) session.getAttribute("sessionUser");
      
      LottoUserVO lottoUserVO = new LottoUserVO();
      if(member != null) {
      
      
      int member_no = member.getMember_no();
      int member_levelvalue = member.getMember_levelvalue();
      
      lottoUserVO.setMember_no(member_no);
      lottoUserVO.setLotto_num1(selectedNumber[0]);
      lottoUserVO.setLotto_num2(selectedNumber[1]);
      lottoUserVO.setLotto_num3(selectedNumber[2]);
      lottoUserVO.setLotto_num4(selectedNumber[3]);
      lottoUserVO.setLotto_num5(selectedNumber[4]);
      lottoUserVO.setLotto_num6(selectedNumber[5]);
      
      
      
    infofreeboardService.buylottowithselectnumber(lottoUserVO , member_levelvalue);      
      }
   }
   @RequestMapping("infomylotto.do")
   public  HashMap<String, Object> infomylotto(HttpSession session , LottoUserVO lottouserVO){
      HashMap<String, Object> result = new HashMap<String, Object>();
      MemberVO memberVO=(MemberVO) session.getAttribute("sessionUser");
      LevelvalueHistoryVO levelvalueHistoryVO = new LevelvalueHistoryVO();
      
      
      
      ArrayList<LottoUserVO> alluserinfo = infofreeboardService.getmylottoinfo(memberVO.getMember_no());
      
      
      result.put("alluserinfo", alluserinfo);
   
   
      
      return result;
   }

   
   @RequestMapping("getRemainningNextTime.do")
   public HashMap<String, Object> getRemainningNextTime(){
      HashMap<String, Object> map = new HashMap<String, Object>(); 
      
      LottoServerVO lottoServerVO = infofreeboardService.getRemainningNextTime();
      
      map.put("remainning", lottoServerVO.getLotto_round_date().getTime() + (1000*60*3));
      map.put("now", System.currentTimeMillis());
      map.put("lottoserverround", lottoServerVO.getLotto_round());
      
      return map;
   }
   //0601
   @RequestMapping("selectconfrimnumber.do")
   public HashMap<String, Object> selectconfrimnumber(){
      HashMap<String, Object> map = new HashMap<String, Object>();
      
      LottoServerVO lottoServerVO = infofreeboardService.selectserverlottonum();
      
      return map;
      
   }
   
   @RequestMapping("lottoroundset.do")
   public int lottoroundeset() {
         
      
     
     return  infofreeboardService.selectlottoround();
         
   }
   
   
}