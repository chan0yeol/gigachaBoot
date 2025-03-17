package com.giga.gw.repository;

import java.util.List;
import java.util.Map;

import com.giga.gw.dto.FileDto;

public interface IFileDao {
	int insertFile(List<FileDto> fileDtos);
	List<FileDto> selectFile(Map<String, Object> map);
}
