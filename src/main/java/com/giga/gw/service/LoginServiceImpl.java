package com.giga.gw.service;

import com.giga.gw.dto.EmployeeDto;
import com.giga.gw.repository.ILoginDao;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.util.Map;

@Service
@Slf4j
@RequiredArgsConstructor
public class LoginServiceImpl implements ILoginService {

	private final ILoginDao loginDao;
	
	@Override
	public EmployeeDto login(String empno) {
		
		return loginDao.login(empno);
	}

	@Override
	public String findEmpnoByNameAndEmail(Map<String, Object> map) {
		return loginDao.findEmpnoByNameAndEmail(map);
	}


}
