package com.ej.fishingmate.mate.controller;

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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.ej.fishingmate.mate.service.MateServiceImpl;
import com.ej.fishingmate.vo.FishingCategoryVO;
import com.ej.fishingmate.vo.MateCategoryVO;
import com.ej.fishingmate.vo.MateEvaluateVO;
import com.ej.fishingmate.vo.MateFreeboardImageVO;
import com.ej.fishingmate.vo.MateFreeboardVO;
import com.ej.fishingmate.vo.MemberVO;

@Controller
@RequestMapping("mate/*")
public class MateController {
	
	@Autowired
	private MateServiceImpl mateService;
	
	//메이트 게시판 이동 - 형준
	@RequestMapping("matePage.do")
	public String matePage(Model model, @RequestParam(defaultValue = "0") int fishing_category_no) {
		
		//낚시종류 카테고리 불러오기 - 형준
		ArrayList<FishingCategoryVO> fishingList = mateService.getFishingCategory();
		model.addAttribute("fishingList", fishingList);
		
		//낚시 종류에 따른 지역 카테고리 불러오기(민물&바다) - 형준
		if (fishing_category_no != 0) {
			HashMap<String, Object> regionCategoryList = mateService.getRegionCategory(fishing_category_no);
			model.addAttribute("regionCategoryList", regionCategoryList);
		}
		
		//메이트 게시판 카테고리 불러오기 - 형준
		ArrayList<MateCategoryVO> mateCategoryList = mateService.getAllMateCategory();
		model.addAttribute("mateCategoryList", mateCategoryList);
		
		//메이트 게시판 글목록 불러오기 - 형준
		//ArrayList<HashMap<String, Object>> mateAllContentList = mateService.getMateAllContent();
		//int mateAllContentCount = mateService.getMateAllContentCount();
		//model.addAttribute("mateAllContentList", mateAllContentList);
		//model.addAttribute("mateAllContentCount", mateAllContentCount);
		
		model.addAttribute("num",3);
		
		return "mate/matePage";
	}
	
	//메이트 게시판 글쓰기 페이지 이동 - 형준
	@RequestMapping("mateWriteContentPage.do")
	public String mateWriteContentPage(Model model) {
		
		HashMap<String, Object> commonCategoryList = mateService.getCommonCategory();
		
		
		model.addAttribute("commonCategoryList", commonCategoryList);
		model.addAttribute("num",3);
		
		return "mate/mateWriteContentPage";
	}
	
