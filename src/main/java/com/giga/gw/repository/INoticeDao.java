package com.giga.gw.repository;

import com.giga.gw.dto.NoticeDto;

import java.util.List;

public interface INoticeDao {

	// 게시판 조회(게시판리스트)
	public List<NoticeDto> getBoardList();


}
