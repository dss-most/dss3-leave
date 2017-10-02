package th.go.dss.vCalendar.dao;

import java.sql.Time;
import java.util.Date;
import java.util.List;
import java.util.Map;

public interface VCalendarDao {
	
	List<Map<String, Object>> findEvents(Date from, Date to);

	List<Map<String, Object>> findEventsOverLap(Integer categoryId, Date date,
			Time start, Time end);

	void saveEvent(Integer empId, String title, Date date, Time start, Time end,
			Integer categoryId);
}
