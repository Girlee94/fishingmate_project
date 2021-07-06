package com.ej.fishingmate.qna.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.ej.fishingmate.vo.QnaCommentVO;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
//import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.UUID;
import javax.servlet.http.HttpSession;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.stereotype.Controller;
//import org.springframework.ui.Model;

import com.ej.fishingmate.qna.service.QnaServiceImpl;
import com.ej.fishingmate.member.service.MemberServiceImpl;
import com.ej.fishingmate.vo.QnaCommentVO;
import com.ej.fishingmate.vo.QnaImageVO;
import com.ej.fishingmate.vo.QnaVO;
import com.ej.fishingmate.vo.QnaCategoryVO;
import com.ej.fishingmate.vo.InfoFreeboardCommentVO;
import com.ej.fishingmate.vo.ManagerVO;
import com.ej.fishingmate.vo.MemberVO;

@Controller
@RequestMapping("qna/*")
public class QnaController {
   
   @Autowired
   private QnaServiceImpl qnaservice;
   

   @RequestMapping("QnaListPage.do")
   public String qnalistpage(Model model ,String qna_category_no) {
      
      ArrayList<QnaCategoryVO> categoryList = qnaservice.getQnaCategoryList();
      ArrayList<HashMap<String, Object>> result = qnaservice.getallContent(qna_category_no);
      
      model.addAttribute("categoryList" , categoryList);
      model.addAttribute("qnafreeboardList", result);
      
      
      model.addAttribute("qna_category_no", qna_category_no);
      
      return "qna/QnaListPage";
   }
   
   

   
   
   @RequestMapping("QnaWritePage.do")
   public String QnaWritePage(Model model) {
   
      ArrayList<QnaCategoryVO> CategoryList = qnaservice.getQnaCategoryList();
      
      model.addAttribute("CategoryList", CategoryList);
      
      return "qna/QnaWritePage";            
   }

   
   
   
   
   @RequestMapping("password.do")
   public String password(int qna_freeboard_no, Model model) {
      
   HashMap<String, Object> map = qnaservice.getQnaContent(qna_freeboard_no);
   QnaVO qnaVO = (QnaVO)map.get("QnaVO");
   
   model.addAttribute("qnaVO", qnaVO);
      
   return "qna/password";
   }
   
   
   @RequestMapping("passwordprocess.do")
   public String passwordprocess(QnaVO qnaVO, String input_password, Model model) {
      
      String qna_freeboard_pw = qnaVO.getQna_freeboard_pw();
      int qna_freeboard_no = qnaVO.getQna_freeboard_no();
      
//      System.out.println(qna_freeboard_pw + " " + qna_freeboard_no);
//      System.out.println("----------------------");
//      System.out.println(input_password);

      if(input_password.equals(qna_freeboard_pw)) {
         return "redirect:../qna/QnaContentPage.do?qna_freeboard_no=" + qna_freeboard_no;
      } else {
    	  model.addAttribute("qna_freeboard_no", qna_freeboard_no);
         return "qna/passwordfail";
      }
   }

    
   @RequestMapping("passwordfail.do")
   public String passwordfail() {
      
      return "qna/passwordfail.do";
   }
   
   
   
   

   @RequestMapping("QnaContentPage.do")
   public String qnaContentPage(Model model, int qna_freeboard_no, HttpSession session) {
      
      
      MemberVO sessionUser =(MemberVO) session.getAttribute("sessionUser");
      if (sessionUser != null) {
         int member_no = sessionUser.getMember_no();
       }
      
      int commentCount = qnaservice.getCommentCountByNo(qna_freeboard_no);

      qnaservice.increaseReadCount(qna_freeboard_no);
      HashMap<String,Object> qnaVO = qnaservice.getQnaContent(qna_freeboard_no);
      
      //   ------------   댓글 리스트
      ArrayList<HashMap<String, Object>> qnaCommentList = qnaservice.getCommentList(qna_freeboard_no);
      
      
      model.addAttribute("qnaCommentList", qnaCommentList);
      model.addAttribute("QnaVO", qnaVO);
      model.addAttribute("commentCount", commentCount);
      
      return "qna/QnaContentPage";
   }
   
   

   
   @RequestMapping("writeContentProcess")
   public String writeContentProcess(MultipartFile [] upload_files, QnaVO qnaVO, HttpSession session){
   
      ArrayList<QnaImageVO> qnaImageVOList = 
            new ArrayList<QnaImageVO>();
      
      if(upload_files != null) {
         for(MultipartFile upload_file : upload_files) {
            
            if(upload_file.isEmpty()) {
               continue;
            }
   
            String oriFileName = upload_file.getOriginalFilename();
            
            long cuttentTime= System.currentTimeMillis();
            UUID uuid = UUID.randomUUID();
            String uuidName= uuid.toString();
            String ext=oriFileName.substring(oriFileName.lastIndexOf("."));
            
            String randomFileName= uuidName+"_"+cuttentTime+ext;
            

            Date date= new Date();
            SimpleDateFormat sdf= new SimpleDateFormat("yyyy/MM/dd");
            String newfolderName = sdf.format(date);
            
            String uploadFolderName = "C:/upload_files/"+newfolderName;
            
            File folder = new File(uploadFolderName);
            if(!folder.exists()) {
               folder.mkdirs();
            }
            
            String qnaFileImageFileLocation =uploadFolderName+"/"+randomFileName;
            
            try {
               upload_file.transferTo(new File(qnaFileImageFileLocation));
            }catch (Exception e) {
               e.printStackTrace();
            }
            
            QnaImageVO qnaImageVO=new QnaImageVO();

            qnaImageVO.setImage_location(newfolderName+"/"+randomFileName);
            qnaImageVO.setImage_original_filename(oriFileName);
            qnaImageVOList.add(qnaImageVO);            
            
         }
      }
            MemberVO sessionUser = (MemberVO)session.getAttribute("sessionUser");
            int sessionNo = sessionUser.getMember_no();
            qnaVO.setMember_no(sessionNo);
      

            qnaservice.writeContent(qnaVO, qnaImageVOList);
            
   return "redirect:./QnaListPage.do";
   }
   
   
   //   ------------   게시글 수정 페이지   
   @RequestMapping("updateContentPage.do")
   public String updateContentPage(Model model , int qna_freeboard_no) {

      HashMap<String, Object> map = qnaservice.getQnaContent(qna_freeboard_no);
      model.addAttribute("data", map);
      
      return "qna/updateContentPage";
   }
   
