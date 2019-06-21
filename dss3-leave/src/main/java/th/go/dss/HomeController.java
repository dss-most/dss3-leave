package th.go.dss;

import gitex.html.LutGlobalSessionName;
import gitex.tu.User;

import java.io.UnsupportedEncodingException;
import java.math.BigDecimal;
import java.sql.SQLException;
import java.sql.Time;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import oracle.sql.TIMESTAMP;

import org.apache.poi.ss.formula.functions.Vlookup;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import th.go.dss.backoffice.dao.BackofficeDao;
import th.go.dss.vCalendar.dao.VCalendarDao;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	private final SimpleDateFormat simpleDF = new SimpleDateFormat("yyyyMMdd", Locale.US);
	private final SimpleDateFormat thaiFullDF = new SimpleDateFormat("d MMMM GG yyyy", new Locale("th", "TH"));
	private final SimpleDateFormat thaisimpleDF = new SimpleDateFormat("yyyyMMdd", new Locale("th", "TH"));
	private final SimpleDateFormat timeDF = new SimpleDateFormat("HH:mm", new Locale("th", "TH"));
	
	
	@Autowired
	public BackofficeDao backofficeDao;
	
	
	@Autowired 
	public VCalendarDao vCalendarDao;
	
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/index.jsp")
	public String home(Model model) {
		
		return "index";
	}
	
	
	@RequestMapping(value="/api/reserveMeetingRoom", method=RequestMethod.POST)
	public @ResponseBody List<String> reserveMeetingRoom(
			@RequestParam Integer empId,
			@RequestParam String title,
			@RequestParam String meetingDay,
			@RequestParam String startTime,
			@RequestParam String endTime,
			@RequestParam Integer categoryId
			) throws ParseException {
		List<String> returnString = new ArrayList<String>();
		
		// now clean input
		Date date = thaisimpleDF.parse(meetingDay);
		java.sql.Time start = new java.sql.Time(timeDF.parse(startTime).getTime());
		java.sql.Time end = new java.sql.Time(timeDF.parse(endTime).getTime());
		
		// then we have to check for overlap 
		List<Map<String, Object>> events = vCalendarDao.findEventsOverLap(categoryId, date, start, end);
		if(events.size() > 0 ) {
			for(Map<String, Object> event : events) {
				String s = "";
				
				s += timeDF.format(((java.sql.Time) event.get("event_time")));
				s += "-";
				s += timeDF.format(((java.sql.Time) event.get("event_time_end")));
				s += " " + event.get("event_title");
				
				returnString.add(s);
			}
			return returnString;
		}
		
		
		// if not we can just save and return success
		vCalendarDao.saveEvent(empId, title, date, start, end, categoryId);
		returnString.add("success");
		
		return returnString;
	}
	
	@RequestMapping(value="/api/searchEvents")
	public @ResponseBody List<Map<String, Object>> searchEvents(@RequestParam Long start, 
			@RequestParam Long end ) throws ParseException {
		
		Date from = new Date(start*1000);
		Date to = new Date(end*1000);
		

		List<Map<String,Object>> events = vCalendarDao.findEvents(from, to);
		
		for(Map<String,Object> event : events) {
			event.put("id", event.get("event_id"));
			String title = (String) event.get("event_title");
			title = title.replaceAll("ห้องประชุมอัครเมธี(\\s)*/", "").trim();
			title = title.replaceAll("ห้องอัครเมธี(\\s)*/", "").trim();
			title = title.replaceAll("ห้องประชุมวิทยวิถี(\\s)*/", "").trim();
			title = title.replaceAll("ห้องวิทยวิถี(\\s)*/", "").trim();
			event.put("title", title);
			
			Long dateAsLong =  ((java.sql.Date) event.get("event_date")).getTime();
			
			if(event.get("event_time") != null && event.get("event_time_end") != null ) {
				Long startTimeAsLong = ((java.sql.Time) event.get("event_time")).getTime();
				Long endTimeAsLong = ((java.sql.Time) event.get("event_time_end")).getTime();
				
				event.put("start", (dateAsLong + startTimeAsLong + 25200000)/1000 );
				event.put("end", (dateAsLong + endTimeAsLong + 25200000)/1000 );
				event.put("allDay", false);
				
				if((Integer) event.get("category_id") == 1) {
					event.put("backgroundColor", "#8ae234");
					event.put("textColor", "#000000");
					event.put("className", "smallTxt");
				} else if((Integer) event.get("category_id") == 2) {
					event.put("backgroundColor", "#fce94f");
					event.put("textColor", "#000000");
					event.put("className", "smallTxt");
				}  else if((Integer) event.get("category_id") == 3) {
					event.put("backgroundColor", "#C26FFF");
					event.put("textColor", "#000000");
					event.put("className", "smallTxt");
				} 
				
				 	
			} else {
				event.put("start", (dateAsLong/1000) );
				event.put("end", (dateAsLong/1000) );
				event.put("allDay", true);
			}
			
			
		}
		
		return events;
		
	}
	
	@RequestMapping(value="/api/searchEmployee")
	public @ResponseBody List<Map<String, Object>> searchEmployee(@RequestParam String query) throws UnsupportedEncodingException {
		return backofficeDao.searchEmployee(query);
	}
	
	@RequestMapping(value="/pdfFrmHrVehicleOvernightReqForm", method=RequestMethod.GET)
	public String pdfFrmHrVehicleOvernightReqForm(HttpServletRequest request, Model model, HttpSession session,
			@RequestParam Integer id) throws SQLException {
	
		List<Map<String, Object>> returnList = backofficeDao.findFrmHrVehicleOvernightReqForm(id);
		if(returnList.size() != 1) {
			return null;
		} else {
		
			Map<String,Object> map = returnList.get(0);
			List<Map<String, Object>> jrFieldList = new ArrayList<Map<String, Object>>();
			
			String org_head = (String) map.get("ORG_HEAD_WORK_TITLE");
			
			if(org_head != null && org_head.length() > 0) {
				org_head = "  ผ่าน  " + org_head;
			}
			
			model.addAttribute("REQUESTER_NAME", map.get("REQNAME"));	
			model.addAttribute("ORG_HEAD_WORK_TITLE", org_head);
			model.addAttribute("FORMISSUEDATE", thaiFullDF.format(map.get("FORMISSUEDATE")));
			model.addAttribute("START_OVERNIGHT", thaiFullDF.format(map.get("START_OVERNIGHT")));
			model.addAttribute("END_OVERNIGHT", thaiFullDF.format(map.get("END_OVERNIGHT")));
			model.addAttribute("EMP_ORG", map.get("EMP_ORG"));
			model.addAttribute("EMP_TITLE", map.get("EMP_TITLE"));
			model.addAttribute("EMP_NAME", map.get("REQNAME"));

			model.addAttribute("LICENSE_PROVINCE", map.get("LICENSE_PROVINCE"));
			model.addAttribute("LICENSE_NUMBER", map.get("LICENSE_NUMBER"));
			model.addAttribute("REASON", map.get("REASON"));
			model.addAttribute("FORM_ID", map.get("ID"));
			
			
			
			jrFieldList.add(map);
			
			model.addAttribute("jrFieldList", jrFieldList);
				
		}
			
		return "frmHrVehicelOvernightReqReport";
	}
	
	@RequestMapping(value="/pdfFrmHrVehicleReqForm", method=RequestMethod.GET)
	public String pdfFrmHrVehicleReqForm(HttpServletRequest request, Model model, HttpSession session,
			@RequestParam Integer id) throws SQLException {
	
		List<Map<String, Object>> returnList = backofficeDao.findFrmHrVehicleReqForm(id);
		if(returnList.size() != 1) {
			return null;
		} else {
		
			Map<String,Object> map = returnList.get(0);
						
			// now get passengers
			
			List<Map<String, Object>> passengerList = backofficeDao.findFrmHrVehicleReqFormPassenger(((BigDecimal) map.get("ID")).intValue());
			List<Map<String, Object>> jrFieldList = new ArrayList<Map<String, Object>>();
			
			if(passengerList.size() != 0) {
				Integer i = 1;
				for(Map<String,Object> passenger : passengerList) {
					Map<String,Object> fieldMap = new HashMap<String, Object>();
					
					fieldMap.put("REQUESTER_NAME", map.get("REQNAME"));			
					fieldMap.put("ORG_HEAD_WORK_TITLE", map.get("ORG_HEAD_WORK_TITLE"));
					fieldMap.put("FORMISSUEDATE", thaiFullDF.format(map.get("FORMISSUEDATE")));
					fieldMap.put("VEHICLEREQUESTDATE", thaiFullDF.format(map.get("VEHICLEREQUESTDATE")));
					fieldMap.put("VEHICLEENDTIME", timeDF.format( ((TIMESTAMP) map.get("VEHICLEENDTIME")).dateValue() ));
					fieldMap.put("VEHICLESTARTTIME", timeDF.format( ((TIMESTAMP) map.get("VEHICLESTARTTIME")).dateValue() ));
					fieldMap.put("PLACETOGO", map.get("PLACETOGO"));
					fieldMap.put("REASONTOGO", map.get("REASONTOGO"));
					fieldMap.put("REMARK", map.get("REMARK"));
					fieldMap.put("FROM_ID", ((BigDecimal) map.get("ID")).intValue());
					fieldMap.put("PASSENGERNAME", "(" + i++ + ")  " + (String) passenger.get("PASSENGERNAME"));
					
					jrFieldList.add(fieldMap);
				}
				
			}
			
			model.addAttribute("jrFieldList", jrFieldList);
		
		}
		return "frmHrVehicelReqReport";
	}
	
	@RequestMapping(value="/viewFrmHrVehicleOvernightReqForm", method=RequestMethod.GET)
	public String viewFrmHrVehicleOvernightReqForm(HttpServletRequest request, Model model, HttpSession session,
			@RequestParam Integer id) throws SQLException {
		
		List<Map<String, Object>> returnList = backofficeDao.findFrmHrVehicleOvernightReqForm(id);
		if(returnList.size() != 1) {
			return null;
		} else {
		
			Map<String,Object> map = returnList.get(0);
			
			model.addAttribute("REQUESTER_NAME", map.get("REQNAME"));			
			model.addAttribute("ORG_HEAD_WORK_TITLE", map.get("ORG_HEAD_WORK_TITLE"));
			model.addAttribute("FORMISSUEDATE", thaiFullDF.format(map.get("FORMISSUEDATE")));
			model.addAttribute("START_OVERNIGHT", thaiFullDF.format(map.get("START_OVERNIGHT")));
			model.addAttribute("END_OVERNIGHT", thaiFullDF.format(map.get("END_OVERNIGHT")));
			model.addAttribute("EMP_ORG", map.get("EMP_ORG"));
			model.addAttribute("EMP_TITLE", map.get("EMP_TITLE"));
			model.addAttribute("EMP_NAME", map.get("REQNAME"));

			model.addAttribute("LICENSE_PROVINCE", map.get("LICENSE_PROVINCE"));
			model.addAttribute("LICENSE_NUMBER", map.get("LICENSE_NUMBER"));
			model.addAttribute("REASON", map.get("REASON"));
			model.addAttribute("FORM_ID", map.get("ID"));
		
		}
		
		return "forward:/leave/index.jsp?taskCode=M16-9";
	}
	
	@RequestMapping(value="/viewFrmHrVehicleReqForm", method=RequestMethod.GET)
	public String viewFrmHrVehicleReqForm(HttpServletRequest request, Model model, HttpSession session,
			@RequestParam Integer id) throws SQLException {
		
		List<Map<String, Object>> returnList = backofficeDao.findFrmHrVehicleReqForm(id);
		if(returnList.size() != 1) {
			return null;
		} else {
		
			Map<String,Object> map = returnList.get(0);
			
			
			model.addAttribute("ORG_HEAD_WORK_TITLE", map.get("ORG_HEAD_WORK_TITLE"));
			model.addAttribute("VEHICLEREQUESTDATE", thaiFullDF.format(map.get("VEHICLEREQUESTDATE")));
			model.addAttribute("VEHICLEENDTIME", timeDF.format( ((TIMESTAMP) map.get("VEHICLEENDTIME")).dateValue() ));
			model.addAttribute("VEHICLESTARTTIME", timeDF.format( ((TIMESTAMP) map.get("VEHICLESTARTTIME")).dateValue() ));
			model.addAttribute("PLACETOGO", map.get("PLACETOGO"));
			model.addAttribute("REASONTOGO", map.get("REASONTOGO"));
			model.addAttribute("REMARK", map.get("REMARK"));
			model.addAttribute("FRM_ID", map.get("ID"));
			
			
			// now get passengers
			
			List<Map<String, Object>> passengerList = backofficeDao.findFrmHrVehicleReqFormPassenger(((BigDecimal) map.get("ID")).intValue());
			List<String> passengerNameList = new ArrayList<String>();
			
			if(passengerList.size() != 0) {
				for(Map<String,Object> passenger : passengerList) {
					passengerNameList.add((String) passenger.get("PASSENGERNAME"));
				}
				
			}
			
			model.addAttribute("PASSENGERNAMES", passengerNameList);
		
		}
		
		return "forward:/leave/index.jsp?taskCode=M16-5";
	}
	@RequestMapping(value="/saveFrmVehicleOvernightInput", method = RequestMethod.POST)
	public String saveFrmVehicleOvernightInput(HttpServletRequest request, Model model, HttpSession session,
			@RequestParam String orgHead,
			@RequestParam String startOvernightDateStr,
			@RequestParam String endOvernightDateStr,
			@RequestParam String reason,
			@RequestParam String licenseNumber,
			@RequestParam String licenseProvince,
			@RequestParam Integer licenseProvinceId
			) throws UnsupportedEncodingException, ParseException {
		
		User user = (User)session.getAttribute(LutGlobalSessionName.USER);
		Integer empId = Integer.parseInt(user.employee.empId);
		String empTitle = user.employee.workTitle;
		String empTopOrg = user.employee.topORGName;
		
		
		
		logger.debug("licenseProvince: " + licenseProvince);
		logger.debug("empTopOrg: " + user.employee.topORGName);
		
		// incoming in BE format!

		orgHead = decodeTis620(orgHead);
		reason = decodeTis620(reason);
		licenseNumber = decodeTis620(licenseNumber);
		licenseProvince = decodeTis620(licenseProvince);
		
		if(licenseProvinceId == null) {
			licenseProvinceId = 21;
		}
		
		Date startOvernightDate = thaisimpleDF.parse(startOvernightDateStr);
		Date endOvernightDate = thaisimpleDF.parse(endOvernightDateStr);
		
		Integer fiscalYear = gitex.utility.Date.getCurrentBudgetYear();
		
		// now we just save to the data base;
		Integer id = backofficeDao.saveHrVehicleOvernightReqform(
						orgHead, fiscalYear, empId, empTitle, empTopOrg, startOvernightDate, 
						endOvernightDate, licenseNumber, licenseProvinceId, reason);
		
		model.addAttribute("ORG_HEAD_WORK_TITLE", orgHead);
		model.addAttribute("FORM_ID", id);
		model.addAttribute("EMP_ORG", empTopOrg);
		model.addAttribute("FORMISSUEDATE", thaiFullDF.format(new Date()));
		model.addAttribute("START_OVERNIGHT", thaiFullDF.format(startOvernightDate));
		model.addAttribute("END_OVERNIGHT", thaiFullDF.format(endOvernightDate));
		model.addAttribute("LICENSE_NUMBER", licenseNumber);
		model.addAttribute("LICENSE_PROVINCE", licenseProvince);
		model.addAttribute("REASON", reason);
		
		return "forward:/leave/index.jsp?taskCode=M16-9";
	}
	
	
	@RequestMapping(value="/saveFrmVehicleInput", method=RequestMethod.POST)
	public String saveFrmVehicleInput(HttpServletRequest request, Model model, HttpSession session,
			@RequestParam String orgHead,
			@RequestParam String vehicleRequestDateStr,
			@RequestParam String vehicleStartTime,
			@RequestParam String vehicleEndTime,
			@RequestParam String placeToGo,
			@RequestParam String reasonToGo,
			@RequestParam String remark,
			@RequestParam("passengerIds[]") Integer[] passengerIds,
			@RequestParam("passengerNames[]") String[] passengerNames
			) throws UnsupportedEncodingException, ParseException {
		
		User user = (User)session.getAttribute(LutGlobalSessionName.USER);
		
		for(Integer i=0; i< passengerNames.length; i++) {
			passengerNames[i] = decodeTis620(passengerNames[i]);
 		}
		
		
		// incoming in BE format!

		Date vehicleRequestDate = thaisimpleDF.parse(vehicleRequestDateStr);
		
		
		orgHead = decodeTis620(orgHead);
		placeToGo = decodeTis620(placeToGo);
		reasonToGo = decodeTis620(reasonToGo);
		remark = decodeTis620(remark);
		
		Integer empId = Integer.parseInt(user.employee.empId);
		String empTitle = user.employee.workTitle;
		
		Integer fiscalYear = gitex.utility.Date.getCurrentBudgetYear();
		
	
		// now we just save to the data base;
		Integer id = backofficeDao.saveHrVehicleReqform(
				orgHead, fiscalYear, empId, empTitle, vehicleRequestDate, 
				vehicleStartTime, vehicleEndTime, placeToGo, reasonToGo, remark);
		
		// then insert the passenger
		backofficeDao.saveHrVehicleReqformPassenger(id, passengerIds);
		
		
		model.addAttribute("ORG_HEAD_WORK_TITLE", orgHead);
		model.addAttribute("VEHICLEREQUESTDATE", thaiFullDF.format(vehicleRequestDate));
		model.addAttribute("VEHICLEENDTIME", vehicleEndTime);
		model.addAttribute("VEHICLESTARTTIME", vehicleStartTime);
		model.addAttribute("PLACETOGO", placeToGo);
		model.addAttribute("REASONTOGO", reasonToGo);
		model.addAttribute("REMARK", remark);
		model.addAttribute("FRM_ID", id);
		model.addAttribute("PASSENGERNAMES", passengerNames);
		
		
		
		return "forward:/leave/index.jsp?taskCode=M16-5";
	}

	private String decodeTis620(String str) throws UnsupportedEncodingException {
		return new String(str.getBytes("ISO-8859-1"), "TIS-620");
	}
	

	private String decodeUtf8(String str) throws UnsupportedEncodingException {
		return new String(str.getBytes("ISO-8859-1"), "UTF-8");
	}
}


