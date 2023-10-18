/*
 * FrmLeaveHistory.java
 *
 * Created on 7 àÁÉÒÂ¹ 2550, 23:44 ¹.
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
public class FrmLeaveHistory extends HtmlForm  {
    public Logger logger = LoggerFactory.getLogger(this.getClass());    


    /** element name budget year */
    public static String ELM_NAME_EMP_ID = "empId";

    /** element name budget year */
    public static String ELM_NAME_BUDGET_YEAR = "budgetYear";

    /** field name to get take leave id */
    public static final String TAKE_LEAVE_ID = "takeLeave_id";

    /** field name to get leave form type */
    public static final String LEAVE_FORM_TYPE = "leaveFormType";

    /** field name to get form issue date */
    public static final String FORM_ISSUE_DATE = "formIssueDate";
    
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
    
    /** a list contains all form status of the user */
    public ArrayList formList = new ArrayList();
    
    /** Creates a new instance of FrmLeaveHistory */
    public FrmLeaveHistory(HttpSession session, HttpServletRequest request){
        ArrayList elmName = new ArrayList();
        elmName.add(ELM_NAME_EMP_ID);
        elmName.add(ELM_NAME_BUDGET_YEAR);
        this.setValues(request, elmName);
        String empId = this.getValue(ELM_NAME_EMP_ID);
        String budgetYear = this.getValue(ELM_NAME_BUDGET_YEAR);
        if(!empId.equals("") && !budgetYear.equals("")){
            formList = getFormList(empId, Integer.parseInt(budgetYear));
        }
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
        sql += ", t1.formStatus, TO_CHAR(t1.formissuedate, 'YYYYMMDD') AS formIssueDate";
        sql += " FROM hr_leave_takeLeaveForm t1";//, hr_leave_takeLeaveRec t2 ";
        sql += " WHERE t1.emp_id = " + empId;
        sql += " AND t1.budgetYear = " + budgetYear;
        //sql += " AND( t1.formStatus = " + reqForm.FORM_STATUS_ALLOW;
        //sql += "  OR t1.formStatus = " + reqForm.FORM_STATUS_PARTIAL_CANCEL + ")";
        //sql += " AND t2.takeLeave_id(+) = t1.takeLeave_id ";
        //sql += " AND (t1.takeLeave_id IN(SELECT takeLeave_id FROM hr_leave_takeLeaveRec WHERE budgetYear = " + budgetYear + ") ";
        //sql += " OR t1.ref_takeleave_id IN(SELECT takeLeave_id FROM hr_leave_takeLeaveRec WHERE budgetYear = " + budgetYear + "))";
        sql += " ORDER BY t1.formStartDate desc, t1.takeLeave_id desc, t1.leaveFormType, t1.formStatus";
        
        ArrayList field = new ArrayList();
        field.add(TAKE_LEAVE_ID);
        field.add(LEAVE_FORM_TYPE);
        field.add(FORM_START_DATE);
        field.add(FORM_END_DATE);
        field.add(NUM_OF_LEAVE_DAY);
        field.add(REF_TAKELEAVE_ID);
        field.add(FORM_STATUS);
        field.add(FORM_ISSUE_DATE);

        logger.debug("getFormList SQL:"  + sql);
        return db.getResultSet(sql, field, null);
    }
    
    /** Get leave history from the specified emp id and budget year
     * @param empId employee id
     * @param budgetYear budget year
     */
    public void setLeaveHistory(String empId, int budgetYear){
        this.setValue(this.ELM_NAME_BUDGET_YEAR, String.valueOf(budgetYear));
        this.setValue(this.ELM_NAME_EMP_ID, String.valueOf(empId));
        this.formList = getFormList(empId, budgetYear);
    }
}
