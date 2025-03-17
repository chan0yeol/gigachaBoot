package com.giga.gw.repository;

import java.util.List;
import java.util.Map;

import com.giga.gw.dto.RoomDto;

public interface IRoomDao {

	int insertRoom(RoomDto roomDto);
	List<RoomDto> selectAllRooms();
	RoomDto selectRoomById(String room_id);
	int updateRoom(RoomDto roomDto);
	List<RoomDto> selectUseAllRooms();

}
