package com.giga.gw.service;

import com.giga.gw.dto.ReservationDto;
import com.giga.gw.repository.IReservationDao;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class ReservationServiceImpl implements IReservationService {
	
	private final IReservationDao reservationDao;

	@Override
	public int insertreservation(ReservationDto reservationDto) {
		return reservationDao.insertreservation(reservationDto);
	}

	@Override
	public ReservationDto selectReservationByRoomId(String room_id) {
		return reservationDao.selectReservationByRoomId(room_id);
	}
	
	@Override
	public List<ReservationDto> getReservationList(String empno) {
		return reservationDao.getReservationList(empno);
	}

	@Override
	public ReservationDto selectReserverAndMember(String reservation_id) {
		return reservationDao.selectReserverAndMember(reservation_id);
	}

	@Override
	public int delReservation(String reservation_id, String reserver) {
		return reservationDao.delReservation(reservation_id, reserver);
	}

	@Override
	public List<ReservationDto> reservationList() {
		return reservationDao.reservationList();
	}
	
}
