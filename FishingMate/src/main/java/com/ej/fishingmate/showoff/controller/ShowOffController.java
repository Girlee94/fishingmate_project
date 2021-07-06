package com.ej.fishingmate.showoff.controller;

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

import com.ej.fishingmate.showoff.service.ShowOffServicelmpl;
import com.ej.fishingmate.vo.MemberVO;
import com.ej.fishingmate.vo.ShowOffCommentVO;
import com.ej.fishingmate.vo.ShowOffFishVO;
import com.ej.fishingmate.vo.ShowOffImageVO;
import com.ej.fishingmate.vo.ShowOffVO;

@Controller
@RequestMapping("boast/*")
public class ShowOffController {
	@Autowired
	private ShowOffServicelmpl showoffservicelmpl;
	// 자랑게시판 쓰기페이지 이동 - 명화
	
	
	@RequestMapping("showOffWritePage.do")
	public String boastWritePage(Model model){
		
		ArrayList<ShowOffFishVO> FishCategoryList= showoffservicelmpl.getFishList();
		model.addAttribute("FishCategoryList",FishCategoryList);
		model.addAttribute("num",2);
		
		return "boast/showOffWritePage";
	}
	// 자랑게시판 보기페이지 이동 - 명화
	@RequestMapping("showOffreadContentPage.do")
	public String boastreadContentPage(Model model, int freeboard_no, HttpSession session){
		MemberVO sessionUser =(MemberVO) session.getAttribute("sessionUser");
		if (sessionUser != null) {
			int memberno = sessionUser.getMember_no();
			int myRecommendCount = showoffservicelmpl.getMyRecommendCount(freeboard_no, memberno);
			model.addAttribute("myRecommendCount", myRecommendCount);
		}
		
		int commentCount = showoffservicelmpl.getCommentCountByNo(freeboard_no);
		int recommendCount = showoffservicelmpl.getRecommendCount(freeboard_no);
		
		model.addAttribute("recommendCount", recommendCount);
		
		showoffservicelmpl.increaseReadCount(freeboard_no);
		
		HashMap<String,Object> showoffVO = showoffservicelmpl.getContent(freeboard_no, true);
		
		
		 ArrayList<HashMap<String, Object>> showoffCommentList =
		 showoffservicelmpl.getContenCommentByNo(freeboard_no);
		 
		
		model.addAttribute("showoffVO", showoffVO);
		model.addAttribute("showoffCommentList", showoffCommentList);
		model.addAttribute("commentCount", commentCount);
		model.addAttribute("num",2);
		
		return "boast/showOffreadContentPage";
	}
	// 자랑게시판 글쓰기 - 명화
	@RequestMapping("writeshowOffProcess.do")
	public String writeshowOffProcess(MultipartFile [] upload_files, ShowOffVO ShowOffVO, HttpSession session) {
		double totalScore;
		int Score = showoffservicelmpl.getScore(ShowOffVO.getFish_no());
		int FishTotal= showoffservicelmpl.selectTotalFish();
		int FishCount=showoffservicelmpl.selectFish(ShowOffVO.getFish_no());
		double aaa = (double)FishCount/FishTotal;
		if(aaa > 0 && aaa != 1) {
			totalScore= Score*(1-(aaa))*ShowOffVO.getShowoff_freeboard_fishlength();
		}else {
			totalScore = Score*(1)*ShowOffVO.getShowoff_freeboard_fishlength();}
		ArrayList<ShowOffImageVO> showOffImageVOList=
				new ArrayList<ShowOffImageVO>();
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
				
				ShowOffImageVO showoffImageVO=new ShowOffImageVO();
				
				
				showoffImageVO.setImage_location(newfolderName+"/"+randomFileName);
				showoffImageVO.setImage_original_filename(oriFileName);
				
				showOffImageVOList.add(showoffImageVO);				
				
			}
		}
				MemberVO sessionUser = (MemberVO)session.getAttribute("sessionUser");
		
				int sessionNo = sessionUser.getMember_no();

				ShowOffVO.setMember_no(sessionNo);
				ShowOffVO.setShowoff_freeboard_levelvalue(totalScore);

				showoffservicelmpl.showoffwriteContent(ShowOffVO, showOffImageVOList);

		
		return "redirect:/main/boast.do";
	}

	// 자랑게시판 삭제 - 명화
	@RequestMapping("deleteContentProcess.do")
	public String deleteContentProcess(ShowOffVO showoffVO) {
		double deletTotalScore= showoffservicelmpl.selectlevel(showoffVO);
		showoffservicelmpl.deleteContent(showoffVO, deletTotalScore);
		showoffservicelmpl.deleteContentImage(showoffVO.getShowoff_freeboard_no());
	
	return "redirect:/main/boast.do";
		 }
	// 자랑게시판 수정페이지 이동 - 명화
	@RequestMapping("updateContentPage.do")
	public String updateContentPage(Model model , int freeboard_no) {
		showoffservicelmpl.deleteContentImage(freeboard_no);
		HashMap<String, Object> map = showoffservicelmpl.getContent(freeboard_no,false);
		ArrayList<ShowOffFishVO> FishCategoryList= showoffservicelmpl.getFishList();
		
		model.addAttribute("FishCategoryList",FishCategoryList);
		model.addAttribute("data", map);
		model.addAttribute("num",2);
		
		return "boast/showOffUpDateContentPage";
	}
	// 자랑게시판 수정 - 명화
	@RequestMapping("updateContentProcess.do")
	public String updateContentProcess(ShowOffVO showoffVO,MultipartFile [] upload_files,int fish,double fishlength) {
		double totalScore;
		double deletTotalScore= showoffservicelmpl.selectlevel(showoffVO);
		int Score = showoffservicelmpl.getScore(showoffVO.getFish_no());
		int FishTotal= showoffservicelmpl.selectTotalFish();
		int FishCount=showoffservicelmpl.selectFish(showoffVO.getFish_no());
		double aaa = (double)FishCount/FishTotal;
		if(aaa > 0 && aaa !=1) {
			totalScore= Score*(1-(aaa))*showoffVO.getShowoff_freeboard_fishlength();
		}else {
			totalScore = Score*(1)*showoffVO.getShowoff_freeboard_fishlength();
		}
		ArrayList<ShowOffImageVO> showoffVOImageVOList =
				new ArrayList<ShowOffImageVO>();
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
				
				String showoffFileImageFileLocation =uploadFolderName+"/"+randomFileName;
				
				try {
					upload_file.transferTo(new File(showoffFileImageFileLocation));
				}catch (Exception e) {
					e.printStackTrace();
				}
				
				ShowOffImageVO showoffImageVO=new ShowOffImageVO();
				
				
				showoffImageVO.setImage_location(newfolderName+"/"+randomFileName);
				showoffImageVO.setImage_original_filename(oriFileName);
				
				showoffVOImageVOList.add(showoffImageVO);
				
			}
		}
		showoffVO.setShowoff_freeboard_levelvalue(totalScore);
		showoffservicelmpl.updateContent(showoffVO,showoffVOImageVOList,totalScore,deletTotalScore);
		return "redirect:./showOffreadContentPage.do?freeboard_no=" + showoffVO.getShowoff_freeboard_no();
	}
	// 추천 올리기 - 명화
	@RequestMapping("recommendProcess.do")
	public String recommendProcess(HttpSession session , int freeboard_no) {
		
		MemberVO sessionUser = (MemberVO)session.getAttribute("sessionUser");
		int member_no = sessionUser.getMember_no();
		
		showoffservicelmpl.recommend(freeboard_no, member_no);

		return "redirect:./showOffreadContentPage.do?freeboard_no=" + freeboard_no;
	}
	//댓글 쓰기 - 명화
	@RequestMapping("writeComment.do")
	   public String writeComment(ShowOffCommentVO commentVO) {
	      
	      
		showoffservicelmpl.writeComment(commentVO);
	      int freeboardNo=commentVO.getShowoff_freeboard_no();
	      
	      return "redirect:./showOffreadContentPage.do?freeboard_no=" + freeboardNo;
	   }
	//댓글 삭제 - 명화
	@RequestMapping("deleteCommentProcess.do")
    public String deleteCommentProcess(ShowOffCommentVO commentVO){
    
	    int freeboardNo = commentVO.getShowoff_freeboard_no();
	    
	    showoffservicelmpl.deleteCommentByMno(freeboardNo);
	    
	    return "redirect:./showOffreadContentPage.do?freeboard_no=" + freeboardNo;
	 }
}
