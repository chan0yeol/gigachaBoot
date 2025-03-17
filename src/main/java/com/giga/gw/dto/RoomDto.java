package com.giga.gw.dto;

import java.util.Date;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Setter
@Getter
@NoArgsConstructor
@AllArgsConstructor
@ToString
@Builder
public class RoomDto {

	
	private String room_id;
	private String room_name;
	private String open_hours;
	private String close_hours;
	private String image_url;
	private String created_at;
	private String updated_at;
	private String use_yn;
	private int capacity;
	
	public String getRoom_id() {
		return room_id;
	}
	public String getRoom_name() {
		return room_name;
	}
	public int getCapacity() {
		return capacity;
	}
	public String getOpen_hours() {
		return open_hours;
	}
	public String getClose_hours() {
		return close_hours;
	}
	public String getImage_url() {
		return image_url;
	}
	public String getCreated_at() {
		return created_at;
	}
	public String getUpdated_at() {
		return updated_at;
	}
	public String getUse_yn() {
		return use_yn;
	}
	
	
	
	
	
}
