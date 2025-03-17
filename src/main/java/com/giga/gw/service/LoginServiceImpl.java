package com.giga.gw.service;

import java.util.Map;

import org.springframework.stereotype.Service;

import com.giga.gw.dto.EmployeeDto;
import com.giga.gw.repository.ILoginDao;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
@RequiredArgsConstructor
public class LoginServiceImpl implements ILoginService {

	private final ILoginDao loginDao;
	
	@Override
	public EmployeeDto login(Map<String, Object> map) {
		
		return loginDao.login(map);
	}

	@Override
	public String findEmpnoByNameAndEmail(Map<String, Object> map) {
		return loginDao.findEmpnoByNameAndEmail(map);
	}


}
