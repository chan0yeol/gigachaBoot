package com.giga.gw;



import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;


import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class HomeController {
	
	@GetMapping("/")
	public String index(HttpSession session) {
		return "index";
	}

	@GetMapping("/editor.do")
	public String editor() {
		return "editor";
	}
	@GetMapping("/tree.do")
	public String tree() {
		return "tree";
	}
	@GetMapping("/ckeditor.do")
	public String ckeditor() {
		return "ckEditor";
	}
}
