package com.giga.gw.service;

import com.giga.gw.dto.NoticeDto;
import com.giga.gw.repository.INoticeDao;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@Slf4j
@RequiredArgsConstructor
public class NoticeServiceImpl implements INoticeService {
	
	private final INoticeDao noticeDao;

	@Override
	public List<NoticeDto> getBoardList() {
		return noticeDao.getBoardList();
	}

}
