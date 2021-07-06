package com.ej.fishingmate.main.mapper;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.annotations.Param;

import com.ej.fishingmate.vo.MateFreeboardVO;

public interface MainSQLMapper {
	
	//자랑게시판 최신 3개 글 불러오기
	public ArrayList<HashMap<String, Object>> latestSelectShowOffContent();
	
	//메이트게시판 최신 3개 글 불러오기
	public ArrayList<HashMap<String, Object>> latestSelectMateContent();
	
	//게시판 종류별 최신 3개글 불러오기
	public ArrayList<HashMap<String, Object>> latestSelectContent(@Param("freeboard_type") int freeboard_type);
	
	//Q&A 게시판 최신 3개글 불러오기
	public ArrayList<HashMap<String, Object>> selectLatestQnaContent();
	
	//게시판 종류별 이미지 불러오기
	public ArrayList<HashMap<String, Object>> latestSelectContentImage(
			@Param("freeboard_type") int freeboard_type,
			@Param("freeboard_no") int freeboard_no);

}
