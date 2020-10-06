/*
 * Employee.java
 *
 * Created on 1 �չҤ� 2550, 9:40 �.
 *
 * To change this template, choose Tools | Template Manager
 * and open the template in the editor.
 */

package gitex.tu;

import java.sql.*;
import java.util.*;

import org.jfree.util.Log;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;




import gitex.utility.*;
import gitex.tu.htmlForm.*;

/**
 *
 * @author pantape
 */
public class Employee {
	public Logger logger = LoggerFactory.getLogger(this.getClass());

	
    /** Static value */
    public final String PERIOD_FIRST_HALF_YEAR = "1stHalfYear";
    public final String PERIOD_SECOND_HALF_YEAR = "2ndHalfYear";
    public final String PERIOD_FULL_YEAR = "FullYear";
    /**
     * employee id
     */
    public String empId = "";

    /**
     * birth date
     */
    public String birthDate = "";

    /**
     * start work date
     */
    public String startWorkDate = "";

     /**
     * parent employee id
     */
    public String commanderEmpId = "";


    /**
     * employee full name
     */
    public String fullName = "";
    
    /**
     * employee prefix name
     */
    public String prefixName = "";

    /** employee sex */
    public String sex = "";

    /**
     * employee type
     */
    public String empType = "";
    
    /**
     * top level organization name of this employee
     */
    public String topORGName = "";

    /**
     * top level organization id of this employee
     */
    public String topORGId = "";
    
    /**
     * organization id of this employee
     */
    public String parentORGId = "";

    /**
     * organization name of this employee
     */
    public String parentORGName = "";

    /**
     * work title of this employee
     */
    public String workTitle = "";
    
    /**
     * num of working year
     */
    public int numOfWorkYear = 0;
    
    /** num of working month*/
    public int numOfWorkMonth = 0;
    
    /** max leave day for each leave category */
    private Hashtable maxLeaveDay = new Hashtable();
    
    /** payment for each leave category */
    private Hashtable isLeaveWithoutPay = new Hashtable();

    /** count day type for each leave category */
    private Hashtable isCountOnlyWorkday = new Hashtable();

    /** max amount of day which can be carried forward for each leave category */
    private Hashtable maxCarryForward = new Hashtable();

    /** num of leave day */
    private Hashtable leaveDayCount = new Hashtable();

    /** num of leave day */
    private Hashtable leaveDayCount1stHalfYear = new Hashtable();
    
    /** num of leave day */
    private Hashtable leaveDayCount2ndHalfYear = new Hashtable();

    /** num of req count */
    private Hashtable leaveReqCount = new Hashtable();

    /** num of req count  */
    private Hashtable leaveReqCount1stHalfYear = new Hashtable();

    /** num of req count  */
    private Hashtable leaveReqCount2ndHalfYear = new Hashtable();

    /** flag indicate if leave day count exceeds its limit */
    private Hashtable exeedLimitFlag = new Hashtable();
    
    /** leave name */
    private Hashtable leaveCategoryName = new Hashtable();
    
    /** leave type id list */
    public ArrayList leaveCategoryId = new ArrayList();
    
    /** num of late-absent count */
    private Hashtable labsCount = new Hashtable();
    
    /** late-absent type list */
    public ArrayList labsTypeList = new ArrayList();    
    

	public String idCardNo;    

    /** Creates a new blank instance of Employee */
    public Employee(){}
    
    /** Creates a new instance of Employee 
     * para empId employee id
     */
    public Employee(String empId) {
        /* When iniciated, use the empId to obtain all property values */
        this.empId = empId;
        if(!empId.equals("")) setInitialData();
    }
    
