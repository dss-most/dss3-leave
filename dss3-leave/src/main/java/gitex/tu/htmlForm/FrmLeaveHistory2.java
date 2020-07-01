/*
 * FrmLeaveHistory.java
 *
 *
 *
 * To change this template, choose Tools | Template Manager
 * and open the template in the editor.
 */

package gitex.tu.htmlForm;

import javax.servlet.http.*;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.util.*;
import gitex.tu.*;
import gitex.html.*;
import gitex.utility.*;

/**
 *
 * @author pantape
 */
public class FrmLeaveHistory2 extends HtmlForm  {
	public Logger logger = LoggerFactory.getLogger(this.getClass());
	
    /** element name budget year */
    public static String ELM_NAME_EMP_ID = "empId";

    /** element name budget year */
    public static String ELM_NAME_BUDGET_YEAR = "budgetYear";

    /** field name to get take leave id */
    public static final String TAKE_LEAVE_ID = "takeLeave_id";

    /** field name to get leave form type */
    public static final String LEAVE_FORM_TYPE = "leaveFormType";

    /** field name to get form start date */
    public static final String FORM_START_DATE = "formStartDate";

    /** field name to get form end date */
    public static final String FORM_END_DATE = "formEndDate";
    
    /** field name to get form status */
    public static final String REF_TAKELEAVE_ID = "ref_takeleave_id";

    /** field name to get form status */
    public static final String NUM_OF_LEAVE_DAY = "takeLeaveDays";

    /** field name to get form status */
    public static final String FORM_STATUS = "formStatus";
    
    public static final String InTime_Time="intime_time";
    
    /** a list contains all form status of the user */
    public ArrayList formList = new ArrayList();
    
    /** fieldname to get late-absent value */
    public static final String LABS_ID = "labs_id";
    public static final String LABS_DATE = "labs_date";
    public static final String LABS_PERIOD = "labs_period";
    public static final String LABS_TYPE = "labs_type";
    public static final String LABS_COUNT = "labs_count";
    
    /** a list contains the occurence of late, absent and no class of the user */
    public ArrayList labsList = new ArrayList();
    
    /** Creates a new instance of FrmLeaveHistory */
    public FrmLeaveHistory2(HttpSession session, HttpServletRequest request){
        ArrayList elmName = new ArrayList();
        elmName.add(ELM_NAME_EMP_ID);
        elmName.add(ELM_NAME_BUDGET_YEAR);
        this.setValues(request, elmName);
        String empId = this.getValue(ELM_NAME_EMP_ID);
        String budgetYear = this.getValue(ELM_NAME_BUDGET_YEAR);
        if(!empId.equals("") && !budgetYear.equals("")){
            formList = getFormList(empId, Integer.parseInt(budgetYear));
            labsList = getLABSList(empId,  Integer.parseInt(budgetYear));
        }
    }

    /** Creates a new instance of FrmLeaveHistory */
    public FrmLeaveHistory2(String empId, int budgetYear){
        setLeaveHistory(empId, budgetYear);
    }
    
