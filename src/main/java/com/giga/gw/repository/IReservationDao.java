package com.giga.gw.repository;

import com.giga.gw.dto.ReservationDto;

import java.util.List;

public interface IReservationDao {
	
	int insertreservation (ReservationDto reservationDto); //예약 생성
	ReservationDto selectReservationByRoomId(String room_id); //내 예약 조회
	List<ReservationDto> getReservationList(String empno); //로그인한 사용자의 예약 목록 조회
	ReservationDto selectReserverAndMember(String reservation_id); //예약자와 참여자 조회
	int delReservation(String reservation_id, String reserver); //예약 삭제(예약자 본인 예약내역만 삭제)
	List<ReservationDto> selectrooms (String date);
	List<ReservationDto> reservationList ();
	
	
}