    private void setInitialData(){
        Database db = new Database();
        ArrayList field = new ArrayList();
        field.add("emp_name");
        field.add("emp_type");
        field.add("birth_date");
        field.add("fst_emp_date");
        field.add("sex");
        field.add("pfix_abbr");
        field.add("tit_j_name");
        field.add("parentOrgId");
        field.add("topOrgId");
        field.add("parentOrgName");
        field.add("topOrgName");
        field.add("commanderEmpId");
        field.add("id_card_no");
        //noppol.von Edit 20Feb2017 To Fix The postion and Organization
        String sql = "";
        sql = " SELECT emp_name, emp_type, sex, TO_CHAR(birth_date, 'YYYYMMDD') AS birth_date, TO_CHAR(fst_emp_date, 'YYYYMMDD') as fst_emp_date"; // table hr_v_employee
        sql += ", id_card_no "; //table hr_leave_commander
        sql += ", t2.parent_emp_id AS commanderEmpId "; //table hr_leave_commander
        sql += ", t2.org_id AS parentOrgId "; //table hr_leave_commander
        sql += ", t2.org_org_id AS topOrgId "; //table hr_leave_commander
        sql += ", (SELECT pfix_abbr FROM hr_v_prefix WHERE pfix_id = t1.prefix_pfix_id) AS pfix_abbr "; //table hr_v_prefix
        sql += ", (SELECT tit_j_name FROM hr_v_title_j WHERE tit_j_id = t1.title_j_tt_j_id) AS tit_j_name "; //table hr_v_title_j
        //add
        sql += ", POS_ORG(t3.int_org_id) as parentOrgname ";
        //sql += ", (SELECT org_name FROM glb_v_organization WHERE org_id = t2.org_id) AS parentOrgname"; //table glb_v_organization
        sql += ", (SELECT org_name FROM glb_v_organization WHERE org_id = t2.org_org_id) AS topOrgName"; //table glb_v_organization
        sql += " FROM hr_v_employee t1, hr_leave_commander t2 ";
        //add 
        sql += " , hr_v_head_count t3 " ;
        sql += " WHERE t1.emp_id = " + empId;
        sql += " AND t1.emp_id = t2.emp_id " ;
        //add
        sql += " AND t1.HC_HEAD_COUNT_ID = t3.HEAD_COUNT_ID ";
        
        logger.debug(sql);
        ArrayList data = db.getResultSet(sql, field, null);
        if(data.size() > 0){
            this.prefixName = ((Hashtable)data.get(0)).get("pfix_abbr").toString();
            this.fullName = ((Hashtable)data.get(0)).get("emp_name").toString();
            this.idCardNo = ((Hashtable)data.get(0)).get("id_card_no").toString();
            this.sex = ((Hashtable)data.get(0)).get("sex").toString();
            this.birthDate = ((Hashtable)data.get(0)).get("birth_date").toString();
            this.startWorkDate = ((Hashtable)data.get(0)).get("fst_emp_date").toString();
            this.empType = ((Hashtable)data.get(0)).get("emp_type").toString();
            this.workTitle = ((Hashtable)data.get(0)).get("tit_j_name").toString();
            this.parentORGId = ((Hashtable)data.get(0)).get("parentOrgId").toString();
            //noppol.von 20 Feb2017 : the new orghart call the function that return full Org and position 
            //so get them and splilt with " ";
            //PARENT_ORG TOP_ORG
            String fullParentOrg = ((Hashtable)data.get(0)).get("parentOrgName").toString(); 
            String[] arrFullOrg = fullParentOrg.split(" ");
            
            this.parentORGName = arrFullOrg[0];//((Hashtable)data.get(0)).get("parentOrgName").toString();
            this.topORGId = ((Hashtable)data.get(0)).get("topOrgId").toString();
            this.topORGName = fullParentOrg;//((Hashtable)data.get(0)).get("topOrgName").toString();
            this.commanderEmpId = ((Hashtable)data.get(0)).get("commanderEmpId").toString();
            
            gitex.utility.Date date = new gitex.utility.Date();
            int startWorkYYYYMM = Integer.parseInt(startWorkDate.substring(0, 6));
            this.numOfWorkMonth =  date.getNumOfMonth(startWorkDate, date.getDate(date.DATE_ENG));
            this.numOfWorkYear = numOfWorkMonth/12;
        }
        // get max leave day
        sql = " SELECT t1.*, t2.leaveCategory_name";
        sql += " FROM hr_leave_cat_empType t1, hr_leave_category t2 ";
        sql += " WHERE ";
        sql += " t1.leaveCategory_id = t2.leaveCategory_id ";
        sql += " AND t1.emp_type = '" + this.empType + "' ";
        sql += " AND t1.min_workYears * 12 <= " + this.numOfWorkMonth;
        sql += " AND t1.max_workYears * 12 > " + this.numOfWorkMonth;
        sql += " AND (t1.whichSex =  2 OR t1.whichSex = " + this.sex  + ")";
        sql += " ORDER BY t1.leaveCategory_id";
        //log.debug(sql);
        field.clear();
        field.add("leaveCategory_id");
        field.add("leaveCategory_name");
        field.add("limitDays");
        field.add("countType_leaveDay");
        field.add("isNoSalaryPay");
        field.add("amtDays_accumulate");
        data.clear();
        data = db.getResultSet(sql, field, null);
        if(data.size() > 0){
            for(int i = 0; i < data.size(); i++){
                String leaveCategoryId = ((Hashtable)data.get(i)).get("leaveCategory_id").toString();
                String maxLeaveDay = ((Hashtable)data.get(i)).get("limitDays").toString();
                String isCountWorkDayOnly = ((Hashtable)data.get(i)).get("countType_leaveDay").toString();
                String isLeaveWithoutPay = ((Hashtable)data.get(i)).get("isNoSalaryPay").toString();
                String maxCarryForward = ((Hashtable)data.get(i)).get("amtDays_accumulate").toString();
                String categoryName = ((Hashtable)data.get(i)).get("leaveCategory_name").toString();
                this.leaveCategoryId.add(leaveCategoryId);
                this.maxLeaveDay.put(leaveCategoryId, maxLeaveDay);
                this.isCountOnlyWorkday.put(leaveCategoryId, isCountWorkDayOnly);
                this.isLeaveWithoutPay.put(leaveCategoryId, isLeaveWithoutPay);
                this.maxCarryForward.put(leaveCategoryId, maxCarryForward);
                this.leaveCategoryName.put(leaveCategoryId, categoryName);
            }
        }
    }
    
