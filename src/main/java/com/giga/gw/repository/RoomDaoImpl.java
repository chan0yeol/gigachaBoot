package com.giga.gw.repository;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.giga.gw.dto.RoomDto;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class RoomDaoImpl implements IRoomDao {
	
	private final SqlSessionTemplate sessionTemplate;
	private final String NS = "com.giga.gw.repository.RoomDaoImpl.";

	@Override
	public int insertRoom(RoomDto roomDto) {
		return sessionTemplate.insert(NS+"insertRoom", roomDto);
		
	}

	@Override
	public List<RoomDto> selectAllRooms() {
		return sessionTemplate.selectList(NS+"selectAllRooms");
	}

	@Override
	public RoomDto selectRoomById(String room_id) {
		return sessionTemplate.selectOne(NS+"selectRoomById",room_id);
	}

	@Override
	public int updateRoom(RoomDto roomDto) {
		return sessionTemplate.update(NS+"updateRoom",roomDto);
	}

	@Override
	public List<RoomDto> selectUseAllRooms() {
		return sessionTemplate.selectList(NS+"selectUseAllRooms");
	}



}