	//메이트 게시판 글쓰기 - 형준
	@RequestMapping("mateWriteContentProcess.do")
	public String mateWriteContentProcess(MultipartFile [] upload_files, MateFreeboardVO mateFreeboardVO, HttpSession session) {
		
		ArrayList<MateFreeboardImageVO> freeboardImageVOList =
				new ArrayList<MateFreeboardImageVO>();
		
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
				
				String randomFileName= uuidName + "_" + cuttentTime+ext;
				
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
				
				MateFreeboardImageVO freeboardImageVO=new MateFreeboardImageVO();
				
				
				freeboardImageVO.setImage_location(newfolderName+"/"+randomFileName);
				freeboardImageVO.setImage_original_filename(oriFileName);
				
				freeboardImageVOList.add(freeboardImageVO);				
				
			}
		}
		
		
		MemberVO memberVO = (MemberVO)session.getAttribute("sessionUser");
		mateFreeboardVO.setMember_no(memberVO.getMember_no());
		
		mateService.writeMateFreeboardContent(mateFreeboardVO, freeboardImageVOList);
		
		return "redirect:./matePage.do";
	}
	
	//메이트 게시판 글읽기 - 형준
	@RequestMapping("mateReadContentPage.do")
	public String mateReadContentPage(Model model, int mate_freeboard_no, HttpSession session) {
		
		mateService.increaseMateReadCount(mate_freeboard_no);
		
		//회원 추천 여부 확인 - 형준
		MemberVO sessionUser = (MemberVO)session.getAttribute("sessionUser");
		if (sessionUser != null) {
			int chkDoRecommend = mateService.chkDoRecommend(sessionUser.getMember_no(), mate_freeboard_no);
			model.addAttribute("chkDoRecommend", chkDoRecommend);
		}
		
		//게시글 신청 버튼 부분 처리 - 형준
		if (sessionUser != null) {
			int chkApplyGroup = mateService.chkApplyMateGroup(sessionUser.getMember_no(), mate_freeboard_no);
			model.addAttribute("chkApplyGroup", chkApplyGroup);
		}
		
		HashMap<String, Object> oneMateContent = null;
		if (sessionUser != null) {
			oneMateContent = mateService.getOneMateContent(sessionUser.getMember_no(), mate_freeboard_no, true);
		} else {
			oneMateContent = mateService.getOneMateContent(0, mate_freeboard_no, true);
		}
		
		
		ArrayList<HashMap<String, Object>> commentList = mateService.getMateAllComentByNo(mate_freeboard_no);
		int recommendCount = mateService.getMateFreeboardRecommendCount(mate_freeboard_no);
		
		model.addAttribute("oneMateContent", oneMateContent);
		model.addAttribute("commentList", commentList);
		model.addAttribute("recommendCount", recommendCount);
		model.addAttribute("num",3);
		
		return "mate/mateReadContentPage";
	}
	
	//메이트 게시판 글 삭제  - 형준
	@RequestMapping("deleteContentProcess.do")
	public String deleteContentProcess(int mate_freeboard_no) {
		mateService.deleteMateContentByNo(mate_freeboard_no);
		
		return "redirect:./matePage.do";
	}
	
	//메이트 게시판 글 수정 페이지 이동 - 형준
	@RequestMapping("mateUpdateContentPage.do")
	public String mateUpdateContentPage(Model model, int mate_freeboard_no, HttpSession session) {
		
		MemberVO memberVO = (MemberVO)session.getAttribute("sessionUser");
		
		HashMap<String, Object> oneMateContent = mateService.getOneMateContent(memberVO.getMember_no(), mate_freeboard_no, false);
		HashMap<String, Object> commonCategoryList = mateService.getCommonCategory();
		
		model.addAttribute("commonCategoryList", commonCategoryList);
		model.addAttribute("oneMateContent", oneMateContent);
		model.addAttribute("num",3);
		
		return "mate/mateUpdateContentPage";
	}
	
	//메이트 게시판 글 수정 - 형준
	@RequestMapping("mateUpdateContentProcess.do")
	public String mateUpdateContentProcess(MateFreeboardVO mateFreeboardVO) {
		
		mateService.updateMateContent(mateFreeboardVO);
		
		return "redirect:./mateReadContentPage.do?mate_freeboard_no=" + mateFreeboardVO.getMate_freeboard_no();
	}
	
	//메이트 게시판 파티장&확정 그룹 페이지 - 형준
	@RequestMapping("mateConfirmGroupPageByLeader.do")
	public String mateConfirmGroupPageByLeader(Model model, int mate_freeboard_no, HttpSession session) {
		
		MemberVO memberVO = (MemberVO)session.getAttribute("sessionUser");
		
		HashMap<String, Object> oneMateContent = mateService.getOneMateContent(memberVO.getMember_no(), mate_freeboard_no, true);
		
		model.addAttribute("oneMateContent", oneMateContent);
		model.addAttribute("num",3);
		
		return "mate/mateConfirmGroupPageByLeader";
	}
	
	//메이트 게시판 모집 취소 시 모집 상태 변경 - 형준
	@RequestMapping("updateMateFreeboardStatusToCancel.do")
	public String updateMateFreeboardStatusToCancel(int mate_freeboard_no) {
		
		mateService.updateMateFreeboardStatusToCanel(mate_freeboard_no);
		
		return "redirect:./mateReadContentPage.do?mate_freeboard_no=" + mate_freeboard_no;
	}
	
	//------------------- 메이트 게시판 모집 완료 시 ---------------------------
	//메이트 게시판 모집상태 변경 - 형준
	@RequestMapping("updateMateFreeboardStatusToComplete.do")
	public String updateMateFreeboardStatusToComplete(int mate_freeboard_no) {
		
		mateService.updateMateFreeboardStatusToComplete(mate_freeboard_no);
		
		return "redirect:./mateReadContentPage.do?mate_freeboard_no=" + mate_freeboard_no;
	}
	
	//메이트 게시판 모집 완료 후 확정 그룹 회원 목록 페이지 - 형준
	@RequestMapping("mateConfirmGroupPage.do")
	public String mateConfirmGroupPage(Model model, int mate_freeboard_no, HttpSession session) {
		
		MemberVO memberVO = (MemberVO)session.getAttribute("sessionUser");
		int member_no = memberVO.getMember_no();
		
		ArrayList<HashMap<String, Object>> mateConfirmGroupList = mateService.getAllMateConfirmGroup(mate_freeboard_no, member_no);
		HashMap<String, Object> oneMateContent = mateService.getOneMateContent(member_no, mate_freeboard_no, true);
		int confirmListCount = mateService.getConfirmGroupCount(mate_freeboard_no);
		
		model.addAttribute("mateConfirmGroupList", mateConfirmGroupList);
		model.addAttribute("oneMateContent", oneMateContent);
		model.addAttribute("confirmListCount", confirmListCount);
		model.addAttribute("num",3);
		
		return "mate/mateConfirmGroupPage";
	}
	
	//메이트 게시판 평가 페이지 이동 - 형준
		@RequestMapping("mateEvaluatePage.do")
		public String mateEvaluatePage(Model model, HttpSession session, MateEvaluateVO mateEvaluateVO) {
			
			MemberVO sessionUser = (MemberVO)session.getAttribute("sessionUser");
			mateEvaluateVO.setFrom_member_no(sessionUser.getMember_no());
			
			model.addAttribute("mateEvaluateVO", mateEvaluateVO);
			model.addAttribute("num",3);
			
			return "mate/mateEvaluatePage";
		}
	
	//------------------- 메이트 게시판 모집 완료 시 끝 -------------------------
	
	
	
	
	
	
	
	
	
	
	
	
}













