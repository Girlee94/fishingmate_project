package com.ej.fishingmate.trade.mapper;

import java.util.ArrayList;

import com.ej.fishingmate.vo.TradeImageVO;

public interface TradeImageSQLMapper {
	
	public void insert(TradeImageVO tradeImageVO);
	public ArrayList<TradeImageVO> selectByFreeboardNo(int trade_freeboard_no);

}
