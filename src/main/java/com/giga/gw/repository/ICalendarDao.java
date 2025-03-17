package com.giga.gw.repository;

import java.util.List;
import java.util.Map;

import com.giga.gw.dto.CalendarDto;

public interface ICalendarDao {

    int scheduleSave(Map<String, Object> schedule);
    
    //개인 스케줄
    List<Map<String, Object>> loadSchedule(String start, String end);
    
    //개인 스케줄2
    List<Map<String, Object>> loadEmpSchedule(String empno);
//    List<Map<String, Object>> loadEmpSchedule(Map<String, Object> emp);
    
    //부서 스케줄
    List<Map<String, Object>> loadDeptSchedule(String deptno);
    
    //전사원 스케줄
    List<Map<String, Object>> loadAllSchedule();
    
    //스케줄 삭제
    boolean deleteSchedule(String schid,String empno);
    
    //스케줄 수정
    boolean updateSchedule(Map<String, Object> schedule);
}
