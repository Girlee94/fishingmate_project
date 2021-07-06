package com.ej.fishingmate.fishshare.controller;

import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ej.fishingmate.fishinggame.service.FishingGameSerivceImpl;
import com.ej.fishingmate.fishshare.service.FishingShareServicelmpl;
import com.ej.fishingmate.showoff.service.ShowOffServicelmpl;
import com.ej.fishingmate.vo.FishCatchRateVO;
import com.ej.fishingmate.vo.FishShareLogVO;
import com.ej.fishingmate.vo.FishShareStorageVO;
import com.ej.fishingmate.vo.MemberVO;
import com.ej.fishingmate.vo.ShowOffFishVO;

@Controller
@RequestMapping("fishingShare/*")
@ResponseBody
public class RestFishingShareController {
	@Autowired
	private FishingShareServicelmpl fishingShareServicelmpl;
	@Autowired
	private FishingGameSerivceImpl fishingGameSerivce;
	@Autowired
	private ShowOffServicelmpl showoffservicelmpl;
//어종별 잡힌 회수 불러오기 - 명화
	@RequestMapping("getShareCatchRatio.do")
	public HashMap<String, Object> getShareCatchRatio(int aaaa , boolean isGetAll){
		HashMap<String, Object> map = new HashMap<String, Object>();
		
		String today = null;
		Date date = new Date();
		SimpleDateFormat sdformat = new SimpleDateFormat("MM/dd/yyyy HH:mm"); 
		Calendar cal = Calendar.getInstance();
		cal.setTime(date);
		
		if(isGetAll) {
		
			ArrayList<ArrayList<Object>> bbb = new ArrayList<ArrayList<Object>>();
			
			for (int i = 10; i > 0; i--) {
				cal.setTime(date);
				cal.add(Calendar.MINUTE, -i);
				today = sdformat.format(cal.getTime());  
				ArrayList<HashMap<String, Object>> shareCatchRatio = fishingShareServicelmpl.getFishCatchCount3(i, isGetAll);
				
				ArrayList<Object> ggg = new ArrayList<Object>();
				ggg.add(today);
				for(HashMap<String, Object> ccc : shareCatchRatio) {
					
					double a = ((BigDecimal)ccc.get("CATCH_COUNT")).doubleValue();
					
					ggg.add(a);
			
				}
				
				bbb.add(ggg);
			}
			map.put("bbb", bbb);
		}else {
			today = sdformat.format(cal.getTime());
			
			ArrayList<ArrayList<Object>> bbb = new ArrayList<ArrayList<Object>>();
			
			ArrayList<HashMap<String, Object>> shareCatchRatio = fishingShareServicelmpl.getFishCatchCount3(0, isGetAll);
			
			ArrayList<Object> ggg = new ArrayList<Object>();
			
			ggg.add(today);
			for(HashMap<String, Object> ccc : shareCatchRatio) {
				
				double a = ((BigDecimal)ccc.get("CATCH_COUNT")).doubleValue();
				ggg.add(a);
				
			}			
			bbb.add(ggg);
			map.put("bbb", bbb);
		}
		//map.put("shareCatchRatio", shareCatchRatio);
//		map.put("aaa", aaa);
				
		return map;
	}
// 어종 카테고리 불러오기 - 명화
	@RequestMapping("FishCategoryList.do")
	public ArrayList<ShowOffFishVO> fishCatagory(){
		ArrayList<ShowOffFishVO> FishCategoryList= showoffservicelmpl.getFishList();

		return FishCategoryList;
	}
// 어종 가격 불러오기 - 명화
	@RequestMapping("getFishprice.do")
	public double buyshare(int fish_no){
		int FishTotal= fishingGameSerivce.getTotalFish();
		int FishCount=fishingGameSerivce.getFish(fish_no);
		double countTotal= ((double)FishTotal/FishCount);
		return Math.round(countTotal*100)/10;
	}
// 로그인한 정보 가져오기 - 명화
	@RequestMapping("getMyLevelValue.do")
	public MemberVO getMyLevelValue(int member_no) {
		return fishingShareServicelmpl.memberSelectByNo(member_no);
	}
// 구매하기 - 명화
	@RequestMapping("insertByeFishShare.do")
	public void insertByeFishShare(FishShareStorageVO fishShareStorageVO) {
		int check=fishingShareServicelmpl.checkFishShare(fishShareStorageVO);
		// 물고기 구매 로그 삽입 - 명화
		 FishShareLogVO fishShareLogVO = new FishShareLogVO();
		 fishShareLogVO.setFish_no(fishShareStorageVO.getFish_no());
		 fishShareLogVO.setFishshare_category_no(1);
		 fishShareLogVO.setFishshare_log_value(fishShareStorageVO.
		 getFishshare_storage_value());
		 fishShareLogVO.setFishshare_quantity(fishShareStorageVO.
		 getFishshare_storage_quantity());
		 fishShareLogVO.setMember_no(fishShareStorageVO.getMember_no());
		 fishingShareServicelmpl.insertFishLog(fishShareLogVO);
		 //구매 로그삽입 끝 -명화
		if(check!=0) {
			fishingShareServicelmpl.updatefishshare(fishShareStorageVO);
		fishingShareServicelmpl.decreasefishshare(fishShareStorageVO);
		}
		else {
			fishingShareServicelmpl.byefishshare(fishShareStorageVO);
			fishingShareServicelmpl.decreasefishshare(fishShareStorageVO);
		}
	}
// 판매하기 - 명화
	@RequestMapping("saleFishShare.do")
	public void saleFishShare(FishShareStorageVO fishShareStorageVO) {
		// 물고기 판매 로그 삽입 - 명화
		 FishShareLogVO fishShareLogVO = new FishShareLogVO();
		 fishShareLogVO.setFish_no(fishShareStorageVO.getFish_no());
		 fishShareLogVO.setFishshare_category_no(2);
		 fishShareLogVO.setFishshare_log_value(fishShareStorageVO.
		 getFishshare_storage_value());
		 fishShareLogVO.setFishshare_quantity(fishShareStorageVO.
		 getFishshare_storage_quantity());
		 fishShareLogVO.setMember_no(fishShareStorageVO.getMember_no());
		 fishingShareServicelmpl.insertFishLog(fishShareLogVO);
		// 구매 판매삽입 끝 -명화
		fishingShareServicelmpl.salefishshare(fishShareStorageVO);
		fishingShareServicelmpl.addfishshare(fishShareStorageVO);
	}
// 물고기 보유 현황 - 명화
	@RequestMapping("selectFishShare.do")
	public ArrayList<HashMap<String, Object>> selectFishShare(int member_no){
		return fishingShareServicelmpl.selectfishcount(member_no);
	}
// 물고기 보유 정보 가져오기 - 명화
	@RequestMapping("checkFish.do")
	public Integer checkFish(FishShareStorageVO fishShareStorageVO) {
		if(fishingShareServicelmpl.checkFish(fishShareStorageVO)==null) {
			return 0;
		}else {
		return fishingShareServicelmpl.checkFish(fishShareStorageVO);
		}
	}
// 물고기 테이블 삭제 - 명화
	@RequestMapping("deleteSale.do")
	public void deleteSale(FishShareStorageVO fishShareStorageVO) {
	// 물고기 판매 로그 삽입 - 명화
		FishShareLogVO fishShareLogVO = new FishShareLogVO();
		fishShareLogVO.setFish_no(fishShareStorageVO.getFish_no());
		fishShareLogVO.setFishshare_category_no(2);
		fishShareLogVO.setFishshare_log_value(fishShareStorageVO.
		getFishshare_storage_value());
		fishShareLogVO.setFishshare_quantity(fishShareStorageVO.
		getFishshare_storage_quantity());
		fishShareLogVO.setMember_no(fishShareStorageVO.getMember_no());
		fishingShareServicelmpl.insertFishLog(fishShareLogVO);
	// 구매 판매삽입 끝 -명화
		fishingShareServicelmpl.deleteFish(fishShareStorageVO);
		fishingShareServicelmpl.addfishshare(fishShareStorageVO);
	}
// 주식 로그 불러오기 - 명화
	@RequestMapping("getFishShareLogList.do")
	public ArrayList<HashMap<String, Object>> getFishingGameLog(@RequestParam(defaultValue = "0") int member_no, 
			@RequestParam(defaultValue = "0") int log_no){
	return fishingShareServicelmpl.getFishShareLogList(member_no, log_no);
	}
}