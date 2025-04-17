package com.giga.gw.security;

import jakarta.servlet.DispatcherType;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.method.configuration.EnableMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configurers.CsrfConfigurer;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.web.cors.CorsConfiguration;
import org.springframework.web.cors.CorsConfigurationSource;
import org.springframework.web.cors.UrlBasedCorsConfigurationSource;
import org.springframework.web.filter.CorsFilter;

import java.util.Arrays;
import java.util.List;

@Configuration
@EnableWebSecurity
@EnableMethodSecurity
public class SecurityConfig {
    // Security 의 Password 인코딩을 자동으로 등록하고 사용할 수 있도록 한다. 즉 DB의 정보를 그대로 사용
    @Bean
    public PasswordEncoder loginPasswordEncoder() {
        return new NoPasswordEncoding();
    }

//    @Bean
    ////    public PasswordEncoder passwordEncoder() {
    ////        return new BCryptPasswordEncoder();
    ////    }

    @Bean
    public CorsFilter corsFilter(){
        return new CorsFilter(corsConfigurationSource());
    }
    @Bean
    public CorsConfigurationSource corsConfigurationSource() {
        CorsConfiguration config = new CorsConfiguration();
        config.setAllowedOrigins(List.of("http://localhost:3000"));
        config.setAllowedMethods(List.of("GET", "POST", "PUT", "DELETE", "OPTIONS"));
        config.setAllowedHeaders(Arrays.asList("Authorization", "Content-Type"));
        config.setAllowCredentials(true);
        UrlBasedCorsConfigurationSource source = new UrlBasedCorsConfigurationSource();
        source.registerCorsConfiguration("/**", config);
        return source;
    }
    @Bean
    public SecurityFilterChain securityFilterChain(HttpSecurity http, UserDetailsService userDetailsService) throws Exception {
        http
                // 요청이 내부적으로 다른 서블릿이나 JSP 포워딩 되는 경우
                .csrf(CsrfConfigurer::disable)
//                .cors(Customizer.withDefaults())
                .cors(cors -> cors.configurationSource(corsConfigurationSource()))
                // 로그인 성공시 처리
                .formLogin(login ->
                        login
                                .loginPage("/loginForm.do") // 사용자 로그인 화면
                                .loginProcessingUrl("/login.do") // submit을 처리할 요청 주소
                                .usernameParameter("empno") // 아이디 입력 name값
                                .passwordParameter("password") // 비밀번호 입력 name 값
                                .defaultSuccessUrl( "/index.do",true)
                                .successHandler((request, response, authentication) -> {
                                    String redirectUrl = "/index.do";
                                    response.sendRedirect(redirectUrl);
                                })
                                .permitAll()// 로그인 성공시 이동할 페이지
                )
                .authorizeHttpRequests(request -> // 요청을 forward Dispatcher에 대한 허용
                        request.dispatcherTypeMatchers(DispatcherType.FORWARD).permitAll() // Dispatcher에 대한 요청 모두 허용
                                .requestMatchers("/css/**","/expried.do","/loginForm.do").permitAll() // /images 안의 모든 요청 허용
                                .requestMatchers("/approval/manager*.do").hasRole("A") // /approval/manager* 로시작하는 모든 요청 권한이 ROLE_A
                                .anyRequest().authenticated() // 모든 요청에 대한 인증을 필요
                )
                // 로그아웃 요청 및 처리,
                // Controller의 요청 없이 /logout.do 자동 으로 로그아웃 된다. .logout(Customizer.withDefault())
                // 사용자 로그아웃
                .logout(logout ->
                        logout
                                .logoutUrl("/logout.do")
                                .logoutSuccessUrl("/loginForm.do")
                                .invalidateHttpSession(true) // 로그아웃되면 세션 지움
                                .deleteCookies("JSESSIONID") // 쿠키 지움
                )
                // rememberMe 설정
                .rememberMe(rememberMe ->
                    rememberMe.key("remember-me") // key 설정
                            .tokenValiditySeconds(3600) // 1시간
                            .userDetailsService(userDetailsService)
                            .rememberMeParameter("remember-me")
                            .rememberMeCookieName("remember-me-cookie")
                )
                .sessionManagement(sessionManagement ->
                        sessionManagement.maximumSessions(1) // 최대 허용 세션 수
                        .maxSessionsPreventsLogin(false) // 허용 세션수가 넘었을 때 기존세션 만료
                        .expiredUrl("/expried.do")
                )
                .sessionManagement(session ->
                        session.invalidSessionUrl("/expried.do") // 세션 만료시 이동할 페이지
                )
        ;
        return http.build();
    }

}