    /** Gets max leave day
     * @param leaveCategory_id leave category id
     * @return number of maximum leave day of the leave category specified
     */
    public double getMaxLeaveDay(String leaveCategory_id){
        if(this.maxLeaveDay.containsKey(leaveCategory_id)){
            return Double.parseDouble(this.maxLeaveDay.get(leaveCategory_id).toString());
        }else return 0;        
    }

    /** Gets max day which can be carried forward
     * @param leaveCategory_id leave category id
     * @return number of maximum day which can be carried forward of the leave category specified
     */
    public double getMaxCarryForward(String leaveCategory_id){
        if(this.maxCarryForward.containsKey(leaveCategory_id)){
            return Double.parseDouble(this.maxCarryForward.get(leaveCategory_id).toString());
        }else return 0;        
    }

    /** Gets if the specified leave category is a leave without pay
     * @param leaveCategory_id leave category id
     * @return true if the specified leave category is a leave without pay, false otherwise
     */
    public boolean isLeaveWithoutPay(String leaveCategory_id){
        if(this.isLeaveWithoutPay.containsKey(leaveCategory_id)){
            String value = this.isLeaveWithoutPay.get(leaveCategory_id).toString();
            if(value.equals("0")) return false;
            else return true;
        }else return false;        
    }

    /** Gets if the specified leave category, when count leave day, will be count on work day only
     * @param leaveCategory_id leave category id
     * @return true if the specified leave category, when count leave day, will be count on workday only, false otherwise
     */
    public boolean isCountOnlyWorkday(String leaveCategory_id){
        if(this.isCountOnlyWorkday.containsKey(leaveCategory_id)){
            String value = this.isCountOnlyWorkday.get(leaveCategory_id).toString();
            if(value.equals("0")) return true;
            else return false;
        }else return false;        
    }
    