   //   ------------   게시글 수정
   @RequestMapping("updateContentProcess.do")
   public String updateContentProcess(QnaVO qnaVO,MultipartFile [] upload_files) {
      
    ArrayList<QnaImageVO> qnaImageVOList =
            new ArrayList<QnaImageVO>();
      
      if(upload_files != null) {
         for(MultipartFile upload_file : upload_files) {
            
            if(upload_file.isEmpty()) {
               continue;
            }

            String oriFileName = upload_file.getOriginalFilename();
            
            long cuttentTime= System.currentTimeMillis();
            UUID uuid = UUID.randomUUID();
            String uuidName= uuid.toString();
            String ext=oriFileName.substring(oriFileName.lastIndexOf("."));

            String randomFileName= uuidName+"_"+cuttentTime+ext;

            Date date= new Date();
            SimpleDateFormat sdf= new SimpleDateFormat("yyyy/MM/dd");
            String newfolderName = sdf.format(date);
            
            String uploadFolderName = "C:/upload_files/"+newfolderName;
            
            File folder = new File(uploadFolderName);
            if(!folder.exists()) {
               folder.mkdirs();
            }
            
            String qnaFileImageFileLocation =uploadFolderName+"/"+randomFileName;
            
            try {
               upload_file.transferTo(new File(qnaFileImageFileLocation));
            }catch (Exception e) {
               e.printStackTrace();
            }
            
            QnaImageVO qnaImageVO=new QnaImageVO();
            
            qnaImageVO.setImage_location(newfolderName+"/"+randomFileName);
            qnaImageVO.setImage_original_filename(oriFileName);
            
            qnaImageVOList.add(qnaImageVO);            
         }
      }
      qnaservice.updateContent(qnaVO,qnaImageVOList);
    
      return "redirect:./QnaContentPage.do?qna_freeboard_no=" + qnaVO.getQna_freeboard_no();
   }
   
   
   
   
   @RequestMapping("deleteContentProcess.do")
   public String deleteContentProcess(int qna_freeboard_no) {
   qnaservice.deleteContent(qna_freeboard_no);
   
   qnaservice.deleteContentImage(qna_freeboard_no);
   return "redirect:./QnaListPage.do";
       }
   
   

   
   @RequestMapping("writeComment.do")
      public String writeComment(QnaCommentVO qnacommentVO , HttpSession session) {
         
         
      MemberVO memberVo = (MemberVO)session.getAttribute("sessionUser");
      ManagerVO managerVO = (ManagerVO)session.getAttribute("sessionAdmin");
      
      System.out.println("aaa " + memberVo);
      
      if(memberVo != null) {
         qnacommentVO.setMember_no(memberVo.getMember_no());
      }
      
      if(managerVO != null) {
         qnacommentVO.setManager_no(managerVO.getManager_no());
      }
      
         qnaservice.writeComment(qnacommentVO);
         int qnafreeboardNo=qnacommentVO.getQna_freeboard_no();
         
         return "redirect:./QnaContentPage.do?qna_freeboard_no="+qnafreeboardNo;
      }
   

   @RequestMapping("modifyCommentPage.do")
   public String modifyCommentPage(Model model , int member_no, int qna_comment_no) {
      
      QnaCommentVO qnaCommentVO = qnaservice.getContentCommentBynO(member_no, qna_comment_no);
      
      model.addAttribute("QnaCommentVO",qnaCommentVO);
      return "qna/modifyCommentPage";
   }
   
   
   
   
   @RequestMapping("modifyCommentProcess.do")
   public String modifyCommentProcess(QnaCommentVO qnaCommentVO, ManagerVO managerVO) {
      
      
      System.out.println(qnaCommentVO.getQna_freeboard_no());
      qnaservice.modifyCommentByMnoAndCno(qnaCommentVO);
      
      return "redirect:./QnaContentPage.do?qna_freeboard_no=" + qnaCommentVO.getQna_freeboard_no();
   }
   
   
   @RequestMapping("deleteCommentProcess.do")
    public String deleteCommentProcess(QnaCommentVO qnacommentVO){
    
       int qnafreeboardNo = qnacommentVO.getQna_freeboard_no();
       
       qnaservice.deleteCommentByMno(qnacommentVO);
       
       return "redirect:./QnaContentPage.do?qna_freeboard_no=" + qnafreeboardNo;
    }
   
   
}