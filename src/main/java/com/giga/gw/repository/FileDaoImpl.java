package com.giga.gw.repository;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.giga.gw.dto.FileDto;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class FileDaoImpl implements IFileDao {
	private final SqlSessionTemplate sql;
	private final String NS = "com.giga.gw.repository.FileDaoImpl.";
	
	@Override
	public int insertFile(List<FileDto> list) {
		return sql.insert(NS+"insertFile",list);
	}

	@Override
	public List<FileDto> selectFile(Map<String, Object> map) {
		return sql.selectList(NS+"selectFile", map);
	}

}
