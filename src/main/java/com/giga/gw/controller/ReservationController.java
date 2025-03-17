package com.giga.gw.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;


import jakarta.servlet.http.HttpSession;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.giga.gw.dto.EmployeeDto;
import com.giga.gw.dto.ReservationDto;
import com.giga.gw.dto.RoomDto;
import com.giga.gw.repository.IReservationDao;
import com.giga.gw.service.IReservationService;
import com.giga.gw.service.IRoomService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/rooms")
@RequiredArgsConstructor
@Slf4j
public class ReservationController {

	private final IReservationService reservationService;
	private final IRoomService roomService;
	private final IReservationDao reservationDao;
	
	@GetMapping("/reservation.do")
	public String reservation(Model model , @RequestParam (value = "date", required = false) String date ) {
//		List<String> rooms = List.of("회의실 1","회의실 2","회의실 3","회의실 4");
		List<RoomDto> rooms = roomService.selectUseAllRooms();
		String[] timeSlots = { "08:00-10:00", "10:00-12:00", "13:00-15:00", "15:00-17:00" };
		
		List<ReservationDto> reservation = reservationDao.selectrooms(date);
		model.addAttribute("rooms", rooms);
		model.addAttribute("timeSlots", timeSlots);
		model.addAttribute("date", date);
		model.addAttribute("reservation", reservation);
		return "reservation"; //예약 화면 반환
	}
	
	//예약 설정
	@PostMapping("/api/reservation.do") //예약 데이터 처리
	@ResponseBody
	public ResponseEntity insertreservation(HttpSession session, @RequestBody ReservationDto reservationDto){
		System.out.println(reservationDto);

//		String empno = reservationDto.getReserver();
//		log.info("（；´д｀）ゞ（；´д｀）ゞ:{}",empno);)
		if (reservationDto.getReserver() == null) {
		    return ResponseEntity.status(401).body("로그인 실패");
		}
//		reservationDto.setReserver(empno);
		
		int result = reservationService.insertreservation(reservationDto);
		Map<String, Object> map = new HashMap<String, Object>();
		
		if(result > 0) {
			map.put("isc", true);
			return ResponseEntity.ok(map); // 성공 시 응답
		}else {
			map.put("isc", false);
			return ResponseEntity.status(400).body(map); // 실패 시 응답			
		}
//		return null;
	}
	
	@GetMapping("/reservationList.do")
	public String reservationList(Model model,@RequestParam (required = false) String date, HttpSession session) {
		List<ReservationDto> reservationlists = reservationService.reservationList();
		model.addAttribute("reservationList", reservationlists);
		
//		EmployeeDto loginDto = (EmployeeDto)session.getAttribute("loginDto");
//		
//		if(loginDto == null) {
//			return "redirect:/login.do";
//		}
		
//		String empno = loginDto.getEmpno();
		
		
		
		return "reservationList";
	}
	
	@GetMapping("/delReservation.do")
	public String delReservation (HttpSession session, String reservation_id, Model model) {
		EmployeeDto loginDto = (EmployeeDto)session.getAttribute("loginDto"); //세션에서 로그인된 사용자 정보 가져오기
//		String loggedInUserId = loginDto != null ? loginDto.getEmpno() : null; //로그인된 사용자 ID
		
		// 예약 정보 조회
	    ReservationDto reservation = reservationService.selectReserverAndMember(reservation_id);
//	    String reserver = reservation.getReserver(); // 예약자 정보
		
	    // 예약 정보가 없으면 처리
//	    if (reservation == null) {
//	        model.addAttribute("alertMessage", "예약 정보를 찾을 수 없습니다.");
//	        return "redirect:/rooms/reservationList.do";  // 예약 정보가 없으면 리디렉션
//	    }
//	    
//	    String reserver = reservation.getReserver(); // 예약자 정보
//	    
//	    // 예약자가 아니면 삭제 권한 없음
//	    if (reserver == null || !reserver.equals(loggedInUserId)) {
//	        model.addAttribute("alertMessage", "삭제 권한이 없습니다.");
//	        return "redirect:/rooms/reservationList.do"; // 삭제 권한이 없을 경우 리디렉션
//	    }
	    
		int deleted = reservationService.delReservation(reservation_id, loginDto.getEmpno()); // 삭제 실행
		
		
		
	    if (deleted > 0) {
	        return "redirect:/rooms/reservationList.do";  // 삭제 성공 시 true 반환
	    } else {
	        return "redirect:/rooms/reservationList.do";  // 삭제 실패 시 false 반환
	    }
	}


}
