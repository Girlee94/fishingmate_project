package com.ej.fishingmate.qna.mapper;

import java.util.ArrayList;

import com.ej.fishingmate.vo.QnaImageVO;

public interface QnaImageSQLMapper {
	
	public void insert(QnaImageVO qnaImageVO);
	
	public ArrayList<QnaImageVO> selectByqnaFreeboardNo(int qna_freeboard_no);
	
	public void updateContentImage(QnaImageVO qnaImageVO);
	
	public void deleteContentImage(int image_no);
	
	
	
	
	
}
