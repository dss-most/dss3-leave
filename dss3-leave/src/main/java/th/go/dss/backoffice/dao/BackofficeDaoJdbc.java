package th.go.dss.backoffice.dao;

import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.sql.DataSource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;
import org.springframework.jdbc.core.simple.SimpleJdbcInsert;
import org.springframework.jdbc.support.GeneratedKeyHolder;
import org.springframework.jdbc.support.KeyHolder;
import org.springframework.stereotype.Repository;

@Repository
public class BackofficeDaoJdbc implements BackofficeDao {

	private static final Logger logger = LoggerFactory.getLogger(BackofficeDaoJdbc.class);
	
	private NamedParameterJdbcTemplate jdbcTemplate;
	
	private SimpleDateFormat simpleDF = new SimpleDateFormat("yyyyMMdd", Locale.US);
	private SimpleDateFormat simpleDFWithTime = new SimpleDateFormat("yyyyMMddHH:mm", Locale.US);
	
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
					//logger.debug("geting columnName: " + rsmd.getColumnName(i+1));
					//logger.debug("geting value: " + rs.getObject(i+1));
					map.put(rsmd.getColumnName(i+1),rs.getObject(i+1));
				}
			return map;
		}
	};

	
	
	@Override
	public Integer saveHrVehicleOvernightReqform(String orgHead, Integer fiscalYear, Integer empId, String empTitle,
			String empOrg, Date startOvernightDate, Date endOvernightDate, String licenseNumber, Integer licenseProvinceId,
			String reason) {
		
		String formIssueDate = simpleDF.format(new Date());
		String sql2 = "SELECT HR_VEHICLE_OVERNIGHT_SEQ.nextval from DUAL";
		HashMap<String, Object> emptyParam = new HashMap<String, Object> ();
		Integer id = jdbcTemplate.queryForObject(sql2, emptyParam, Integer.class);
		
		
		String sql = "" +
				"INSERT INTO HR_VEHICLE_OVERNIGHT_REQFORM (ID, FORMRUNNINGNUM, ORG_HEAD_WORK_TITLE, FISCALYEAR, EMP_ID, EMP_TITLE, EMP_ORG, " +
				"		START_OVERNIGHT, " +
				"		END_OVERNIGHT, " +
				
				"		REASON, LICENSE_NUMBER, LICENSE_PROVINCE_ID, " +
			    "		FORMISSUEDATE, STATUS) " +
				
				" 	VALUES(:ID, :FORMRUNNINGNUM, :ORGHEAD, :FISCALYEAR, :EMP_ID, :EMP_TITLE, :EMP_ORG, " +
				
				"		TO_DATE(:START_OVERNIGHT, 'YYYYMMDD','NLS_DATE_LANGUAGE = American'),  " +
				"		TO_DATE(:END_OVERNIGHT, 'YYYYMMDD','NLS_DATE_LANGUAGE = American'),  " +
				
				"		:REASON, :LICENSE_NUMBER, :LICENSE_PROVINCE_ID, " +
				"		TO_DATE(:FORMISSUEDATE, 'YYYYMMDD','NLS_DATE_LANGUAGE = American'), " + 
				"		:STATUS ) ";
		HashMap<String, Object> params = new HashMap<String, Object>();
		params.put("ID", id);
		params.put("FORMRUNNINGNUM", id);
		params.put("ORGHEAD", orgHead);
		params.put("FISCALYEAR", fiscalYear);
		params.put("EMP_ID", empId);
		params.put("EMP_TITLE", empTitle);
		params.put("EMP_ORG", empOrg);

		
		params.put("START_OVERNIGHT", simpleDF.format(startOvernightDate));
		params.put("END_OVERNIGHT", simpleDF.format(endOvernightDate));
		
		params.put("REASON", reason);
		params.put("LICENSE_NUMBER", licenseNumber);
		params.put("LICENSE_PROVINCE_ID", licenseProvinceId);
		
		params.put("FORMISSUEDATE", formIssueDate);
		params.put("STATUS", "WAITING_FOR_APPORVAL");
	
		jdbcTemplate.update(sql, params);
				
		return id;
	}



	@Override
	public Integer saveHrVehicleReqform(String orgHead, Integer fiscalYear, Integer empId, String empTitle, Date vehicleRequestDate,
			String vehicleStartTime, String vehicleEndTime, String placeToGo,
			String reasonToGo, String remark) {
		
		
		String formIssueDate = simpleDF.format(new Date());
		
		
		String sql2 = "SELECT hr_vehicle_reqfrom_seq.nextval from DUAL";
		HashMap<String, Object> emptyParam = new HashMap<String, Object> ();
		Integer id = jdbcTemplate.queryForObject(sql2, emptyParam, Integer.class);
		
		String sql = "" +
				"INSERT INTO HR_VEHICLE_REQFORM (ID, ORG_HEAD_WORK_TITLE, FISCALYEAR, EMP_ID, EMP_TITLE, " +
				"		VEHICLEREQUESTDATE, " +
				"		VEHICLESTARTTIME, VEHICLEENDTIME," +
				"		PLACETOGO, REASONTOGO, REMARK, FORMISSUEDATE) " +
				" 	VALUES(:ID, :ORGHEAD, " +
				"		:FISCALYEAR, :EMP_ID, :EMP_TITLE, " +
				"		TO_DATE(:VEHICLEREQUESTDATE, 'YYYYMMDD','NLS_DATE_LANGUAGE = American'),  " +
				"		TO_DATE(:VEHICLESTARTTIME, 'YYYYMMDDHH24:MI', 'NLS_DATE_LANGUAGE = American'),  " +
				"		TO_DATE(:VEHICLEENDTIME, 'YYYYMMDDHH24:MI', 'NLS_DATE_LANGUAGE = American'),  " +
				"		:PLACETOGO, :REASONTOGO, :REMARK, " +
				"		TO_DATE(:FORMISSUEDATE, 'YYYYMMDD','NLS_DATE_LANGUAGE = American')) ";
		HashMap<String, Object> params = new HashMap<String, Object>();
		params.put("ID", id);
		params.put("ORGHEAD", orgHead);
		params.put("FISCALYEAR", fiscalYear);
		params.put("EMP_ID", empId);
		params.put("EMP_TITLE", empTitle);
		params.put("VEHICLEREQUESTDATE", simpleDF.format(vehicleRequestDate));
		params.put("VEHICLESTARTTIME", simpleDF.format(vehicleRequestDate)+vehicleStartTime);
		params.put("VEHICLEENDTIME", simpleDF.format(vehicleRequestDate)+vehicleEndTime);
		params.put("PLACETOGO", placeToGo);
		params.put("REASONTOGO", reasonToGo);
		params.put("REMARK", remark);
		params.put("FORMISSUEDATE", formIssueDate);
		jdbcTemplate.update(sql, params);
				
		return id;
		
	}



	@Override
	public List<Map<String, Object>> searchEmployee(String query) {
		String sql = "" +
				"SELECT EMP_ID, EMP_NAME " +
				"FROM HR_V_EMPLOYEE " +
				"WHERE EMP_NAME LIKE :query " +
				"ORDER BY EMP_NAME ";
		HashMap<String, Object> params = new HashMap<String, Object>();
		params.put("query", "%"+query+"%");

		List<Map<String, Object>> returnList = this.jdbcTemplate.query(
				sql,
				params,
				genericRowMapper
				);
		
		return returnList;
			}



	@Override
	public void saveHrVehicleReqformPassenger(Integer id, Integer[] passengerIds) {
		String sql = "" +
				"INSERT INTO HR_VEHICLE_REQFORM_PASSENGER " +
				"	(ID, HR_VEHICLE_REQFORM_ID, PASSENGER_ID) " +
				"VALUES (hr_vehicle_reqfrom_pgr_seq.nextval, :ID, :EMPID) ";
		
		for(Integer i=0; i<passengerIds.length; i++) {
			HashMap<String, Object> paramMap = new HashMap<String, Object> ();
			paramMap.put("ID", id);
			paramMap.put("EMPID", passengerIds[i]);
			jdbcTemplate.update(sql, paramMap);
		}
		
	}



	@Override
	public List<Map<String, Object>> findFrmHrVehicleReqForm(Integer id) {
		String sql = "" +
				"SELECT ID, ORG_HEAD_WORK_TITLE, FISCALYEAR, " +
				"		CONCAT(HPX.PFIX_ABBR, EMP.EMP_NAME) REQNAME," +
				"		EMP_TITLE, FORMISSUEDATE, " +
				"		VEHICLEREQUESTDATE, " +
				"		VEHICLESTARTTIME, VEHICLEENDTIME," +
				"		PLACETOGO, REASONTOGO, REMARK, FORMISSUEDATE " +
				"FROM HR_VEHICLE_REQFORM VRQ, HR_EMPLOYEE EMP, HR_PREFIX HPX " +
				"WHERE ID =  :ID " +
				"	AND VRQ.EMP_ID = EMP.EMP_ID " +
				"	AND EMP.PREFIX_PFIX_ID = HPX.PFIX_ID ";
		HashMap<String, Object> params = new HashMap<String, Object>();
		params.put("ID", id);

		List<Map<String, Object>> returnList = this.jdbcTemplate.query(
				sql,
				params,
				genericRowMapper
				);
		
		return returnList;
	}
	
	
	

	@Override
	public List<Map<String, Object>> findFrmHrVehicleOvernightReqForm(Integer id) {
		String sql = "" +
				"SELECT ID, ORG_HEAD_WORK_TITLE, FISCALYEAR, " +
				"		CONCAT(HPX.PFIX_ABBR, EMP.EMP_NAME) REQNAME," +
				"		EMP_TITLE, EMP_ORG, FORMISSUEDATE, " +
				"		START_OVERNIGHT, END_OVERNIGHT, REASON, LICENSE_NUMBER, GLB_PROVINCE.PROVINCE_NAME LICENSE_PROVINCE " +
				"FROM HR_VEHICLE_OVERNIGHT_REQFORM VRQ, HR_EMPLOYEE EMP, HR_PREFIX HPX, GLB_PROVINCE " +
				"WHERE ID =  :ID " +
				"	AND VRQ.EMP_ID = EMP.EMP_ID "+ 
				"   AND VRQ.LICENSE_PROVINCE_ID = GLB_PROVINCE.PROVINCE_ID " +
				"	AND EMP.PREFIX_PFIX_ID = HPX.PFIX_ID ";
		HashMap<String, Object> params = new HashMap<String, Object>();
		params.put("ID", id);

		List<Map<String, Object>> returnList = this.jdbcTemplate.query(
				sql,
				params,
				genericRowMapper
				);
		
		return returnList;
	}



	@Override 
	public List<Map<String, Object>> findAllProvices() {
		String sql = ""
				+ "SELECT province_id, province_name "
				+ "FROM GLB_PROVINCE "
				+ "ORDER BY province_name asc";
		
		List<Map<String, Object>> returnList = this.jdbcTemplate.query(sql,genericRowMapper);
		
		return returnList;
	}

	@Override
	public List<Map<String, Object>> findFrmHrVehicleReqFormPassenger(
			Integer frmId) {
		String sql = "" +
				"SELECT  CONCAT(HPX.PFIX_ABBR, EMP.EMP_NAME) PASSENGERNAME " +
				"FROM HR_VEHICLE_REQFORM_PASSENGER VRP, HR_EMPLOYEE EMP," +
				"	HR_PREFIX HPX   " +
				"WHERE VRP.HR_VEHICLE_REQFORM_ID =  :ID " +
				"	AND VRP.PASSENGER_ID = EMP.EMP_ID " +
				"	AND EMP.PREFIX_PFIX_ID = HPX.PFIX_ID " +
				"ORDER BY VRP.ID ASC ";
		HashMap<String, Object> params = new HashMap<String, Object>();
		params.put("ID", frmId);

		List<Map<String, Object>> returnList = this.jdbcTemplate.query(
				sql,
				params,
				genericRowMapper
				);
		
		return returnList;
	}
}
