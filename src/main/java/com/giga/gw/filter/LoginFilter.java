package com.giga.gw.filter;

import com.giga.gw.dto.EmployeeDto;
import jakarta.servlet.*;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.StringUtils;
import org.springframework.util.AntPathMatcher;

import java.io.IOException;
import java.util.Arrays;
import java.util.List;

@Slf4j
//@Component
public class LoginFilter implements Filter {

    private static final AntPathMatcher pathMatcher = new AntPathMatcher();
    private static final List<String> EXCLUDED_PATHS = Arrays.asList(
            "/loginForm.do",
            "/employee/findEmployee.do",
            "/employee/findEmpno.do",
            "/resources/**"
    );

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;

        req.setCharacterEncoding("UTF-8");

        String path = req.getServletPath();

        logClientInfo(req);

        if (isExcludedPath(path)) {
            chain.doFilter(req, res);
            return;
        }

        HttpSession session = req.getSession(false);
        EmployeeDto loginDto = session != null ? (EmployeeDto) session.getAttribute("loginDto") : null;

        if (loginDto == null) {
            log.warn("로그인 정보 없음 : {}", path);
            res.sendRedirect("/loginForm.do");
            return;
        }

        chain.doFilter(req, res);
    }

    private boolean isExcludedPath(String path) {
        return EXCLUDED_PATHS.stream()
                .anyMatch(pattern -> pathMatcher.match(pattern, path));
    }


    private void logClientInfo(HttpServletRequest req) {
        String url = StringUtils.defaultIfEmpty(req.getRequestURL().toString(), "-");
        String queryString = StringUtils.defaultIfEmpty(req.getQueryString(), "-");
        String remoteAddr = StringUtils.defaultIfEmpty(req.getRemoteAddr(), "-");
        String userAgent = StringUtils.defaultIfEmpty(req.getHeader("User-Agent"), "-");
        String referer = StringUtils.defaultIfEmpty(req.getHeader("Referer"), "-");

//        log.info("\n\n 사용자 정보 :\n URL: {}?{}\n IP: {}\n User-Agent: {}\n Referer: {}",
//                url, queryString, remoteAddr, userAgent, referer);
    }

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        log.info("LoginFilter init");
    }

    @Override
    public void destroy() {
        log.info("LoginFilter destroy");
    }
}
