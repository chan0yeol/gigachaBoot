package com.giga.gw.dto;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@ToString
@Builder
public class ReservationDto {

	private String reservation_id;
	private String room_id;
	private String room_name;
	private String reservation_date;
	private String reservation_time;
	private String reserver;
	private String member;
	private String purpose;
	private String capacity;
}
