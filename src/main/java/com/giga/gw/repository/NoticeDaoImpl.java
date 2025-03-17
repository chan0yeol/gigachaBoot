package com.giga.gw.repository;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.giga.gw.dto.NoticeDto;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class NoticeDaoImpl implements INoticeDao {
	
	private final SqlSessionTemplate session;
	private final String NS = "com.giga.gw.repository.NoticeDaoImpl.";
	@Override
	public int saveToInsert(NoticeDto dto) {
		// TODO Auto-generated method stub
		return 0;
	}
	@Override
	public int insertPost(NoticeDto dto) {
		// TODO Auto-generated method stub
		return 0;
	}
	@Override
	public int updatePost(NoticeDto dto) {
		// TODO Auto-generated method stub
		return 0;
	}
	@Override
	public int updateImportant(String seq) {
		// TODO Auto-generated method stub
		return 0;
	}
	@Override
	public int deletePost(List<String> seq) {
		// TODO Auto-generated method stub
		return 0;
	}
	@Override
	public List<NoticeDto> getBoardList() {
		// TODO Auto-generated method stub
		return null;
	}
	@Override
	public NoticeDto getOneBoard(String seq) {
		// TODO Auto-generated method stub
		return null;
	}
	
	
	
	

}