    /** 
     * Get จำนวนวันที่ลาพักผ่อน (หักที่ยกเลิกแล้ว) ของปีงบประมาณนี้
     * @param budgetYear ปีงบประมาณ
     * @param date ค้นหาตั้งแต่วันที่เริมปีงบประมาณจนถึงวันที่
     */
    public double getLeaveStatOfBudgetYearUntil(int budgetYear, String untilDate) {
    	String sql1 = ""
    			+ "SELECT nvl(sum(t2.FORMLEAVEDAYS),0) num "
    			+ "FROM HR_LEAVE_TAKELEAVEFORM t2, HR_LEAVE_TAKELEAVEREC t1 "
    			+ "WHERE t1.TAKELEAVE_ID = t2.TAKELEAVE_ID "
    			+ "		AND t1.BUDGETYEAR = " + budgetYear
    			+ " 	AND t2.EMP_ID = " +  this.empId
    			+ "		AND t2.LEAVEFORMTYPE = 3 "
    			+ "		AND t2.FORMSTARTDATE < TO_DATE('" + untilDate+ "' , 'YYYYMMDD')"   
    			+ "		AND T2.FORMSTATUS < 3";
  
    	String sql2 = ""
    			+ "SELECT nvl(sum(t2.FORMLEAVEDAYS),0) num "
    			+ "FROM HR_LEAVE_TAKELEAVEFORM t2, HR_LEAVE_TAKELEAVEREC t1 "
    			+ "WHERE t1.TAKELEAVE_ID = t2.TAKELEAVE_ID "
    			+ "		AND t1.BUDGETYEAR = " + budgetYear
    			+ " 	AND t2.EMP_ID = " +  this.empId
    			+ "		AND t2.LEAVEFORMTYPE = 3 "
    			+ "		AND t2.FORMSTARTDATE < TO_DATE('" + untilDate+ "' , 'YYYYMMDD')"
    			+ "		AND T2.FORMSTATUS = 3";
    	
    	
    	
    	ArrayList field = new ArrayList();
    	field.add("num");
    	
    	Database db = new Database();
    	Hashtable<String, String> dataType = new Hashtable<String, String>();
    	dataType.put("num", "DOUBLE");
       	ArrayList data = db.getResultSet(sql1, field, dataType);
       	
       	Double num1 = (Double) ((Hashtable)data.get(0)).get("num");
       	
       	data = db.getResultSet(sql2, field, dataType);
       	Double num2 = (Double) ((Hashtable)data.get(0)).get("num");
       	 	
       	
       	return num1-num2;
       	
    }
    
    
    
    /**
     * Get num of leave day for specified budget year 
     * @param budgetYear budget year
     */
    public void getLeaveStat(int budgetYear) {
        String sql = "";
        sql += " SELECT ";
        sql += "  t1.leaveCategory_id ";
        sql += " , SUM(takeLeaveDays) AS takeLeaveDays ";
        sql += " FROM  ";
        sql += " hr_leave_takeLeaveRec t1 ";
        sql += " , hr_leave_takeLeaveFORM t2 ";
        sql += " WHERE  ";
        sql += " t1.takeLeave_id = t2.takeLeave_id ";
        sql += " AND t1.budgetYear = " + budgetYear;
        sql += " AND (t2.formStatus = " + FrmLeaveReq.FORM_STATUS_ALLOW;
        sql += "            OR t2.formStatus = " + FrmLeaveReq.FORM_STATUS_PARTIAL_CANCEL + ") ";
        sql += " AND t2.emp_id = " + this.empId;
        sql += " GROUP BY t1.leaveCategory_id ";
        sql += " ORDER BY t1.leaveCategory_id ";
        //log.debug(sql);
        ArrayList field = new ArrayList();
        field.add("leaveCategory_id");
        field.add("takeLeaveDays");
        Database db = new Database();
        ArrayList data = db.getResultSet(sql, field, null);
        leaveDayCount.clear();
        if(data.size() > 0){
            for(int i = 0; i < data.size(); i++){
                String catId = ((Hashtable)data.get(i)).get("leaveCategory_id").toString();
                leaveDayCount.put(catId, ((Hashtable)data.get(i)).get("takeLeaveDays").toString());
            }
        }
        
        // Counts late-absent
        FrmLateAbsent labsForm = new FrmLateAbsent();
        sql = " SELECT labs_type, sum(labs_count) AS labs_count ";
        sql += " FROM hr_leave_late_absent a ";
        sql += " WHERE emp_id = " + this.empId;
        sql += " AND budgetYear = " + budgetYear;
        sql += " and not exists ( select *  ";
        sql += " from hr_leave_takeleaveform ";
        sql += " where user_emp_id= "+ this.empId;
        sql += " and budgetyear=" + budgetYear;
        sql += " and a.labs_date between formstartdate and formenddate   ";
        sql += " and ((formstartdateperiod <> 1 and formenddateperiod <> 1)  ";
        sql += "    or(formstartdateperiod = 0 and formenddateperiod = 1)  ";
        sql += "    or(formstartdateperiod = 0 and formenddateperiod = 0))  ";                 	
        sql += " and FORMSTATUS='2' )  ";
        sql += " GROUP BY labs_type ";
        sql += " ORDER BY labs_type";
        field.clear();
        field.add("labs_type");
        field.add("labs_count");
        data = db.getResultSet(sql, field, null);
        this.labsTypeList.clear();
        this.labsCount.clear();
        if(data.size() > 0){
            for(int i = 0; i < data.size(); i++){
                String labsType = ((Hashtable)data.get(i)).get("labs_type").toString();
                String labsCount = ((Hashtable)data.get(i)).get("labs_count").toString();
                this.labsTypeList.add(labsType);
                this.labsCount.put(labsType, labsCount);
            }
        }        
    }
    
