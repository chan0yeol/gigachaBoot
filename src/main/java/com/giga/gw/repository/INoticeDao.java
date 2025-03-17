package com.giga.gw.repository;

import java.util.List;

import com.giga.gw.dto.NoticeDto;

public interface INoticeDao {
	
	// 게시글 작성 - 권한 확인
	// 게시글 작성 - 임시저장
	 
	// 임시저장 조회 - 리스트
	// 임시저장 조회 - 상세
	// 게시글 작성 - 임시저장->등록
	public int saveToInsert(NoticeDto dto);
	// 게시글 작성 - 등록
	public int insertPost(NoticeDto dto);
	// 게시물 작성 - 첨부파일 등록
	// 게시글 수정
	public int updatePost(NoticeDto dto);
	// 게시글 수정 - 첨부파일 등록
	// 게시글 수정 - 첨부파일 삭제
	// 게시물 중요 등록
	public int updateImportant(String seq);
	// 게시글 삭제
	public int deletePost(List<String>seq);
	// 게시판 조회(게시판리스트)
	public List<NoticeDto> getBoardList();
	// 게시글 조회 - 상세조회
	public NoticeDto getOneBoard(String seq);
	// 게시글 조회 -조회수 업데이트
	

}