    /** Gets form list from database
     * @paramm empId user emp_id
     * @return array list of hashtable contains form data as following: TAKE_LEAVE_ID, LEAVE_FORM_TYPE,
     * FORM_START_DATE, FORM_END_DATE, REF_TAKELEAVE_ID and NUM_OF_LEAVE_DAY
     */
    private ArrayList getFormList(String empId, int budgetYear){
        FrmLeaveReq reqForm = new FrmLeaveReq();
        Database db = new Database();
        String sql = "";
        sql += " SELECT t1.takeLeave_id, t1.leaveFormType";
        sql += ", TO_CHAR(t1.formStartDate, 'YYYYMMDD') AS formStartDate";
        sql += ", TO_CHAR(t1.formEndDate, 'YYYYMMDD') AS formEndDate";
        sql += ", t1.ref_takeleave_id, NVL(t1.formLeaveDays, 0) AS takeLeaveDays";
        sql += ", t1.formStatus";
        sql += " FROM hr_leave_takeLeaveForm t1";//, hr_leave_takeLeaveRec t2 ";
        sql += " WHERE t1.emp_id = " + empId;
        sql += " AND t1.budgetYear = " + budgetYear;
        //sql += " AND( t1.formStatus = " + reqForm.FORM_STATUS_ALLOW;
        //sql += "  OR t1.formStatus = " + reqForm.FORM_STATUS_PARTIAL_CANCEL + ")";
        //sql += " AND t2.takeLeave_id(+) = t1.takeLeave_id ";
        //sql += " AND (t1.takeLeave_id IN(SELECT takeLeave_id FROM hr_leave_takeLeaveRec WHERE budgetYear = " + budgetYear + ") ";
        //sql += " OR t1.ref_takeleave_id IN(SELECT takeLeave_id FROM hr_leave_takeLeaveRec WHERE budgetYear = " + budgetYear + "))";
        sql += " ORDER BY t1.formStatus, t1.formStartDate, t1.formEndDate, t1.leaveFormType";
        
        ArrayList field = new ArrayList();
        field.add(TAKE_LEAVE_ID);
        field.add(LEAVE_FORM_TYPE);
        field.add(FORM_START_DATE);
        field.add(FORM_END_DATE);
        field.add(NUM_OF_LEAVE_DAY);
        field.add(REF_TAKELEAVE_ID);
        field.add(FORM_STATUS);
        return db.getResultSet(sql, field, null);
    } 

    /** Gets late-absent list from database
     * @paramm empId user emp_id
     * @return array list of hashtable contains form data as following: LABS_DATE, LABS_TYPE,
     * LABS_PERIOD, LABS_COUNT
     */
    private ArrayList getLABSList(String empId, int budgetYear){
        Database db = new Database();
        String sql = "";
        sql += " SELECT labs_id, labs_type, TO_CHAR(labs_date, 'YYYYMMDD') AS labs_date ";
        sql+=" , intime_time ";
        sql += ", labs_period, labs_count";
        sql += " FROM hr_leave_late_absent a";
        sql += " WHERE emp_id = " + empId;
        sql += " AND budgetYear = " + budgetYear;
        sql+=" and not exists ( select *  ";
        sql+=" from hr_leave_takeleaveform ";
        sql+=" where user_emp_id= a.emp_id ";
        sql+=" and budgetyear="+budgetYear;
        sql+=" and a.labs_date between formstartdate and formenddate   ";
        sql += " and ((formstartdateperiod <> 1 and formenddateperiod <> 1)  ";
        sql += "    or(formstartdateperiod = 0 and formenddateperiod = 1)  ";
        sql += "    or(formstartdateperiod = 0 and formenddateperiod = 0))  ";   
        sql+=" and FORMSTATUS='2'   )";
        sql += "  and labs_date <= to_date('30 JUN 2020') ";
        sql += " ORDER BY labs_type, labs_date";
        
        
        logger.debug(sql);
        
        ArrayList field = new ArrayList();
        field.add(LABS_ID);
        field.add(LABS_TYPE);
        field.add(LABS_DATE);
        field.add(InTime_Time);
        field.add(LABS_PERIOD);
        field.add(LABS_COUNT);
        return db.getResultSet(sql, field, null);
    }
    
    /** Get leave history from the specified emp id and budget year
     * @param empId employee id
     * @param budgetYear budget year
     */
    public void setLeaveHistory(String empId, int budgetYear){
        if(!empId.equals("")){
            this.setValue(this.ELM_NAME_BUDGET_YEAR, String.valueOf(budgetYear));
            this.setValue(this.ELM_NAME_EMP_ID, String.valueOf(empId));
            this.formList = getFormList(empId, budgetYear);
            this.labsList = getLABSList(empId, budgetYear);
        }
    }
}
