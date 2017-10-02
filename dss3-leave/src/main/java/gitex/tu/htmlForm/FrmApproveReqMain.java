/*
 * FrmApproveReqMain.java
 *
 * Created on 12 ¡’π“§¡ 2550, 13:56 π.
 *
 * To change this template, choose Tools | Template Manager
 * and open the template in the editor.
 */

package gitex.tu.htmlForm;

import javax.servlet.http.*;
import java.util.*;
import gitex.tu.*;
import gitex.html.*;
import gitex.utility.*;

/**
 * Represents the frmApproveReqMain.jsp file
 * @author pantape
 */
public class FrmApproveReqMain {
    
    /** field name to get leave id */
    public static final String TAKE_LEAVE_ID = "takeLeave_id";

    /** field name to get leave form type */
    public static final String LEAVE_FORM_TYPE = "leaveFormType";

    /** field name to get form start date */
    public static final String FORM_ISSUE_DATE = "formIssueDate";

    /** field name to get form end date */
    public static final String FORM_OWNER = "formOwner";
    
    /** field name to get form status */
    public static final String FORM_STATUS = "formStatus";

    /** field name to get form status */
    public static final String REF_TAKELEAVE_ID = "ref_takeleave_id";

    /** a list contains all form status of the user */
    public ArrayList formList = new ArrayList();
    
    /** Creates a new instance of FrmLeaveStatus */
    public FrmApproveReqMain(User user){
        formList = getFormList(user.employee.empId);
    }
    
    /** Gets form list from database
     * @param empId user emp_id
     * @return array list of hashtable contains form data as following : TAKE_LEAVE_FORM, LEAVE_FORM_TYPE,
     * LEAVE_START_DATE, LEAVE_END_DATE and FORM_STATUS
     */
    private ArrayList getFormList(String empId){
        Database db = new Database();
        String sql = "";
        sql += " SELECT takeLeave_id, leaveFormType, ref_takeleave_id";
        sql += ", TO_CHAR(formIssueDate, 'YYYYMMDD') AS formIssueDate";
        sql += ", (SELECT emp_name FROM hr_v_employee WHERE emp_id = t1.emp_id) AS formOwner";
        sql += ", formStatus";
        sql += " FROM hr_leave_takeLeaveForm t1 ";
        sql += " WHERE ";
        sql += " formStatus = " + FrmLeaveReq.FORM_STATUS_WAITING;
        sql += " AND takeLeave_id IN(";
        sql += "    SELECT takeLeave_id FROM hr_leave_token ";
        sql += "    WHERE to_emp_id = " + empId;
        sql += "    )";
        sql += " ORDER BY formIssueDate, takeLeave_id";
        ArrayList field = new ArrayList();
        field.add(TAKE_LEAVE_ID);
        field.add(LEAVE_FORM_TYPE);
        field.add(FORM_ISSUE_DATE);
        field.add(FORM_OWNER);
        field.add(FORM_STATUS);
        field.add(REF_TAKELEAVE_ID);
        return db.getResultSet(sql, field, null);
    }
}
