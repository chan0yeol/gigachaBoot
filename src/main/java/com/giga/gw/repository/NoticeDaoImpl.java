package com.giga.gw.repository;

import com.giga.gw.dto.NoticeDto;
import lombok.RequiredArgsConstructor;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
@RequiredArgsConstructor
public class NoticeDaoImpl implements INoticeDao {
	
	private final SqlSessionTemplate session;
	private final String NS = "com.giga.gw.repository.NoticeDaoImpl.";

	@Override
	public List<NoticeDto> getBoardList() {
		return session.selectList(NS+"getBoardList");
	}

}
