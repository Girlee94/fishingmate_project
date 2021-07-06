package com.ej.fishingmate.mate.mapper;

import java.util.ArrayList;

import com.ej.fishingmate.vo.MateFreeboardImageVO;

public interface MateImageSQLMapper {

	//메이트 게시판 글쓰기-사진 올리기 - 형준
	public void insertMateFreeboardImage(MateFreeboardImageVO mateFreeboardImageVO);
	
	//메이트 게시판 사진 불러오기 - 형준
	public ArrayList<MateFreeboardImageVO> selectMateFreeboardImage(int mate_freeboard_no);
	
	//메이트 게시판 사진 한장 불러오기 - 형준
	public MateFreeboardImageVO selectMateFreeboardOneImage(int mate_freeboard_no);
	
	//메이트 게시판 사진 삭제 - 형준
	public void deleteMateFreeboardImage(int mate_freeboard_no);
	
	
}