    /**
     * Get num of leave day in a period of first six month or last six month for specified budget year
     * @param period first half year or second half year
     * @param budgetYear budget yer
     */
    public void getLeaveStat(String period, int budgetYear) {
        String startMMDD = "";
        String endMMDD = "";
        if(period.equals(this.PERIOD_FIRST_HALF_YEAR)){
            startMMDD =  String.valueOf(budgetYear - 1) + "1001";
            endMMDD = String.valueOf(budgetYear) + "0331";
        }else if(period.equals(this.PERIOD_SECOND_HALF_YEAR)){
            startMMDD = String.valueOf(budgetYear) + "0401";
            endMMDD = String.valueOf(budgetYear) + "0930";
        }else{
            startMMDD = String.valueOf(budgetYear - 1) + "1001";
            endMMDD = String.valueOf(budgetYear) + "0930";            
        }
        String sql = "";
        sql += " SELECT ";
        sql += "  t1.leaveCategory_id ";
        sql += " , SUM(takeLeaveDays) AS takeLeaveDays ";
        sql += " FROM  ";
        sql += " hr_leave_takeLeaveRec t1 ";
        sql += " , hr_leave_takeLeaveFORM t2 ";
        sql += " WHERE  ";
        sql += " t1.takeLeave_id = t2.takeLeave_id ";
        sql += " AND TO_CHAR(t1.endDate, 'YYYYMMDD') >= '" + startMMDD + "'";
        sql += " AND TO_CHAR(t1.endDate, 'YYYYMMDD') <= '" + endMMDD + "'";
        sql += " AND t1.budgetYear = " + budgetYear;
        sql += " AND (t2.formStatus = " + FrmLeaveReq.FORM_STATUS_ALLOW;
        sql += "            OR t2.formStatus = " + FrmLeaveReq.FORM_STATUS_PARTIAL_CANCEL + ") ";
        sql += " AND t2.emp_id = " + this.empId;
        sql += " GROUP BY t1.leaveCategory_id ";
        sql += " ORDER BY t1.leaveCategory_id ";
        //log.debug(sql);
        ArrayList field = new ArrayList();
        field.add("leaveCategory_id");
        field.add("takeLeaveDays");
        Database db = new Database();
        ArrayList data = db.getResultSet(sql, field, null);
        Hashtable leaveDayCount = new Hashtable();
        if(data.size() > 0){
            for(int i = 0; i < data.size(); i++){
                String catId = ((Hashtable)data.get(i)).get("leaveCategory_id").toString();
                leaveDayCount.put(catId, ((Hashtable)data.get(i)).get("takeLeaveDays").toString());
            }
        }
        if(period.equals(this.PERIOD_FIRST_HALF_YEAR)){
            this.leaveDayCount1stHalfYear = leaveDayCount;
        }else if(period.equals(this.PERIOD_SECOND_HALF_YEAR)){
            this.leaveDayCount2ndHalfYear = leaveDayCount;
        }else{
            this.leaveDayCount = leaveDayCount;
        }
    }

