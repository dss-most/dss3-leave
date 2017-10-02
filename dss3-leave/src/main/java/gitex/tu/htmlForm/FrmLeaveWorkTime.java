package gitex.tu.htmlForm;

import javax.servlet.http.*;

import org.jfree.util.Log;
import org.joda.time.DateMidnight;
import org.joda.time.DateTime;
import org.joda.time.DateTimeConstants;
import org.joda.time.Interval;
import org.joda.time.LocalDate;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;
import java.util.Date;

import gitex.html.*;
import gitex.utility.*;



public class FrmLeaveWorkTime extends HtmlForm {
	
	public Logger logger = LoggerFactory.getLogger(this.getClass());	
	public static String ELM_NAME_EMP_ID="emp_Id";
	
	public static String START_DATE="in_time";
	
	public static String END_DATE="out_time";
	
	public static String WORK_DATE="work_Date";
	
	public static String HOLIDAY_DATE="HOLIDAY_DATE";
	
	public static String HOLIDAY_REMARK="REMARK";
	
	public ArrayList formList = new ArrayList();
	 
	public FrmLeaveWorkTime(HttpSession session, HttpServletRequest request){
	
		ArrayList elmName = new ArrayList();
		
		 elmName.add(ELM_NAME_EMP_ID);
		 elmName.add(START_DATE);
		 elmName.add(END_DATE);
		// elmName.add(WORK_DATE);
		 this.setValues(request, elmName);
		 String empId = this.getValue(ELM_NAME_EMP_ID);
		 String startDate=this.getValue(START_DATE);
		 // now convert to CE
		 Integer yearCE; 
		 if(startDate != null && startDate.length() == 8) {
			 yearCE = Integer.parseInt(startDate.substring(0, 4)) - 543;
			 startDate = yearCE + startDate.substring(4,startDate.length());
			 
		 }
		 
		 
		 String endDate=this.getValue(END_DATE);
		 // now convert to CE
		 if(endDate != null && endDate.length() == 8) {
			 yearCE = Integer.parseInt(endDate.substring(0, 4)) - 543;
			 endDate = yearCE + endDate.substring(4,endDate.length());
			
		 }
		// String workDate=this.getValue(WORK_DATE);
		 
		 
		 if(!empId.equals("") && !startDate.equals("") && !endDate.equals("") ){
			 
			 formList = getFormList(empId, startDate,endDate);
		 }
	 }		
	
