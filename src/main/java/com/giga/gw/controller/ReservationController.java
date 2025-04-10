package com.giga.gw.controller;

import com.giga.gw.config.WebSocketHandler;
import com.giga.gw.dto.EmployeeDto;
import com.giga.gw.dto.ReservationDto;
import com.giga.gw.dto.RoomDto;
import com.giga.gw.repository.IReservationDao;
import com.giga.gw.service.IReservationService;
import com.giga.gw.service.IRoomService;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/rooms")
@RequiredArgsConstructor
@Slf4j
public class ReservationController {

	private final IReservationService reservationService;
	private final IRoomService roomService;
	private final IReservationDao reservationDao;
	private final WebSocketHandler webSocketHandler;
	
	@GetMapping("/reservation.do")
	public String reservation(Model model , @RequestParam (value = "date", required = false) String date ) {
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
	public ResponseEntity insertreservation(HttpSession session,
											@RequestBody ReservationDto reservationDto,
											HttpServletRequest request){
		System.out.println(reservationDto);

		if (reservationDto.getReserver() == null) {
		    return ResponseEntity.status(401).body("로그인 실패");
		}
		
		int result = reservationService.insertreservation(reservationDto);
		Map<String, Object> map = new HashMap<String, Object>();
		
		String[] member = reservationDto.getMember().split("/");
		for(int i = 0; i < member.length; i++) {
			try {
				webSocketHandler.sendMessageToUser(member[i], "회의예약 참가자로 등록<br>회의사유:"+reservationDto.getPurpose());
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		
		if(result > 0) {
			map.put("isc", true);
			return ResponseEntity.ok(map); // 성공 시 응답
		}else {
			map.put("isc", false);
			return ResponseEntity.status(400).body(map); // 실패 시 응답			
		}
	}
	
	//전체예약내역
	@GetMapping("/reservationList.do")
	public String reservationList(Model model,@RequestParam (required = false) String date, HttpSession session) {
		EmployeeDto loginDto = (EmployeeDto)session.getAttribute("loginDto");
		
		List<ReservationDto> reservationList = null;
		
		if(loginDto.getAuth().equals("A")) {
			reservationList = reservationService.reservationList();			
		}else {
			reservationList = reservationService.getReservationList(loginDto.getEmpno());			
		}
	
		model.addAttribute("reservationList", reservationList);
		
		
		return "reservationList";
	}
	
	
	//예약취소
	@GetMapping("/delReservation.do")
	@ResponseBody // JSON 응답을 반환하도록 설정
	public Map<String, Object> delReservation(HttpSession session, String reservation_id) {
	    System.out.println("delReservation 호출됨, reservation_id: " + reservation_id);
	    
	    EmployeeDto loginDto = (EmployeeDto) session.getAttribute("loginDto");
	    String loggedInUserId = loginDto != null ? loginDto.getEmpno() : null;
	    System.out.println("로그인 사용자 ID: " + loggedInUserId);
	    
	    Map<String, Object> response = new HashMap<>();
	    
	    try {
	        ReservationDto reservation = reservationService.selectReserverAndMember(reservation_id);
	        System.out.println("조회된 예약 정보: " + reservation);
	        
	        if (reservation == null) {
	            response.put("errorMessage", "예약 정보를 찾을 수 없습니다.");
	            return response;
	        }
	        
	        String reserver = reservation.getReserver();
	        System.out.println("예약자: " + reserver + ", 로그인 사용자: " + loggedInUserId);
	        
	        if (reserver == null || !reserver.equals(loggedInUserId)) {
	            response.put("errorMessage", "예약자만 취소할 수 있습니다.");
	            return response;
	        }
	        
	        int deleted = reservationService.delReservation(reservation_id, loginDto.getEmpno());
	        
	        if (deleted > 0) {
	            response.put("Message", "예약이 취소되었습니다.");
	        } else {
	            response.put("errorMessage", "예약자만 취소할 수 있습니다.");
	        }
	        String[] member = reservation.getMember().split("/");
	        for(int i = 0; i < member.length; i++) {
	        webSocketHandler.sendMessageToUser(member[i], reservation.getReservation_id()+"회의예약이 취소되었습니다.");
	        }
	    } catch (Exception e) {
	        System.out.println("예외 발생: " + e.getMessage());
	        e.printStackTrace();
	        response.put("errorMessage", "서버 오류가 발생했습니다.");
	    }
		

	    return response;
	}

}
