package com.giga.gw.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.giga.gw.repository.IAttendanceDao;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
public class AttendanceServiceImpl implements IAttendanceService {

	@Autowired
	private IAttendanceDao attendanceDao;
	
	@Override
	public void createTable() {
		log.info("근태테이블 실행 스케줄러 동작");
		attendanceDao.dropSequence();
		attendanceDao.createSequence();
		log.info("시퀀스 초기화 세팅 완료");
		attendanceDao.createattendacetable();
		log.info("테이블 추가 완료");
		log.info("스케줄러 종료");
	}
}
