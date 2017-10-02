/*
 * FrmLeaveStatus.java
 *
 * Created on 12 ¡’π“§¡ 2550, 8:48 π.
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
 * Represents the frmLeaveStatus.jsp file
 * @author pantape
 */
public class FrmLeaveStatus extends HtmlForm {
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
    public static final String FORM_STATUS = "formStatus";

    /** field name to get form status */
    public static final String REF_TAKELEAVE_ID = "ref_takeleave_id";

    /** a list contains all form status of the user */
    public ArrayList formList = new ArrayList();
    
    /** Creates a new instance of FrmLeaveStatus */
    public FrmLeaveStatus(User user){
        formList = getFormList(user.employee.empId);
    }
    
    /** Gets form list from database
     * @param empId user emp_id
     * @return array list of hashtable contains form data as following, LEAVE_FORM_TYPE,
     * LEAVE_START_DATE, LEAVE_END_DATE and FORM_STATUS
     */
    private ArrayList getFormList(String empId){
        Database db = new Database();
        String sql = "";
        sql += " SELECT takeLeave_id, leaveFormType";
        sql += ", TO_CHAR(formStartDate, 'YYYYMMDD') AS formStartDate";
        sql += ", TO_CHAR(formEndDate, 'YYYYMMDD') AS formEndDate, formStatus";
        sql += ", ref_takeleave_id";
        sql += " FROM hr_leave_takeLeaveForm ";
        sql += " WHERE emp_id = " + empId;
        sql += " ORDER BY formStatus, formStartDate, formEndDate";
        ArrayList field = new ArrayList();
        field.add(TAKE_LEAVE_ID);
        field.add(LEAVE_FORM_TYPE);
        field.add(FORM_START_DATE);
        field.add(FORM_END_DATE);
        field.add(FORM_STATUS);
        field.add(REF_TAKELEAVE_ID);
        return db.getResultSet(sql, field, null);
    }
    
}
