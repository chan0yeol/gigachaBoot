package com.giga.gw.security;

import com.giga.gw.dto.EmployeeDto;
import com.giga.gw.service.ILoginService;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Component;

@Component
@RequiredArgsConstructor
public class SecurityLoginService implements UserDetailsService {
    private final ILoginService loginService;

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        EmployeeDto emp = loginService.login(username);
        System.out.println(emp);
        if(emp != null) {
            return User.builder()
                    .username(emp.getEmpno())
                    .password(emp.getPassword())
                    .roles(emp.getAuth())
                    .build();
        } else{
            throw new UsernameNotFoundException("조회된 회원이 없습니다.");
        }

    }
}
