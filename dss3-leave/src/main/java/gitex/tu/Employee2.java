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

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import gitex.utility.*;
import gitex.tu.htmlForm.*;

/**
 *
 * @author pantape
 */
public class Employee2 {
	public Logger logger = LoggerFactory.getLogger(this.getClass());
	
    /** Status value for non existing employee */
    public static final String STATUS_QUIT = "3%";
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
     * employee name
     */
    public String name = "";

    /**
     * employee prefix name
     */
    public String prefixName = "";

    /**
     * employee full name
     */
    public String fullName = "";
    

    /** employee sex */
    public String sex = "";

    /**
     * employee type
     */
    public String empType = "";
    
    /**
     * employee status
     */
    public String status = "";

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
     * organization id sequence of this employee, xxx.xxx.xxx
     */
    public String orgSeq = "";
    
    /**
     * work title of this employee
     */
    public String workTitle = "";
    
    /**
     * C group of this employee
     */
    public String workLevel = "";
  
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

    /** num of late-absent count */
    private Hashtable labsCount = new Hashtable();
    
    /** late-absent type list */
    public ArrayList labsTypeList = new ArrayList();
    
    /** flag indicate if leave day count exceeds its limit */
    private Hashtable exeedLimitFlag = new Hashtable();
    
    /** leave name */
    private Hashtable leaveCategoryName = new Hashtable();
    
    /** leave type id list */
    public ArrayList leaveCategoryId = new ArrayList();


    /** Creates a new blank instance of Employee */
    public Employee2(){}
    
    /** Creates a new instance of Employee 
     * para empId employee id
     */
    public Employee2(String empId) {
        /* When iniciated, use the empId to obtain all property values */
        this.empId = empId;
        if(!empId.equals("")) setInitialData();
    }
    
