package com.giga.gw.repository;

import java.sql.Timestamp;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class CalendarDaoImpl implements ICalendarDao {

	private final SqlSessionTemplate sessionTemplate;
	private final String NS = "com.giga.gw.repository.CalendarDaoImpl.";
	
	@Override
	public int scheduleSave(Map<String, Object> schedule) {
		return sessionTemplate.insert(NS+"scheduleSave",schedule);
	}
	
	@Override
	public List<Map<String, Object>> loadSchedule(String start, String end) {
	    
	    // 🟢 특정 기간의 일정만 조회하도록 변경
	    Map<String, Object> params = new HashMap<String, Object>();
	    params.put("start", start);
	    params.put("end", end);
	    
	    List<Map<String, Object>> schedules = sessionTemplate.selectList(NS + "loadSchedule", params);

	    // 날짜 형식 변환
	    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm:ss");

	    for (Map<String, Object> schedule : schedules) {
	        Timestamp startTimestamp = (Timestamp) schedule.get("sch_startdate");
	        Timestamp endTimestamp = (Timestamp) schedule.get("sch_enddate");

	        // 🛑 NULL 체크 → NULL이면 기본값 설정 가능
	        String startDate = (startTimestamp != null) 
	            ? startTimestamp.toLocalDateTime().format(formatter) 
	            : null;
	        
	        String endDate = (endTimestamp != null) 
	            ? endTimestamp.toLocalDateTime().format(formatter) 
	            : null;

	        schedule.put("start", startDate);
	        schedule.put("end", endDate);

	        // 컬럼명 변경 (FullCalendar에서 사용할 수 있도록)
	        schedule.put("title", schedule.remove("sch_title"));
	        schedule.put("backgroundColor", schedule.remove("sch_color"));
	    }

	    return schedules;
	}

	@Override
	public List<Map<String, Object>> loadEmpSchedule(String empno) {
		List<Map<String, Object>> schedules = sessionTemplate.selectList(NS + "loadEmpSchedule", empno);
		return schedules;
	}
//	@Override
//	public List<Map<String, Object>> loadEmpSchedule(Map<String, Object> emp) {
//		List<Map<String, Object>> schedules = sessionTemplate.selectList(NS + "loadEmpSchedule", emp);
//		return schedules;
//	}
	@Override
	public List<Map<String, Object>> loadDeptSchedule(String deptno) {
		List<Map<String, Object>> schedules = sessionTemplate.selectList(NS + "loadDeptSchedule", deptno);
		return schedules;
	}

	@Override
	public List<Map<String, Object>> loadAllSchedule() {
		List<Map<String, Object>> schedules = sessionTemplate.selectList(NS + "loadAllSchedule");
		return schedules;
	}
	
	@Override
	public boolean deleteSchedule(String schid,String empno) {
		  Map<String, Object> params = new HashMap<>();
		  params.put("empno", empno);
		    params.put("sch_id", schid);
		    int result = sessionTemplate.update(NS + "deleteSchedule", params);
		    return result > 0;
	}
	
	@Override
	public boolean updateSchedule(Map<String, Object> schedule) {
		 int result = sessionTemplate.update(NS + "updateSchedule", schedule);
		    return result > 0;
	}


}
