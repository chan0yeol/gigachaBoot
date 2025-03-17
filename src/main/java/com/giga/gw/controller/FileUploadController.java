package com.giga.gw.controller;

import java.io.InputStream;
import java.io.OutputStream;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;


import jakarta.servlet.http.HttpServletRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class FileUploadController {
	
	@PostMapping("/insertRoom.do")
	public String fileUpload(@RequestParam List<MultipartFile> file, HttpServletRequest request,
							Model model) {
		log.info("업로드 파일의 개수:{}",file.size());
		
		List<String> originFileNames = new ArrayList<String>(); //화면에 전송 할 파일명
		List<String> saveFileNames = new ArrayList<String>(); //화면에 전송 할 저장된 파일의 파일명
		String path = "";
		
		for(MultipartFile f : file) {
			log.info("파일의 이름:{}",f.getOriginalFilename());
			String originFileName = f.getOriginalFilename(); //보여 줄 파일명
			String saveFileName = UUID.randomUUID().toString().concat(originFileName.substring(originFileName.lastIndexOf("."))); //저장 할 파일명
			log.info("기존 파일명:{}",originFileName);
			log.info("저장 파일명:{}",saveFileName);
			
			originFileNames.add(originFileName);
			saveFileNames.add(saveFileName);
			
			InputStream inputStream = null;
			OutputStream outputStream = null;
		}
		
		return null;
		
	}
	

}
