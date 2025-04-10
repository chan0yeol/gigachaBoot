package com.giga.gw.service;

import com.giga.gw.dto.NoticeDto;

import java.util.List;

public interface INoticeService {
	
	// 게시판 조회(게시판리스트)
		public List<NoticeDto> getBoardList();

}
