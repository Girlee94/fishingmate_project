package com.ej.fishingmate.commoncategory.mapper;

import java.util.ArrayList;

import com.ej.fishingmate.vo.FishingCategoryVO;
import com.ej.fishingmate.vo.FreshWaterRegionCategoryVO;
import com.ej.fishingmate.vo.RegionCategoryVO;
import com.ej.fishingmate.vo.SeaRegionCategoryVO;

public interface CommonCategorySQLMapper {
	
	//낚시종류 카테고리 불러오기 - 형준
	public ArrayList<FishingCategoryVO> selectFishingCategory();
	
	//지역(민물) 카테고리 불러오기 - 형준
	public ArrayList<FreshWaterRegionCategoryVO> selectFreshWaterRegionCategory();
	
	//지역(바다) 카테고리 불러오기 - 형준
	public ArrayList<SeaRegionCategoryVO> selectSeaRegionCategory();

	//지역 카테고리 불러오기 - 형준(글쓰기용)
	public ArrayList<RegionCategoryVO> selectRegionCategory(); 

	//한 지역 정보 불러오기 - 형준
	public RegionCategoryVO selectOneRegion(int region_category_no);
	
	//한 낚시종류 정보 불러오기 - 형준
	public FishingCategoryVO selectOneFishing(int fishing_category_no);
}
