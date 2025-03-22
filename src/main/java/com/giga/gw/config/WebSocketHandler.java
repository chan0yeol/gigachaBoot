package com.giga.gw.config;

import com.giga.gw.dto.EmployeeDto;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Component;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import java.io.IOException;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

@Component
@Slf4j
public class WebSocketHandler extends TextWebSocketHandler {
    private Map<WebSocketSession, String> sessionEmpMap = new ConcurrentHashMap<>();
    private Map<String, WebSocketSession> empSessionMap = new ConcurrentHashMap<>();

    @Override
    public void afterConnectionEstablished(WebSocketSession session) throws Exception {
        log.info("[WebSocket] afterConnection 접속 : {}", session);

//        list.add(session);
        Map<String, Object> sessionMap = session.getAttributes();
        EmployeeDto loginDto = (EmployeeDto) sessionMap.get("loginDto");
        if(loginDto != null){
            String empno = loginDto.getEmpno();
            sessionEmpMap.put(session, empno);
            empSessionMap.put(empno, session);
            log.info("[WebSocket] 연결된 사원번호  : {}", empno);
            log.info("[WebSocket] WebSocket Session List {}",sessionEmpMap);
        } else{
            log.error("[WebSocket] 로그인 정보 없음");
        }
        super.afterConnectionEstablished(session);
    }

    @Override
    protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
        log.info("js에서 보낸메세지 : {}", message.getPayload());
        log.info("알림 전달");
        String txt = message.getPayload();

        String empno = sessionEmpMap.get(session);
        if(empno != null){
            log.info("[WebSocket] 메세지 보낸 사원 : " , empno);
        }

//        String targetEmpno = "1505001";
//
//        WebSocketSession targetSession = empSessionMap.get(targetEmpno);
//        if (targetSession != null && targetSession.isOpen()) {
//            targetSession.sendMessage(new TextMessage("개별 메시지 전송"));
//            log.info("[WebSocket] {}에게 메시지를 전송했습니다.", targetEmpno);
//        }
//        for (WebSocketSession s : empSessionMap.values()) {
//            if (s.isOpen()) {
//                s.sendMessage(new TextMessage(empno +"로그인함"));
//            }
//        }

        super.handleTextMessage(session, message);

    }

    @Override
    public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
        String empno = sessionEmpMap.remove(session);
        if (empno != null) {
            empSessionMap.remove(empno);
            log.info("[WebSocket] {}번 사원 소켓 종료", empno);
        }

        super.afterConnectionClosed(session, status);
    }

    public void sendMessageToUser(String empno, String msg) throws IOException {
        log.info("empno : {}",empno);
        log.info("세션정보 {}",empSessionMap);
        WebSocketSession targetSession = empSessionMap.get(empno);
        log.info("세션정보 {}",targetSession);
        if (targetSession != null && targetSession.isOpen()) {
            targetSession.sendMessage(new TextMessage(msg));
            log.info("[WebSocket] {}번 사원에게 메시지 전송 완료: {}", empno, msg);
        } else {
            log.warn("[WebSocket] {}번 사원의 세션 없음", empno);
        }
    }
}
