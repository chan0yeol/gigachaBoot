package com.giga.gw.filter;

import com.giga.gw.dto.EmployeeDto;
import jakarta.servlet.*;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Component;

import java.io.IOException;
import java.util.Arrays;
import java.util.List;

@Slf4j
@Component
public class LoginFilter implements Filter {


    private ServletRequest request;
    private ServletResponse response;
    private FilterChain chain;
    private static final long serialVersionUID = -1279327977342954449L;
    private List<String> excludeURL = Arrays.asList("/", "/login.do", "/employee/findEmployee.do", "/employee/findEmpno.do,/resources/**/*");
    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;

        String path = req.getServletPath();

        // 클라이언트 요청 정보 로깅
        logClientInfo(req);

        // 제외된 URL이면 필터 통과
        if (excludeURL.contains(path)) {
            req.setCharacterEncoding("UTF-8");
            chain.doFilter(req, res);
            return;
        }
        // 로그인 확인
        HttpSession session = req.getSession();
        EmployeeDto loginDto = (EmployeeDto) session.getAttribute("loginDto");

        if (loginDto == null) {
            log.warn("미인증 사용자 요청: {}", path);
            res.sendRedirect("/login.do");
        } else {
            chain.doFilter(req, res);
        }
    }
    private void logClientInfo(HttpServletRequest req) {
        String url = StringUtils.defaultIfEmpty(req.getRequestURL().toString(), "-");
        String queryString = StringUtils.defaultIfEmpty(req.getQueryString(), "-");
        String remoteAddr = StringUtils.defaultIfEmpty(req.getRemoteAddr(), "-");
        String userAgent = StringUtils.defaultIfEmpty(req.getHeader("User-Agent"), "-");
        String refer = StringUtils.defaultIfEmpty(req.getHeader("Referer"), "-");

        String clientInfo = String.format("%s?%s : %s \n %s %s \n", url, queryString, remoteAddr, userAgent, refer);
        log.info("\n \n 클라이언트 정보 {} ", clientInfo);
    }

}
