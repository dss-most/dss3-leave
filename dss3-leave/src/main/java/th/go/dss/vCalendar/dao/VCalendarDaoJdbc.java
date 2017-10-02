package th.go.dss.vCalendar.dao;

import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Time;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.sql.DataSource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;
import org.springframework.stereotype.Repository;


@Repository
public class VCalendarDaoJdbc implements VCalendarDao {

	private static final Logger logger = LoggerFactory.getLogger(VCalendarDaoJdbc.class);
	
	private NamedParameterJdbcTemplate jdbcTemplate;
	
	@Autowired() 
	@Qualifier("dataSource")
	public void setDataSource(DataSource ds) {
		this.jdbcTemplate = new NamedParameterJdbcTemplate(ds);
	}
	
	private RowMapper<Map<String, Object>> genericRowMapper = new RowMapper<Map<String, Object>>() {
		public Map<String, Object> mapRow(ResultSet rs, int rowNum)
				throws SQLException {
				Map<String, Object> map = new HashMap <String, Object>();
				
				// now get all the column
				ResultSetMetaData rsmd  = rs.getMetaData();
				Integer columnCount = rsmd.getColumnCount();
				for(Integer i=0; i<columnCount;  i++) {
					map.put(rsmd.getColumnName(i+1),rs.getObject(i+1));
				}
			return map;
		}
	};

	@Override
	public List<Map<String, Object>> findEvents(Date from, Date to) {
		String sql = "" +
				"SELECT EVENT_ID ID, EVENT_TITLE TITLE, EVENT_DESC, EVENT_DATE, EVENT_TIME, " +
				"	EVENT_TIME_END, CAT.CATEGORY_ID, CATEGORY_NAME " +
				"FROM events EVT, categories CAT " +
				"WHERE EVT.CATEGORY_ID = CAT.CATEGORY_ID " +
				"	AND :from  <= EVENT_DATE AND EVENT_DATE <= :to " +
				"ORDER BY EVENT_DATE ASC, EVENT_TIME ASC" +
				"";
		
		HashMap<String, Object> params = new HashMap<String, Object>();
		params.put("to", to);
		params.put("from", from);

		List<Map<String, Object>> returnList = this.jdbcTemplate.query(
				sql,
				params,
				genericRowMapper
				);
		
		return returnList;
	}

	@Override
	public List<Map<String, Object>> findEventsOverLap(Integer categoryId, Date date,
			Time start, Time end) {
		String sql = "" +
				"SELECT EVENT_ID ID, EVENT_TITLE TITLE, EVENT_DESC, EVENT_DATE, EVENT_TIME, " +
				"	EVENT_TIME_END  " +
				"FROM events EVT " +
				"WHERE CATEGORY_ID = :categoryId " +
				"	AND EVENT_DATE = :date " +
				"	AND " +
				"	 (	( :start <= EVENT_TIME AND EVENT_TIME <= :end ) " +
				"			OR" +
				"		( :start <= EVENT_TIME_END AND EVENT_TIME_END <= :end ) " +
				"			OR" +
				"		( EVENT_TIME <= :start AND :start <= EVENT_TIME_END )" +
				"			OR" +
				"		( EVENT_TIME <= :end AND :end <= EVENT_TIME_END )" +
				"	 ) " +
				"ORDER BY EVENT_DATE ASC, EVENT_TIME ASC" +
				"";
		
		HashMap<String, Object> params = new HashMap<String, Object>();
		params.put("categoryId", categoryId);
		params.put("date", date);
		params.put("start", start);
		params.put("end", end);

		List<Map<String, Object>> events = this.jdbcTemplate.query(
				sql,
				params,
				genericRowMapper
				);
		
		return events;
	}

	@Override
	public void saveEvent(Integer empId, String title, Date date, Time start, Time end,
			Integer categoryId) {
		String sql = "" +
				"INSERT INTO events " +
				"	(user_id, category_id, event_title, event_date, event_time, " +
				"		event_time_end, event_is_public, event_user_add, event_date_add) " +
				"VALUES (18, :categoryId, :title, :date, :start, :end, 1, :empId, :today) ";
		
		
			HashMap<String, Object> paramMap = new HashMap<String, Object> ();
			paramMap.put("title", title);
			paramMap.put("date", date);
			paramMap.put("start", start);
			paramMap.put("end", end);
			paramMap.put("categoryId", categoryId);
			paramMap.put("empId", empId);
			paramMap.put("today", new Date());
			
			jdbcTemplate.update(sql, paramMap);
		
		
	}
	
}
