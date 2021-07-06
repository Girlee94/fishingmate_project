package com.ej.fishingmate.main.service;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ej.fishingmate.main.mapper.MainSQLMapper;
import com.ej.fishingmate.mate.mapper.MateImageSQLMapper;
import com.ej.fishingmate.mate.mapper.MateSQLMapper;
import com.ej.fishingmate.showoff.mapper.ShowOffSQLMapper;
import com.ej.fishingmate.vo.MateFreeboardImageVO;
import com.ej.fishingmate.vo.MateFreeboardVO;
import com.ej.fishingmate.vo.ShowOffImageVO;
import com.ej.fishingmate.vo.ShowOffVO;

@Service
public class MainServiceImpl {
	
	@Autowired
	private MainSQLMapper mainSQLMapper;
	
	@Autowired
	private ShowOffSQLMapper showOffSQLMapper;
	
	@Autowired
	private MateImageSQLMapper mateImageSQLMapper;
	
	//Q&A 게시판 최신 3개글 불러오기
	public ArrayList<HashMap<String, Object>> getLatestQnaContent(){
		
		return mainSQLMapper.selectLatestQnaContent();
	}
	
	//게시판 종류별 최신 3개글 불러오기
	public ArrayList<HashMap<String, Object>> getLatestThreeContent(int freeboard_type){
		ArrayList<HashMap<String, Object>> result = new ArrayList<HashMap<String, Object>>();
		
		ArrayList<HashMap<String, Object>> list = mainSQLMapper.latestSelectContent(freeboard_type);
		
		for(HashMap<String, Object> latestFreeboardVO : list) {
			HashMap<String, Object> map = new HashMap<String, Object>();
			
			int freeboard_no = ((BigDecimal)latestFreeboardVO.get("FREEBOARD_NO")).intValue();
			
			ArrayList<HashMap<String, Object>> contentImageVO = mainSQLMapper.latestSelectContentImage(freeboard_type, freeboard_no);
			if (contentImageVO != null) {
				map.put("contentImageVO", contentImageVO);
			}
			
			map.put("latestFreeboardVO", latestFreeboardVO);
			
			result.add(map);
		}
		
		return result;
	}

}
