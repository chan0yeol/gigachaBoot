package com.giga.gw.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;


import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.util.WebUtils;

import com.giga.gw.dto.EmployeeDto;
import com.giga.gw.dto.RoomDto;
import com.giga.gw.service.IRoomService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@RequestMapping("/rooms")
@Slf4j
public class RoomController {

	private final IRoomService roomService;
	
	//회의실 등록 폼
	@GetMapping("/roomform.do")
	public String roomform() {
		return "roomform"; //페이지 이동
	}
	
	//회의실 등록
	@PostMapping(value = "/insertRoom.do")
	@ResponseBody
	public boolean registerRoom(
			RoomDto roomDto, 
			HttpSession session,
								@RequestParam MultipartFile file, HttpServletRequest request,
								Model model) {
		EmployeeDto employee = (EmployeeDto)session.getAttribute("loginDto");
			
		if(employee == null) { //로그인 여부 확인
			return false;
		}
			
//			String auth = employee.getAuth(); 
//			
//		    if(auth == null || !"admin".equals(auth)) {
//		    	return "권한이 없습니다."; //관리자 권한이 없는 경우
//		    }else {
//		    	try {
//		    		roomService.insertRoom(roomDto); 
//		    		return "redirect:/rooms/reservation.do"; //등록 성공 시 예약 페이지로 이동
//		    	}catch(Exception e) {
//		    		return "redirect:/rooms/roomform.do"; //등록 실패 시 등록폼으로 이동
//		    	}	
		
		String originFileName = file.getOriginalFilename(); //보여 줄 파일명
		String saveFileName = UUID.randomUUID().toString().concat(originFileName.substring(originFileName.lastIndexOf("."))); //저장 할 파일명
		log.info("기존 파일명:{}",originFileName);
		log.info("저장 파일명:{}",saveFileName);

		InputStream inputStream = null;
		OutputStream outputStream = null;
		
		try {
			//1)파일을 읽는다
			inputStream = file.getInputStream();
			
			//2)저장위치를 만든다
			String path = request.getSession().getServletContext().getRealPath("/storage/images"); // 절대경로
//			String path02 = request.getSession().getServletContext().getRealPath("storage");
			log.info("저장경로:{}\n{}",path);
			
			//3)파일저장위치를 판단하여 생성한다
			 File storage = new File(path);
			 if(!storage.exists()) {
				 storage.mkdirs();
			 }
			 
			 //4)저장 공간에 저장 할 파일이 없다면 생성하고 있다면 오버라이드한다.
			 File newFile = new File(path+"/"+saveFileName);
			 if(!newFile.exists()) {
				 newFile.createNewFile();
			 }
			 
			 //5)읽은 파일을 써주기(저장)
			 outputStream = new FileOutputStream(newFile);
			 
			 //6)파일을 읽어서 대상파일에 써줌
			 int read = 0;
			 byte[] b = new byte[(int)file.getSize()];
			 while((read = inputStream.read(b))!= -1) {
				 outputStream.write(b,0,read);
			 }
			 
		} catch (IOException e) {
			e.printStackTrace();
		}finally {
			try {
				inputStream.close();
				outputStream.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
			
		  roomDto.setImage_url("/images/"+saveFileName);		
		  int result = roomService.insertRoom(roomDto);
//		  return false;
		  return result == 1 ?  true : false;
		 }
	
	
	//회의실 리스트 조회(관리자)
	@GetMapping("/roomList.do")
	public String roomList(Model model) {
		List<RoomDto> roomList = roomService.selectAllRooms();
		model.addAttribute("roomList", roomList);
		return "roomList";	
	}
	
	 
	@PostMapping("/update.do")
	@ResponseBody
	public ResponseEntity updateRoom(@RequestBody RoomDto roomDto) {
		System.out.println(roomDto);
		
		int updateRoom = roomService.updateRoom(roomDto); // 회의실 정보 업데이트
		
		if (updateRoom > 0) {
	        return ResponseEntity.ok(true);  // 성공 시 응답
	    } else {
	        return ResponseEntity.status(400).body(false);  // 실패 시 응답
	    }
	}
	
	

}
