package com.giga.gw.repository;

import java.util.List;
import java.util.Map;

import org.apache.commons.collections4.map.HashedMap;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.giga.gw.dto.ReservationDto;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class ReservationDaoImpl implements IReservationDao{
	
	private final SqlSessionTemplate sessionTemplate;
	private final String NS = "com.giga.gw.repository.ReservationDaoImpl.";
	
	@Override
	public int insertreservation(ReservationDto reservationDto) {
		return sessionTemplate.insert(NS+"insertreservation", reservationDto);
	}
	
	@Override
	public ReservationDto selectReservationByRoomId(String room_id) {
		return sessionTemplate.selectOne(NS+"selectReservationByRoomId",room_id);
	}

	@Override
	public ReservationDto selectReserverAndMember(String reservation_id) {
		return sessionTemplate.selectOne(NS+"selectReserverAndMember", reservation_id);
	}

	@Override
	public int delReservation(String reservation_id, String reserver) {
		Map<String, Object> params = new HashedMap<>();
		params.put("reservation_id", reservation_id);
		params.put("reserver", reserver);
		
		return sessionTemplate.delete("delReservation", params);
	}

	@Override
	public List<ReservationDto> selectrooms(String date) {
		return sessionTemplate.selectList(NS+"selectrooms",date);
	}

	@Override
	public List<ReservationDto> reservationList() {
		return sessionTemplate.selectList(NS+"reservationList");
	}	

}
