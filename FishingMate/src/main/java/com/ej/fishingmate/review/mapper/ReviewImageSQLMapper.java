package com.ej.fishingmate.review.mapper;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

import com.ej.fishingmate.vo.ReviewImageVO;

public interface ReviewImageSQLMapper {
	
	public void reviewImageInsert(ReviewImageVO reviewImageVO);
	
	public ArrayList<ReviewImageVO> reviewSelectByFreeboardNo(int review_freeboard_no);
	
	public void imageDelete(@Param("review_freeboard_no") int review_freeboard_no);

}