    private void setInitialData(){
        Database db = new Database();
        ArrayList field = new ArrayList();
        field.add("emp_name");
        field.add("emp_type");
        field.add("status");
        field.add("birth_date");
        field.add("fst_emp_date");
        field.add("sex");
        field.add("c_group");
        field.add("pfix_abbr");
        field.add("tit_j_name");
        field.add("parentOrgId");
        field.add("topOrgId");
        field.add("parentOrgName");
        field.add("topOrgName");
        field.add("orgSeq");
        field.add("commanderEmpId");
        String sql = "";
        sql = " SELECT t1.emp_name, t1.emp_type, t1.status, t1.sex, TO_CHAR(t1.birth_date, 'YYYYMMDD') AS birth_date, TO_CHAR(t1.fst_emp_date, 'YYYYMMDD') as fst_emp_date, t1.c_group"; // table hr_v_employee
        sql += ", t2.parent_emp_id AS commanderEmpId "; //table hr_leave_commander
        sql += ", t2.org_id AS parentOrgId "; //table hr_leave_commander
        sql += ", t2.org_org_id AS topOrgId "; //table hr_leave_commander
        sql += ", t2.org_path AS orgSeq "; //table hr_leave_commander
        sql += ", (SELECT pfix_abbr FROM hr_v_prefix WHERE pfix_id = t1.prefix_pfix_id) AS pfix_abbr "; //table hr_v_prefix
        sql += ", NVL((SELECT tit_j_name FROM hr_v_title_j WHERE tit_j_id = t1.title_j_tt_j_id), ' - ') AS tit_j_name "; //table hr_v_title_j
        sql += ", (SELECT org_name FROM glb_v_organization WHERE org_id = t2.org_id) AS parentOrgname"; //table glb_v_organization
        sql += ", (SELECT org_name FROM glb_v_organization WHERE org_id = t2.org_org_id) AS topOrgName"; //table glb_v_organization
        //sql += ", (SELECT parent_emp_id FROM hr_leave_commander WHERE emp_id = t1.emp_id) AS commanderEmpId"; //table hr_leave_commander
        //sql += ", (SELECT org_id FROM hr_leave_commander WHERE emp_id = t1.emp_id) AS org_org_id"; //table hr_leave_commander
        sql += " FROM hr_v_employee t1, hr_leave_commander t2 ";
        sql += " WHERE t1.emp_id = t2.emp_id ";
        sql += " AND t1.emp_id = " + empId;
        //log.debug(sql);
        ArrayList data = db.getResultSet(sql, field, null);
        if(data.size() > 0){
            this.prefixName = ((Hashtable)data.get(0)).get("pfix_abbr").toString();
            this.name = ((Hashtable)data.get(0)).get("emp_name").toString();
            this.fullName = prefixName + name;
            this.sex = ((Hashtable)data.get(0)).get("sex").toString();
            this.birthDate = ((Hashtable)data.get(0)).get("birth_date").toString();
            this.startWorkDate = ((Hashtable)data.get(0)).get("fst_emp_date").toString();
            this.empType = ((Hashtable)data.get(0)).get("emp_type").toString();
            this.status = ((Hashtable)data.get(0)).get("status").toString();
            this.workTitle = ((Hashtable)data.get(0)).get("tit_j_name").toString();
            this.workLevel = ((Hashtable)data.get(0)).get("c_group").toString();
            this.parentORGId = ((Hashtable)data.get(0)).get("parentOrgId").toString();
            this.parentORGName = ((Hashtable)data.get(0)).get("parentOrgName").toString();
            this.topORGId = ((Hashtable)data.get(0)).get("topOrgId").toString();
            this.topORGName = ((Hashtable)data.get(0)).get("topOrgName").toString();
            this.orgSeq = ((Hashtable)data.get(0)).get("orgSeq").toString();
            this.commanderEmpId = ((Hashtable)data.get(0)).get("commanderEmpId").toString();
            gitex.utility.Date date = new gitex.utility.Date();
            int startWorkYYYYMM = Integer.parseInt(startWorkDate.substring(0, 6));
            this.numOfWorkMonth =  date.getNumOfMonth(startWorkDate, date.getDate(date.DATE_ENG));
            this.numOfWorkYear = numOfWorkMonth/12;

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
     * Get num of leave day for specified budget year 
     * @param budgetYear budget yer
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
        sql += " FROM hr_leave_late_absent ";
        sql += " WHERE emp_id = " + this.empId;
        sql += " AND budgetYear = " + budgetYear;
        sql += " from hr_leave_takeleaveform ";
        sql += " where user_emp_id= "+ this.empId;
        sql += " and budgetyear=" + budgetYear;
        sql += " and a.labs_date between formstartdate and formenddate   ";
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

    /** Gets value indicates whether the leave day count exceeds its limit
     * @param leaveCatId leave type id
     * @return 1 if the leave day count exceeds its limit, 0 if it does not exceed and -1 if it does not exist
     */
    public boolean isLeaveOutOfLimit(String leaveCatId, int budgetYear){
        if(this.getMaxLeaveDay(leaveCatId) - this.getNumOfLeaveDay(leaveCatId) + this.getAmountCarryForward(budgetYear, leaveCatId) >= 0)
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

    /** Check if the specified form type is already present in the specified budget year
     * @param formTypeId form type id
     * @param budgetYear budget year
     * @return true if the specified form type is already present in the specified budget year of this employee
     */
    public boolean isLeaveBefore(String leaveFormType, int budgetYear){
        String sql = "";
        sql += " SELECT ";
        sql += "  takeLeave_id ";
        sql += " FROM  ";
        sql += " hr_leave_takeLeaveForm ";
        sql += " WHERE  ";
        sql += " emp_id = " + this.empId;
        sql += " AND budgetYear = " + budgetYear;
        sql += " AND leaveFormType = " + leaveFormType;
        sql += " AND (formStatus = " + FrmLeaveReq.FORM_STATUS_ALLOW;
        sql += "            OR formStatus = " + FrmLeaveReq.FORM_STATUS_PARTIAL_CANCEL + ")";
        
        ArrayList field = new ArrayList();
        field.add("takeLeave_id");
        Database db = new Database();
        ArrayList data = db.getResultSet(sql, field, null);
        double amount = 0;
        if(data.size() > 0){
            return true;
        }else return false;
    }
}
