package com.ej.fishingmate.showoff.service;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.UUID;

import org.apache.commons.text.StringEscapeUtils;
import org.apache.ibatis.javassist.expr.Instanceof;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.ej.fishingmate.member.mapper.MemberSQLMapper;
import com.ej.fishingmate.showoff.mapper.ShowOffSQLMapper;
import com.ej.fishingmate.vo.MemberVO;
import com.ej.fishingmate.vo.ShowOffCommentVO;
import com.ej.fishingmate.vo.ShowOffFishVO;
import com.ej.fishingmate.vo.ShowOffImageVO;
import com.ej.fishingmate.vo.ShowOffLevelHistoryVO;
import com.ej.fishingmate.vo.ShowOffVO;
import com.ej.fishingmate.vo.TopListVO;

@Service
public class ShowOffServicelmpl {
	@Autowired
	private ShowOffSQLMapper showoffSQLMapper;
	
	@Autowired
	private MemberSQLMapper memberSQLMapper;
	///게시글 삽입 명화
	public void showoffwriteContent(ShowOffVO showoffVO, ArrayList<ShowOffImageVO> ShowOffImageVOList) {
		showoffSQLMapper.levelvalueadd(showoffVO.getShowoff_freeboard_levelvalue(),showoffVO.getMember_no());
		showoffSQLMapper.levelvalueHistory(showoffVO.getMember_no(),showoffVO.getShowoff_freeboard_levelvalue(),100);
		System.out.println(showoffVO.getShowoff_freeboard_fishlength());
		int showoff_freeboard_no =showoffSQLMapper.createFreeboardKey();
		showoffVO.setShowoff_freeboard_no(showoff_freeboard_no);
		showoffSQLMapper.insert(showoffVO);

		for(ShowOffImageVO showoffimageVO: ShowOffImageVOList) {
			showoffimageVO.setShowoff_freeboard_no(showoff_freeboard_no);
			showoffSQLMapper.imageinsert(showoffimageVO);
		}
	}
	//게시글 불러오기 명화
		public HashMap<String, Object> getContent(int freeboard_no, boolean isEscapeHtml) {
			HashMap<String, Object> map = new HashMap<String, Object>();  
			
			ShowOffVO showoffVO = showoffSQLMapper.selectContentByNo(freeboard_no);
			if(isEscapeHtml) {
				String content =showoffVO.getShowoff_freeboard_content();
				content= StringEscapeUtils.escapeHtml4(content);
				content.replaceAll("\n", "<br>");
				
				showoffVO.setShowoff_freeboard_content(content);
			}
			
			int member_no = showoffVO.getMember_no();
			
			ArrayList<ShowOffImageVO>	ShowOffImageVOList=
					showoffSQLMapper.selectByFreeboardNo(freeboard_no);
			String Fishname=showoffSQLMapper.Fishname(freeboard_no);
			MemberVO memberVO= memberSQLMapper.memberSelectByNo(member_no);
			map.put("memberVO", memberVO);
			map.put("showoffVO", showoffVO);
			map.put("showoffImageVOList",ShowOffImageVOList);
			map.put("fishname", Fishname);
			return map;
		}
	// 게시글 리스트 불러오기
		public ArrayList<HashMap<String, Object>> getshowoffList() {
			
			ArrayList<HashMap<String, Object>> result = new ArrayList<HashMap<String,Object>>();
			ArrayList<ShowOffVO> showofflist = showoffSQLMapper.selectAll();
			for(ShowOffVO showoffVO : showofflist) {
				
				HashMap<String, Object> map = new HashMap<String, Object>();
				
				int commentCount=showoffSQLMapper.commentCount(showoffVO.getShowoff_freeboard_no());
				int recommedCount = showoffSQLMapper.selectRecommendCountByFreeboardNo(showoffVO.getShowoff_freeboard_no());
				int memberNo = showoffVO.getMember_no();
				int freeboardNo = showoffVO.getShowoff_freeboard_no();
				MemberVO memberVO = memberSQLMapper.memberSelectByNo(memberNo);
				String fishname=showoffSQLMapper.Fishname(freeboardNo);
				ArrayList<ShowOffImageVO> showoffImageVO = showoffSQLMapper.selectByFreeboardNo(freeboardNo);
				
				if (showoffImageVO != null) {
					map.put("showoffImageVO", showoffImageVO);
				}
				map.put("fishname", fishname);
				map.put("commentCount", commentCount);
				map.put("recommedCount", recommedCount);
				map.put("memberVO", memberVO);
				map.put("showoffVO", showoffVO);
				result.add(map);
			}
			
			return result;

		}
		// 게시글 삭제 명화
		public void deleteContent(ShowOffVO showoffVO,double deletTotalScore) {
			showoffSQLMapper.levelvalueHistory(showoffVO.getMember_no(),(-1*deletTotalScore),102);
			showoffSQLMapper.levelvaluesub(deletTotalScore,showoffVO.getMember_no());
			showoffSQLMapper.deleteContent(showoffVO.getShowoff_freeboard_no());
		}
		public double selectlevel(ShowOffVO showOffVO) {
			double result =showoffSQLMapper.selectlevelvalue(showOffVO.getShowoff_freeboard_no());
			return result;
		}
		// 게시글 수정 명화
		public void updateContent(ShowOffVO freeboardVO,ArrayList<ShowOffImageVO> ShowOffImageVOList,double totalScore,double deletTotalScore) {
			showoffSQLMapper.levelvalueHistory(freeboardVO.getMember_no(),freeboardVO.getShowoff_freeboard_levelvalue(),101);
			showoffSQLMapper.levelvaluesub(deletTotalScore,freeboardVO.getMember_no());
			showoffSQLMapper.levelvalueadd(totalScore,freeboardVO.getMember_no());
			showoffSQLMapper.updateContent(freeboardVO);
			for(ShowOffImageVO showoffImageVO: ShowOffImageVOList) {
				showoffImageVO.setShowoff_freeboard_no(freeboardVO.getShowoff_freeboard_no());
				showoffSQLMapper.imageinsert(showoffImageVO);
			}
		}
		// 게시글 이미지 삭제 명화
		public void deleteContentImage(int freeboard_no) {
			showoffSQLMapper.imageDelete(freeboard_no);
			
		}
		// 조회수 올리기 명화
		public void increaseReadCount(int freeboard_no) {
			
			showoffSQLMapper.updateReadCount(freeboard_no);
		}
		// 추천 하기 명화
		public void recommend(int freeboard_no, int member_no) {
			int count =	showoffSQLMapper.selectRecommendCountByFreeboardNoAndMemberNo(freeboard_no, member_no);
			
			if(count > 0) {
				showoffSQLMapper.deleteRecommend(freeboard_no, member_no);
			}else {
				showoffSQLMapper.insertRecommend(freeboard_no, member_no);
			}
			
		}
		// 추천 했나 확인 명화
		public int getMyRecommendCount(int freeboard_no, int member_no) {
			int count = showoffSQLMapper.selectRecommendCountByFreeboardNoAndMemberNo(freeboard_no, member_no);

			return count;
		}
		// 게시판 추천 갯수 명화
		public int getRecommendCount(int freeboard_no) {
			int count = showoffSQLMapper.selectRecommendCountByFreeboardNo(freeboard_no);
			
			return count;
		}
		//댓글 관련 명화
		public int getCommentCountByNo(int freeboard_no) {
			
			return showoffSQLMapper.selectCommentCountByNo(freeboard_no);
		}
		//댓글 쓰기 명화
		public void writeComment(ShowOffCommentVO commentVO) {
			showoffSQLMapper.insertComment(commentVO);
		}
		//댓글 리스트 명화
		public ArrayList<HashMap<String, Object>> getContenCommentByNo(int freeboard_no) {
			
			ArrayList<HashMap<String, Object>> result = new ArrayList<HashMap<String,Object>>();
			ArrayList<ShowOffCommentVO> commentList = showoffSQLMapper.selectContentCommentByNo(freeboard_no);
			
			for(ShowOffCommentVO list : commentList) {
				HashMap<String, Object> map = new HashMap<String, Object>();
				
				MemberVO memberVO = memberSQLMapper.memberSelectByNo(list.getMember_no());
				map.put("showoffCommentVO", list);
				map.put("memberVO", memberVO);
				
				result.add(map);
			}
			
			return result;
			}
		//댓글 삭제 명화
		public void deleteCommentByMno(int comment_no) {
		      
			showoffSQLMapper.deleteComment(comment_no);
		}
		//댓글 수정 명화
		public void updateComment(ShowOffCommentVO commentVO) {
			showoffSQLMapper.updateComment(commentVO);
		}
		//댓글 1개 불러오기 명화
		public HashMap<String, Object> RecallComment(int showoff_comment_no) {
			HashMap<String, Object> map = new HashMap<String, Object>();
			 ShowOffCommentVO showoffcommentVO = showoffSQLMapper.RecallComment(showoff_comment_no);
			  map.put("showoffcommentVO", showoffcommentVO);
			  
			  return map;
		}
		//자랑 게시판 TOP3 명화
		public ArrayList<HashMap<String, Object>> getTopList(){
			
			ArrayList<HashMap<String, Object>> result = new ArrayList<HashMap<String,Object>>();
			ArrayList<TopListVO> freeboardlist = showoffSQLMapper.toplist();
			
			for(TopListVO topListVO : freeboardlist) {
			HashMap<String, Object> map = new HashMap<String, Object>();
			String fishname=showoffSQLMapper.Fishname(topListVO.getShowoff_freeboard_no());
			int commentCount=showoffSQLMapper.commentCount(topListVO.getShowoff_freeboard_no());
			int freeboardNo = topListVO.getShowoff_freeboard_no();
			ArrayList<ShowOffImageVO> ShowOffImageVO = showoffSQLMapper.selectByFreeboardNo(freeboardNo);
			
			if (ShowOffImageVO != null) {
				map.put("showoffimageVO", ShowOffImageVO);
			}
			map.put("fishname", fishname);
			map.put("commentCount", commentCount);
			map.put("showoffimageVO", ShowOffImageVO);
			map.put("topListVO", topListVO);
			result.add(map);
		}
			
			return result;
		}
		// 어종 종류 불러오기 명화
			public ArrayList<ShowOffFishVO> getFishList() {
					
				ArrayList<ShowOffFishVO> list = showoffSQLMapper.selectFishList();
				return list;
				}
		// 어종 점수 불러오기 명화
			public int getScore(int fish_no) {
				int aaa =showoffSQLMapper.selectScore(fish_no);
				return aaa;
		}
		// 어종 총 갯수 불러오기 명화
			public int selectTotalFish() {
				int aaa =showoffSQLMapper.selectTotalFish();
				return aaa;
			}
			public int selectFish(int fish_no) {
				int aaa=showoffSQLMapper.selectFish(fish_no);
				return aaa;
			}
		// 페이징 명화
			public ArrayList<HashMap<String,Object>> getFreeboardList(String search_word , String search_type , int pageNum){
				
				ArrayList<HashMap<String,Object>> result = 
						new ArrayList<HashMap<String,Object>>(); 
				
				ArrayList<ShowOffVO> freeboardlist = 
						showoffSQLMapper.selectFreeboardContent(search_word,search_type , pageNum);
				
				for(ShowOffVO showOffVO : freeboardlist) {
						
					HashMap<String, Object> map = new HashMap<String, Object>();
					ArrayList<ShowOffImageVO> showoffImageVO = showoffSQLMapper.selectByFreeboardNo(showOffVO.getShowoff_freeboard_no());

					int memberNo = showOffVO.getMember_no();
					MemberVO memberVO = memberSQLMapper.selectByNo(memberNo);
					map.put("memberVO", memberVO);
					map.put("showOffVO", showOffVO);
					map.put("showoffImageVO", showoffImageVO);
					result.add(map);
				}
				
				return result;
				
			}
			//페이징2 명화
			public int getContentCount() {
				
				int count = showoffSQLMapper.selectContentCount();
				
				return count;
			}
			
}
