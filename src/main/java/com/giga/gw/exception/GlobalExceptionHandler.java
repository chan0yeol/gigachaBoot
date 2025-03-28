package com.giga.gw.exception;

import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.servlet.NoHandlerFoundException;

@ControllerAdvice
public class GlobalExceptionHandler {

    @ExceptionHandler(NoHandlerFoundException.class)
    public String handle404(NoHandlerFoundException ex, Model model) {
//        model.addAttribute("errorMessage", "요청하신 페이지를 찾을 수 없습니다.");
        return "error/404"; // /WEB-INF/views/error/404.jsp
    }
}
