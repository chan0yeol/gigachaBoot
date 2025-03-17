package com.giga.gw.service;

import java.util.Date;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.giga.gw.dto.RoomDto;
import com.giga.gw.repository.IRoomDao;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
public class RoomServiceImpl implements IRoomService {

	private final IRoomDao roomDao;

	@Override
	public int insertRoom(RoomDto roomDto) {
		return roomDao.insertRoom(roomDto);
	}

	@Override
	public List<RoomDto> selectAllRooms() {
		return roomDao.selectAllRooms();
	}

	@Override
	public RoomDto selectRoomById(String room_id) {
		return roomDao.selectRoomById(room_id);
	}

	@Override
	public int updateRoom(RoomDto roomDto) {
		return roomDao.updateRoom(roomDto);
	}

	@Override
	public List<RoomDto> selectUseAllRooms() {
		return roomDao.selectUseAllRooms();
	}


	

}