    /**
     * Get num of leave request made in a period of first six month or last six month for specified budget year
     * @param period first half year or second half year or full year
     * @param budgetYear budget yer
     */
    public void getReqCount(String period, int budgetYear) {
        String startMMDD = "";
        String endMMDD = "";
        if(period.equals(this.PERIOD_FIRST_HALF_YEAR)){
            startMMDD =  String.valueOf(budgetYear - 1) + "1001";
            endMMDD = String.valueOf(budgetYear) + "0331";
        }else if(period.equals(this.PERIOD_SECOND_HALF_YEAR)){
            startMMDD = String.valueOf(budgetYear) + "0401";
            endMMDD = String.valueOf(budgetYear) + "0930";
        }else{
            startMMDD = String.valueOf(budgetYear - 1) + "1001";
            endMMDD = String.valueOf(budgetYear) + "0930";            
        }
        String sql = "";
        sql += " SELECT ";
        sql += "  t1.leaveCategory_id ";
        sql += " , COUNT(*) AS numOfItem ";
        sql += " FROM  ";
        sql += " hr_leave_takeLeaveRec t1 ";
        sql += " , hr_leave_takeLeaveForm t2 ";
        sql += " WHERE  ";
        sql += " t1.takeLeave_id = t2.takeLeave_id ";
        sql += " AND t1.takeLeaveDays >= 1";
        sql += " AND TO_CHAR(t1.endDate, 'YYYYMMDD') >= '" + startMMDD + "'";
        sql += " AND TO_CHAR(t1.endDate, 'YYYYMMDD') <= '" + endMMDD + "'";
        sql += " AND t1.budgetYear = " + budgetYear;
        sql += " AND (t2.formStatus = " + FrmLeaveReq.FORM_STATUS_ALLOW;
        sql += "            OR t2.formStatus = " + FrmLeaveReq.FORM_STATUS_PARTIAL_CANCEL + ") ";
        sql += " AND t2.emp_id = " + this.empId;
        sql += " GROUP BY t1.leaveCategory_id ";
        sql += " ORDER BY t1.leaveCategory_id ";
        //log.debug(sql);
        ArrayList field = new ArrayList();
        field.add("leaveCategory_id");
        field.add("numOfItem");
        Database db = new Database();
        ArrayList data = db.getResultSet(sql, field, null);
        Hashtable leaveReqCount = new Hashtable();
        if(data.size() > 0){
            for(int i = 0; i < data.size(); i++){
                String catId = ((Hashtable)data.get(i)).get("leaveCategory_id").toString();
                leaveReqCount.put(catId, ((Hashtable)data.get(i)).get("numOfItem").toString());
            }
        }
        sql = " SELECT ";
        sql += "  t1.leaveCategory_id ";
        sql += " , COUNT(*) AS numOfItem ";
        sql += " FROM  ";
        sql += " hr_leave_takeLeaveRec t1 ";
        sql += " , hr_leave_takeLeaveForm t2 ";
        sql += " WHERE  ";
        sql += " t1.takeLeave_id = t2.takeLeave_id ";
        sql += " AND t1.takeLeaveDays = 0.5";
        sql += " AND TO_CHAR(t1.endDate, 'YYYYMMDD') >= '" + startMMDD + "'";
        sql += " AND TO_CHAR(t1.endDate, 'YYYYMMDD') <= '" + endMMDD + "'";
        sql += " AND t1.budgetYear = " + budgetYear;
        sql += " AND (t2.formStatus = " + FrmLeaveReq.FORM_STATUS_ALLOW;
        sql += "            OR t2.formStatus = " + FrmLeaveReq.FORM_STATUS_PARTIAL_CANCEL + ") ";
        sql += " AND t2.emp_id = " + this.empId;
        sql += " GROUP BY t1.leaveCategory_id ";
        sql += " ORDER BY t1.leaveCategory_id ";
        //log.debug(sql);
        data = db.getResultSet(sql, field, null);
        if(data.size() > 0){
            for(int i = 0; i < data.size(); i++){
                String catId = ((Hashtable)data.get(i)).get("leaveCategory_id").toString();
                double numOfItem = Double.parseDouble(((Hashtable)data.get(i)).get("numOfItem").toString());
                double numOfReq = numOfItem/2;        
                if(leaveReqCount.containsKey(catId)){
                    numOfReq += Double.parseDouble(leaveReqCount.get(catId).toString());
                    leaveReqCount.remove(catId);                    
                }
                leaveReqCount.put(catId, String.valueOf(numOfReq));
            }
        }
        if(period.equals(this.PERIOD_FIRST_HALF_YEAR)){
            this.leaveReqCount1stHalfYear = leaveReqCount;
        }else if(period.equals(this.PERIOD_SECOND_HALF_YEAR)){
            this.leaveReqCount2ndHalfYear = leaveReqCount;
        }else{
            this.leaveReqCount = leaveReqCount;
        }
    }
    
