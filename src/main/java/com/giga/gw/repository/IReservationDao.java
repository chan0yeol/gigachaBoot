package com.giga.gw.repository;

import java.util.List;
import java.util.Map;

import com.giga.gw.dto.ReservationDto;

public interface IReservationDao {
	
	int insertreservation (ReservationDto reservationDto); //예약 생성
	ReservationDto selectReservationByRoomId(String room_id); //내 예약 조회
	ReservationDto selectReserverAndMember(String reservation_id); //예약자와 참여자 조회
	int delReservation(String reservation_id, String reserver); //예약 삭제(예약자 본인 예약내역만 삭제)
	List<ReservationDto> selectrooms (String date);
	List<ReservationDto> reservationList ();
	
	
}
