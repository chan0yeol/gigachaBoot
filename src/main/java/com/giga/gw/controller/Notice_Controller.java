package com.giga.gw.controller;

import com.giga.gw.dto.NoticeDto;
import com.giga.gw.repository.INoticeDao;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@Controller
@RequiredArgsConstructor
@Slf4j
@RequestMapping("/notice")
public class Notice_Controller {
	
	private final INoticeDao noticedao;
	
	
	@GetMapping("/notice.do")
	public String notice() {
		return "notice";
	}
	
	// 공지사항 리스트
	@GetMapping("/boardList.do")
	@ResponseBody
	public List<NoticeDto> boardList() {
		log.info("Notice_Controller boardList GET 요청");
		return noticedao.getBoardList();
	}

}