    /**
     * Get num of carry forward day for specified budget year and category id 
     * @param budgetYear budget yer
     * @param categoryId category id
     * @return amount of carry forward day
     */
    public double getAmountCarryForward(int budgetYear, String categoryId) {
        String sql = "";
        sql += " SELECT ";
        sql += "  NVL(amount, 0) AS amount ";
        sql += " FROM  ";
        sql += " hr_leave_carryForward ";
        sql += " WHERE  ";
        sql += " emp_id = " + this.empId;
        sql += " AND budget_year = " + budgetYear;
        sql += " AND leaveCategory_id = " + categoryId;
        
        ArrayList field = new ArrayList();
        field.add("amount");
        Database db = new Database();
        ArrayList data = db.getResultSet(sql, field, null);
        double amount = 0;
        if(data.size() > 0){
            for(int i = 0; i < data.size(); i++){
                amount = Double.parseDouble (((Hashtable)data.get(i)).get("amount").toString());
            }
        }
        System.out.println("test :" + sql);
        System.out.println("sss :" + amount);
        return amount;
    }
    
    /** Gets leave category name
     * @param leaveCatId leave category id
     * @return a name of the specified leave category id, blank string if the leave type id does not exist
     */
    public String getLeaveCategoryName(String leaveCatId){        
        if(leaveCategoryName.containsKey(leaveCatId)){
            return leaveCategoryName.get(leaveCatId).toString();
        }else
            return "";
    }

    /** Gets total of leave day for each leave type
     * @param leaveCatId leave category id
     * @return num of leave day count, 0 if leave type does not exist
     */
    public double getNumOfLeaveDay(String leaveCatId){        
        if(leaveDayCount.containsKey(leaveCatId)){
            return Double.parseDouble(leaveDayCount.get(leaveCatId).toString());
        }else
            return 0.0;
    }

    /** Gets total of leave day for each leave type
     * @param leaveCatId leave category id
     * @param period period of the year
     * @return num of leave day count, 0 if leave type does not exist
     */
    public double getNumOfLeaveDay(String leaveCatId, String period){ 
        Hashtable leaveDayCount = new Hashtable();
        if(period.equals(this.PERIOD_FIRST_HALF_YEAR)){
           leaveDayCount  = this.leaveDayCount1stHalfYear;
        }else if(period.equals(this.PERIOD_SECOND_HALF_YEAR)){
           leaveDayCount  = this.leaveDayCount2ndHalfYear;
        }else{
           leaveDayCount = this.leaveDayCount;
        }
        if(leaveDayCount.containsKey(leaveCatId)){
            return Double.parseDouble(leaveDayCount.get(leaveCatId).toString());
        }else
            return 0.0;
    }

    /** Gets total of request made for each leave type
     * @param leaveCatId leave category id
     * @param period period of the year
     * @return num of request made, 0 if leave type does not exist
     */
    public double getNumOfRequest(String leaveCatId, String period){ 
        Hashtable leaveReqCount = new Hashtable();
        if(period.equals(this.PERIOD_FIRST_HALF_YEAR)){
            leaveReqCount = this.leaveReqCount1stHalfYear;
        }else if(period.equals(this.PERIOD_SECOND_HALF_YEAR)){
            leaveReqCount = this.leaveReqCount2ndHalfYear;
        }else{
            leaveReqCount = this.leaveReqCount;
        }
        if(leaveReqCount.containsKey(leaveCatId)){
            return Double.parseDouble(leaveReqCount.get(leaveCatId).toString());
        }else
            return 0.0;
    }
    
    /** Gets value indicates whether the leave day count exceeds its limit
     * @param leaveCatId leave type id
     * @return 1 if the leave day count exceeds its limit, 0 if it does not exceed and -1 if it does not exist
     */
    public boolean isLeaveOutOfLimit(String leaveCatId){        
        if(this.getMaxLeaveDay(leaveCatId) - this.getNumOfLeaveDay(leaveCatId) >= 0)
            return false;
        else 
            return true;
    }
    
    /** Gets total of late-absent day for each late-absent type
     * @param labsType late-absent type
     * @return num of late-absent day count, 0 if leave type does not exist
     */
    public double getNumOfLabs(String labsType){        
        if(this.labsCount.containsKey(labsType)){
            return Double.parseDouble(this.labsCount.get(labsType).toString());
        }else
            return 0.0;
    }    
}
