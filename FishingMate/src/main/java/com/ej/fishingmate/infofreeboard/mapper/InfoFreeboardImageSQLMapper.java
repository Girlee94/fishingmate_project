package com.ej.fishingmate.infofreeboard.mapper;

import java.util.ArrayList;

import com.ej.fishingmate.vo.InfoFreeboardImageVO;
import com.ej.fishingmate.vo.InfoFreeboardVO;

public interface InfoFreeboardImageSQLMapper {

	 public void insert(InfoFreeboardImageVO infoFreeboardImageVO);

	public ArrayList<InfoFreeboardImageVO> selectByinfoFreeboardNo(int info_freeboard_no);

	public void updateContentImage(InfoFreeboardImageVO infofreeboardImageVO);

	public void deleteContentImage(int image_no);

}
