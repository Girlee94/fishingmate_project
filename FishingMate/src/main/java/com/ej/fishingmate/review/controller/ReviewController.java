package com.ej.fishingmate.review.controller;

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

import com.ej.fishingmate.review.service.ReviewServiceImpl;
import com.ej.fishingmate.vo.MemberVO;
import com.ej.fishingmate.vo.ReviewCommentVO;
import com.ej.fishingmate.vo.ReviewImageVO;
import com.ej.fishingmate.vo.ReviewVO;

@Controller
@RequestMapping("review/*")
public class ReviewController {
	
	@Autowired
	private ReviewServiceImpl reviewService;
	
	//리뷰 게시판 시작 ----------------- 정진
	//리뷰 게시판 이동 - 정진	
	@RequestMapping("reviewPage.do")
	public String reviewPage(Model model) {
		
		ArrayList<HashMap<String, Object>> reviewList =
				reviewService.getReviewList();
		
		int count = reviewService.getReviewContentCount();
		
		model.addAttribute("contentCount", count);
		model.addAttribute("reviewList", reviewList);
		model.addAttribute("num",4);
		
		return "review/reviewPage";
	}
		
	@RequestMapping("reviewWriteContentPage.do")
	public String reviewWriteContentPage(Model model) {
		model.addAttribute("num",4);
		
		return "review/reviewWriteContentPage";
	}
	
	//게시판 쓰기
	@RequestMapping("reviewWriteContentProcess.do")
	public String reviewWriteContentProcess(MultipartFile [] upload_files ,ReviewVO reviewVO , HttpSession session) {
		
		ArrayList<ReviewImageVO> reviewImageVOList =
				new ArrayList<ReviewImageVO>();
		
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
				
				ReviewImageVO reviewImageVO = new ReviewImageVO();
							
				reviewImageVO.setImage_location(newfolderName+"/"+randomFileName);
				reviewImageVO.setImage_original_filename(oriFileName);
				
				reviewImageVOList.add(reviewImageVO);
			}
		}
		
		
		
		MemberVO sessionUser = (MemberVO)session.getAttribute("sessionUser");
		
		int sessionNo = sessionUser.getMember_no();
		
		reviewVO.setMember_no(sessionNo);
		
		reviewService.reviewWriteContent(reviewVO , reviewImageVOList);				
		
		return "redirect:./reviewPage.do";
	}
	
	//게시판 읽기
	@RequestMapping("reviewReadContentPage.do")
	public String reviewReadContentPage(Model model , int review_freeboard_no) {
		
		//조회수
		reviewService.reviewIncreaseReadCount(review_freeboard_no);
		
		HashMap<String, Object> map = reviewService.getReviewContent(review_freeboard_no, true);
		
		//댓글 갯수
		int commentCount = reviewService.getReviewCommentCountByNo(review_freeboard_no);
		
		//댓글달기
		ArrayList<HashMap<String, Object>> reviewCommentList = reviewService.getReviewCommentList(review_freeboard_no);

		model.addAttribute("commentCount", commentCount);
		model.addAttribute("data", map);
		model.addAttribute("reviewCommentList", reviewCommentList);
		model.addAttribute("num",4);
		
		
		return "review/reviewReadContentPage";
	}
	//게시글 수정 페이지로
	@RequestMapping("reviewUpdateContentPage.do")
	public String reviewUpdateContentPage(Model model , int review_freeboard_no) {
		HashMap<String, Object> map = reviewService.getReviewContent(review_freeboard_no, false);
		model.addAttribute("data", map);
		model.addAttribute("num",4);
		
		return "review/reviewUpdateContentPage";
	}
	//게시글 수정하기
	@RequestMapping("reviewUpdateContentProcess.do")
	public String reviewUpdateContentProcess(ReviewVO reviewVO) {
		
		reviewService.reviewUpdateContent(reviewVO);
		
		return "redirect:./reviewReadContentPage.do?review_freeboard_no="+reviewVO.getReview_freeboard_no();
	}
	
	//게시판 글 지우기	
	@RequestMapping("reviewDeleteContentProcess.do")
	public String reviewDeleteContentProcess(int review_freeboard_no) {
		//게시글 삭제
		reviewService.reviewDeleteContent(review_freeboard_no);
		//게시글 이미지 삭제
		reviewService.deleteContentImage(review_freeboard_no);
		
		return "redirect:./reviewPage.do";
	} 
	
	
	//댓글 삽입
	@RequestMapping("reviewWriteCommentProcess.do")
	public String reviewWriteCommentProcess(ReviewCommentVO reviewCommentVO) {
		
		
		reviewService.reviewInsertComment(reviewCommentVO);
		int review_freeboard_no = reviewCommentVO.getReview_freeboard_no();
		
		return "redirect:./reviewReadContentPage.do?review_freeboard_no="+review_freeboard_no;
	}
	
	//댓글 지우기	
//	 @RequestMapping("reviewDeleteCommentProcess.do") public String
//	 reviewDeleteCommentProcess(int review_comment_no , int review_freeboard_no) {
//	  
//	 reviewService.reviewDeleteCommentByNo(review_comment_no);
//	  
//	  
//	 return "redirect:./reviewReadContentPage.do?review_freeboard_no="+ review_freeboard_no; }
	 
	
	//댓글 수정하기	
//	@RequestMapping("reviewModifyCommentProcess.do")
//	public String reviewModifyCommentProcess(ReviewCommentVO reviewCommentVO) {
//		
//		reviewService.reviewModifyCommentByMnoAndCno(reviewCommentVO);
//		
//		return "redirect:./reviewReadContentPage.do?review_freeboard_no=" + reviewCommentVO.getReview_freeboard_no();
//	}
	
	//댓글 수정 페이지 이동
	@RequestMapping("reviewModifyCommentPage.do")
	public String reviewModifyCommentPage(Model model , int member_no , int review_comment_no) {
		
		ReviewCommentVO reviewCommentVO = reviewService.getReviewCommentByMnoAndCno(member_no, review_comment_no);
		
		model.addAttribute("reviewCommentVO", reviewCommentVO);
		model.addAttribute("num",4);
		
		return "review/reviewModifyCommentPage";
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	

}
