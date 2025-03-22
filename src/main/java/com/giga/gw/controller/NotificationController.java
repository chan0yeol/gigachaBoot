package com.giga.gw.controller;

import com.giga.gw.dto.EmployeeDto;
import jakarta.servlet.ServletConfig;
import jakarta.servlet.ServletContext;
import jakarta.servlet.http.HttpSession;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.ServletConfigAware;

import java.util.HashMap;
import java.util.Map;

@Controller
@Slf4j
public class NotificationController{
   /* private ServletContext servletContext;
    @Override
    public void setServletConfig(ServletConfig servletConfig) {
        servletContext = servletConfig.getServletContext();
        System.out.println("setServletConfig 생성 값 : " + servletContext);
    }*/

    @GetMapping("/noti.do")
    public String socketOpen(HttpSession session) {
        EmployeeDto loginDto = (EmployeeDto) session.getAttribute("loginDto");
//        log.info("웹소캣 목록 : {}", servletContext.getAttribute("chatList"));

        return "noti";
    }

}