	private ArrayList<Hashtable<String, Object>> getFormList(String empId, String startDate,String endDate){
		Database db = new Database();
		String sql = "";
		
		// to_char(DATEE2STD( m.work_date ,'DTE','SHORT_MON','FULL_YR',''))
		
		sql=" select d.emp_id, m.work_date work_date , ";   
		sql+=" to_char( min(m.work_time),'HH24:MI' ) in_time ,";   
		sql+=" to_char( max(m.work_time),'HH24:MI' ) out_time ";    
		sql+=" from hr_worktemp m , ";
		         sql+=" hr_employee d , ";
		          sql+=" hr_tag_record tag ";
		sql+=" where m.card_id=d.tag_no ";
		sql+=" and tag.emp_emp_id = d.emp_id "; 
		sql+=" and m.work_date between to_date('"+startDate+"','yyyymmdd') ";  
		sql+=" and to_date('"+endDate+"','yyyymmdd') ";   
		sql+=" and d.emp_id="+empId+" ";
		sql+=" and tag.effective_date = (select max(t.effective_date) ";
					         sql+=" from hr_tag_record t ";
					         sql+=" where t.emp_emp_id = d.emp_id ";
		                     sql+=" and     to_date('"+startDate+"','yyyymmdd') between t.effective_date  and sysdate    ) "; 
		 sql+=" group by m.work_date  ,d.emp_id ";  
		 sql+=" order by m.work_date desc ";
		
		
	/*	
		
		sql=" select d.emp_id ,";
		sql+=" to_char(DATEE2STD( m.work_date ,'DTE','SHORT_MON','FULL_YR','')) work_date ,   ";
	   	sql+=" to_char( min(m.work_time),'HH24:MM' ) in_time ,  "; 
		sql+=" to_char( max(m.work_time),'HH24:MM' ) out_time   "; 
		sql+=" from hr_worktemp m ,hr_employee d ";
		sql+=" where m.card_id=d.tag_no ";
		sql+=" and m.work_date between to_date('"+startDate+"','yyyymmdd')  ";
		sql+=" and to_date('"+endDate+"','yyyymmdd')   ";
		sql+=" and d.emp_id='"+empId+"' ";
		sql+=" group by d.emp_id,m.work_date "; 
		*/
		 logger.debug("sql to find all work in and out from TAFF record");
	logger.debug(sql);
		
		ArrayList<String> field = new ArrayList<String>();
		
		 field.add(ELM_NAME_EMP_ID);
		 field.add(START_DATE);
		 field.add(END_DATE);
		 field.add(WORK_DATE);
		
		Hashtable<String, String> dataType = new Hashtable<String, String>();
		dataType.put(WORK_DATE, "DATE");
		
		
		 
		 ArrayList<Hashtable<String, Object>> dbList = db.getResultSet(sql, field, dataType);
		 Stack<Hashtable<String, Object>> dbStack = new Stack<Hashtable<String,Object>>();
		 dbStack.addAll(dbList);
		 LocalDate dbDate = null;
		 Hashtable<String, Object> dbRow = null;
		 if(!dbStack.isEmpty()) {
			 	dbRow = dbStack.pop();
		    	dbDate = new LocalDate((Date) dbRow.get(WORK_DATE));
		 }
		 
		 // now holiday 
		 sql = ""
		 		+ "SELECT HOLIDAY_DATE, REMARK from hr_leave_holiday "
		 		+ "WHERE HOLIDAY_DATE between to_date('"+startDate+"','yyyymmdd') and to_date('"+endDate+"','yyyymmdd') "
		 		+ "order by HOLIDAY_DATE desc";
		 
		 logger.debug("sql to find all holidays");
			logger.debug(sql);
		 
		 dataType.put(HOLIDAY_DATE, "DATE");
		 field = new ArrayList<String>();
		 field.add(HOLIDAY_DATE);
		 field.add(HOLIDAY_REMARK);
		 ArrayList<Hashtable<String, Object>> holidayList = db.getResultSet(sql, field, dataType);
		 
		 Stack<Hashtable<String, Object>> holidayStack = new Stack<Hashtable<String,Object>>();
		 holidayStack.addAll(holidayList);
		 Hashtable<String, Object> holidayRow = null; 
		 LocalDate holidayDate = null;
		 String holidayRemark = null;
		 if(!holidayStack.isEmpty()) {
			 holidayRow = holidayStack.pop();
			 holidayDate =new LocalDate((Date) holidayRow.get(HOLIDAY_DATE));
			 holidayRemark=(String) holidayRow.get(HOLIDAY_REMARK);
		 }
		 
		// and Leave Request
	        sql = ""
	        		+ ""
	        		+ " SELECT t1.takeLeave_id, t2.LEAVEFORMTYPEDES LeaveFormDesc"
	        		+ ", t1.formStartDate formStartDate"
	        		+ ", t1.formEndDate AS formEndDate"
	        		+ ", t1.ref_takeleave_id, NVL(t1.formLeaveDays, 0) AS takeLeaveDays"
	        		+ ", t1.formStatus"
	        		+ " FROM hr_leave_takeLeaveForm t1, hr_leave_formtype t2 "
	        		+ " WHERE "
	        		+ "	   t1.leaveformtype = t2.LEAVEFORMTYPE	"
	        		+ "	   AND t1.emp_id = " + empId
	        		+ "    AND t1.formStartDate between  to_date('"+startDate+"','yyyymmdd') and to_date('"+endDate+"','yyyymmdd') "
	        				+ " AND t1.formStatus = 2 ";
	        

	        
	        //sql += " AND( t1.formStatus = " + reqForm.FORM_STATUS_ALLOW;
	        //sql += "  OR t1.formStatus = " + reqForm.FORM_STATUS_PARTIAL_CANCEL + ")";
	        //sql += " AND t2.takeLeave_id(+) = t1.takeLeave_id ";
	        //sql += " AND (t1.takeLeave_id IN(SELECT takeLeave_id FROM hr_leave_takeLeaveRec WHERE budgetYear = " + budgetYear + ") ";
	        //sql += " OR t1.ref_takeleave_id IN(SELECT takeLeave_id FROM hr_leave_takeLeaveRec WHERE budgetYear = " + budgetYear + "))";
	        sql += " ORDER BY t1.formStartDate desc, t1.formEndDate desc";
	        
	        logger.debug("sql to find all leave request");
	    	logger.debug(sql);
	        
	        
	        field = new ArrayList<String>();
	        field.add("takeleave_id");
	        field.add("LeaveFormDesc");
	        field.add("formStartDate");
	        field.add("formEndDate");
	        field.add("takeLeaveDays");
	        field.add("formStatus");
			dataType.put("formStartDate", "DATE");
			dataType.put("formEndDate", "DATE");
	        ArrayList<Hashtable<String, Object>> leaveReqList =  db.getResultSet(sql, field, dataType);
	        
	        Stack<Hashtable<String, Object>> leaveReqStack = new Stack<Hashtable<String,Object>>();
	        leaveReqStack.addAll(leaveReqList);
			 
			 Hashtable<String, Object> leaveReqRow = null; 
//			 Interval leaveReqInterval = null;
//			 if(!leaveReqStack.isEmpty()) {
//				 leaveReqRow = leaveReqStack.pop();
//				 LocalDate formEndDate  = (new LocalDate((Date) leaveReqRow.get("formEndDate"))).plusDays(1);
//				 
//				 leaveReqInterval = new Interval(
//						 new DateMidnight((Date) leaveReqRow.get("formStartDate")), 
//						 new DateMidnight( formEndDate.toDate() )
//				 );
//			 }
	        
	        
	        
		 
		 ArrayList<Hashtable<String, Object>> returnList = new ArrayList<Hashtable<String,Object>>();
		 HashMap<LocalDate, Hashtable<String, Object>> dateMap = new HashMap<LocalDate, Hashtable<String,Object>>();
		 SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd", Locale.US);
		 SimpleDateFormat sqlDateSdf = new SimpleDateFormat("yyyy-MM-dd", Locale.US );
		 SimpleDateFormat thaiSdf = new SimpleDateFormat("d MMM yy", new Locale("TH", "th"));
		 try{
			 
			logger.debug("startDate: " + startDate); 
			 
			LocalDate startLocalDate = new LocalDate(sdf.parse(startDate));
			LocalDate endLocalDate = new LocalDate(sdf.parse(endDate));
			endLocalDate = endLocalDate.plusDays(1);
			
			
			for (LocalDate date = startLocalDate; date.isBefore(endLocalDate); date = date.plusDays(1)) {
				
			    Hashtable<String, Object> hash = new Hashtable<String, Object>();
			    
			    dateMap.put(date, hash);
			    
			    hash.put(WORK_DATE, date.toDate());
			    
			    if(date.equals(dbDate)) {
			    	hash.put(START_DATE, dbRow.get(START_DATE));
			    	if(dbRow.get(START_DATE).toString().equals(dbRow.get(END_DATE).toString())) {
			    		hash.put(END_DATE, "-");
			    	} else {
			    		hash.put(END_DATE, dbRow.get(END_DATE));
			    	}
			    	
			    	// now advance dbRow and dbDate
			    	if(!dbStack.isEmpty()) {
			    		dbRow = dbStack.pop();
			    		dbDate = new LocalDate((Date) dbRow.get(WORK_DATE));
			    	}
			    	
			    } else {
			    	hash.put(START_DATE, "-");
			    	hash.put(END_DATE, "-");
			    }
			    
			    logger.debug("putting in hash: WORK_DATE: " + hash.get(WORK_DATE) + " START_DATE: " + hash.get(START_DATE) + " END_DATE: " + hash.get(END_DATE)  );
			    
			    
			    
			    // if Saturday or Sunday
			    if(date.getDayOfWeek() == DateTimeConstants.SATURDAY) {
			    	hash.put(HOLIDAY_REMARK, "วันเสาร์");
			    	logger.debug("  SATURDAY");
			    } else if(date.getDayOfWeek() == DateTimeConstants.SUNDAY){
			    	hash.put(HOLIDAY_REMARK, "วันอาทิตย์");
			    	logger.debug("  SUNDAY");
			    } else {
			    	hash.put(HOLIDAY_REMARK, "");
			    }
			    
			    
			    
			    if(date.equals(holidayDate)) {
			    	
			    	hash.put(HOLIDAY_REMARK, holidayRemark);
			    	
			    	logger.debug("  HOLIDAY_REMARK: " + holidayRemark);
			    	
			    	if(!holidayStack.isEmpty()) {
			    		holidayRow = holidayStack.pop();
						 holidayDate =new LocalDate((Date)holidayRow.get(HOLIDAY_DATE));
						 holidayRemark=(String) holidayRow.get(HOLIDAY_REMARK);	
			    	}
			    }
			    
			   	//logger.debug(">" +  leaveReqInterval);
//			    if(leaveReqInterval != null  && leaveReqInterval.contains(date.toDate().getTime())) {
//			    	logger.debug(" in leaveReqInterval: " + leaveReqInterval);
//			    	
//			    	java.sql.Date leaveStartDate = (java.sql.Date) leaveReqRow.get("formStartDate");
//			    	java.sql.Date leaveEndDate = (java.sql.Date) leaveReqRow.get("formEndDate");
//			    	logger.debug(">>>>>" + leaveStartDate);
//			    	
//			    	
//			    	
//			    	String leaveDateStr = thaiSdf.format( sqlDateSdf.parse(leaveStartDate.toString()) );
//			    	
//			    	if(!leaveStartDate.equals(leaveEndDate)) {
//			    		leaveDateStr += " - " + thaiSdf.format(sqlDateSdf.parse(leaveEndDate.toString()));
//			    	}
//			    	
//			    	
//			    	hash.put(HOLIDAY_REMARK, leaveReqRow.get("LeaveFormDesc") + "<br/>(" + leaveDateStr
//			    			+ " จำนวน " + leaveReqRow.get("takeLeaveDays") + " วัน)" );
//			    	
//			    	logger.debug("  HOLIDAY_REMARK: " + hash.get(HOLIDAY_REMARK));
//			    	
//			    	if(!leaveReqInterval.contains(date.plusDays(1).toDate().getTime())) {
//			    		logger.debug("leaveRequest is not contain the next day");
//			    		if(!leaveReqStack.isEmpty()) {
//			    			logger.debug("leaveReqStack is not empty");
//			    			
//							 leaveReqRow = leaveReqStack.pop();
//							 LocalDate formEndDate  = (new LocalDate((Date) leaveReqRow.get("formEndDate"))).plusDays(1);
//							 
//							 Interval newInterval = new Interval(
//									 new DateMidnight((Date) leaveReqRow.get("formStartDate")), 
//									 new DateMidnight( formEndDate.toDate() )
//							 ); 
//							 
//							 if(newInterval.getEnd().isBefore(leaveReqInterval.getEnd())) {
//								 
//								 
//								 
//								 
//								 
//							 } else {
//							 	 leaveReqInterval = newInterval;
//							 }
//							 
//							 logger.debug("new interval: " + leaveReqInterval);
//							 
//						 } else {
//							 logger.debug("leaveReqStack is not empty");
//						 }
//			    	} else {
//			    		logger.debug("leaveRequest __contain__ the next day");
//			    	}
//			    }
			    
			    returnList.add(hash);
			}
			
			
			// now loop through leave req stack
			 
			 while(!leaveReqStack.isEmpty()) {
				leaveReqRow = leaveReqStack.pop();
				LocalDate loopDate = new LocalDate((Date) leaveReqRow.get("formStartDate"));
				LocalDate formEndDate  = (new LocalDate((Date) leaveReqRow.get("formEndDate"))).plusDays(1);
				
				java.sql.Date leaveStartDate = (java.sql.Date) leaveReqRow.get("formStartDate");
		    	java.sql.Date leaveEndDate = (java.sql.Date) leaveReqRow.get("formEndDate");
				String leaveDateStr = thaiSdf.format( sqlDateSdf.parse(leaveStartDate.toString()) );
				
			    if(!leaveStartDate.equals(leaveEndDate)) {
			    	leaveDateStr += " - " + thaiSdf.format(sqlDateSdf.parse(leaveEndDate.toString()));
			    }
			    
			    logger.debug(leaveDateStr);
				 
				 while(loopDate.isBefore(formEndDate)) {
				
					 Hashtable<String, Object> hashDate = dateMap.get(loopDate);
					 String str = (String) hashDate.get(HOLIDAY_REMARK);
					 if(str.length() > 0 ) {
						 str = str+ ", ";
					 }
					 
					 hashDate.put(HOLIDAY_REMARK, str + leaveReqRow.get("LeaveFormDesc") + "<br/>(" + leaveDateStr
				    			+ " จำนวนวันที่ลา " + leaveReqRow.get("takeLeaveDays") + " วัน)");
					 
					 loopDate = loopDate.plusDays(1);
				 }
				 
			 }
			
			
		 } catch (ParseException e) {
				e.printStackTrace();
		}
		 
		 
		 
		 
		 return returnList;
		
	}
	

	public void setFrmLeaveWorkTime(String empId, String startDate,String endDate){
		
		 Integer yearCE; 
		 if(startDate != null && startDate.length() == 8) {
			 yearCE = Integer.parseInt(startDate.substring(0, 4)) - 543;
			 startDate = yearCE + startDate.substring(4,startDate.length());
			 
		 }
		 
		 if(endDate != null && endDate.length() == 8) {
			 yearCE = Integer.parseInt(endDate.substring(0, 4)) - 543;
			 endDate = yearCE + endDate.substring(4,endDate.length());
			
		 }

		
        this.setValue(FrmLeaveWorkTime.ELM_NAME_EMP_ID, empId);
        this.setValue(FrmLeaveWorkTime.START_DATE, startDate);
        this.setValue(FrmLeaveWorkTime.END_DATE, endDate);
        this.formList = getFormList(empId, startDate,endDate);
    }
	

}
