/*
 * FrmSearchReq.java
 *
 * To change this template, choose Tools | Template Manager
 * and open the template in the editor.
 */

package gitex.tu.htmlForm;
import javax.servlet.http.*;
import java.util.*;
import gitex.html.*;
import gitex.tu.*;
import gitex.utility.*;

/**
 *
 * @author pantape
 */
public class FrmSearchReq extends HtmlForm {
    /** element name */
    public static String ELM_NAME_SEARCH_NAME = "empName";

    /** element name */
    public static String ELM_NAME_SEARCH_SUBMIT_DATE = "reqSubmitDate";

    /** element name */
    public static String ELM_NAME_SEARCH_FORM_TYPE = "reqType";

    /** element name */
    public static String ELM_NAME_SEARCH_FORM_STATUS = "reqStatus";

    /** element name */
    public static String ELM_NAME_SEARCH_BUDGET_YEAR = "reqBudgetYear";
    
    /** element name */
    public static String ELM_NAME_PAGE_NO = "pageNo";

    /** element name */
    public static String ELM_NAME_MAX_ROW = "maxRow";
    
    /** element name */
    public static String ELM_NAME_IS_NEW_SEARCH = "isNewSearch";

    /** field name to get take leave id */
    public final String TAKE_LEAVE_ID = "takeLeave_id";

    /** field name to get req owner name */
    public final String FROM_NAME = "fromName";

    /** field name to get req approver name */
    public final String TO_NAME = "toName";

    /** field name to get leave form type */
    public final String LEAVE_FORM_TYPE = "leaveFormType";

    /** field name to get form submit date */
    public final String SUBMIT_DATE = "formIssueDate";

    /** field name to get form start date */
    public final String FORM_START_DATE = "formStartDate";

    /** field name to get form end date */
    public final String FORM_END_DATE = "formEndDate";
    
    /** field name to get form status */
    public final String FORM_STATUS = "formStatus";

    /** field name to get form status */
    public final String REF_TAKELEAVE_ID = "ref_takeleave_id";

    /** field name to get form status */
    public final String NUM_OF_LEAVE_DAY = "formLeaveDays";

    /** a list contain form data found in search */
    public ArrayList searchResult = new ArrayList();

    /** max item found */
    public int maxItem = 0;
    
    /** flag indicates if there is any key word entered */
    public boolean isContainKeyword = false;
    
    /** session name */
    public String sessionName = "waitingForwardReqSearchForm";

    /** Creates a new instance of FrmSearchReq */
    public FrmSearchReq(HttpSession session, HttpServletRequest request) {
        ArrayList elmName = new ArrayList();
        elmName.add(ELM_NAME_SEARCH_NAME);
        elmName.add(ELM_NAME_SEARCH_SUBMIT_DATE);
        elmName.add(ELM_NAME_SEARCH_FORM_TYPE);
        elmName.add(ELM_NAME_SEARCH_FORM_STATUS);
        elmName.add(ELM_NAME_SEARCH_BUDGET_YEAR);
        elmName.add(ELM_NAME_PAGE_NO);
        elmName.add(ELM_NAME_MAX_ROW);
        elmName.add(ELM_NAME_IS_NEW_SEARCH);
        this.setValues(request, elmName);
        
        if(!this.getValue(ELM_NAME_SEARCH_NAME).equals("")){
            isContainKeyword = true;
        }else if(!this.getValue(ELM_NAME_SEARCH_SUBMIT_DATE).equals("")){
            isContainKeyword = true;
        }else if(!this.getValue(ELM_NAME_SEARCH_FORM_TYPE).equals("")){
            isContainKeyword = true;
        }else if(!this.getValue(ELM_NAME_SEARCH_FORM_STATUS).equals("")){
            isContainKeyword = true;
        }else if(!this.getValue(ELM_NAME_SEARCH_BUDGET_YEAR).equals("")){
            isContainKeyword = true;
        }
         
        if(this.getValue(ELM_NAME_PAGE_NO).equals("")){
            this.setValue(ELM_NAME_PAGE_NO, "1");
        }
        if(this.getValue(ELM_NAME_MAX_ROW).equals("")){
            this.setValue(ELM_NAME_MAX_ROW, "25");
        }
    }
    
    /** Gets form list from database
     */
    public void doSearch(){
        Database db = new Database();
        ArrayList field = new ArrayList();
        ArrayList data = new ArrayList();
        String name = this.getValue(ELM_NAME_SEARCH_NAME);
        String submitDate = this.getValue(ELM_NAME_SEARCH_SUBMIT_DATE);
        String formType = this.getValue(ELM_NAME_SEARCH_FORM_TYPE);
        String formStatus = this.getValue(ELM_NAME_SEARCH_FORM_STATUS);
        String budgetYear = this.getValue(ELM_NAME_SEARCH_BUDGET_YEAR);
        int pageNo = Integer.parseInt(this.getValue(ELM_NAME_PAGE_NO));
        int numOfRow = Integer.parseInt(this.getValue(ELM_NAME_MAX_ROW));
        int minRow = (pageNo - 1) * numOfRow + 1;
        int maxRow = minRow + numOfRow;
        int whereCount = 0;
        String whereText = "";
        if(!name.equals("")){
            if(whereCount > 0) whereText += " AND ";
            whereText += " emp_id IN(SELECT emp_id FROM hr_v_employee WHERE emp_name LIKE '%" + name + "%' )";
            whereCount++;
        }
        if(!submitDate.equals("")){
            if(whereCount > 0) whereText += " AND ";
            whereText += " formIssueDate = TO_DATE('" + submitDate + "', 'YYYYMMDD')";
            whereCount++;
        }
        if(!formType.equals("")){
            if(whereCount > 0) whereText += " AND ";
            whereText += " leaveFormType = " + formType;
            whereCount++;
        }
        if(!formStatus.equals("")){
            if(whereCount > 0) whereText += " AND ";
            whereText += " formStatus = " + formStatus;
            whereCount++;
        }
        if(!budgetYear.equals("")){
            if(whereCount > 0) whereText += " AND ";
            whereText += " budgetYear = " + budgetYear;
            whereCount++;
        }
        String sql = "";
        //Count total item found
        sql += "SELECT count(*) AS numOfItem FROM hr_leave_takeLeaveForm ";
        if(!whereText.equals("")) sql += " WHERE " + whereText;
        field.add("numOfItem");
        data = db.getResultSet(sql, field, null);
        if(data.size() > 0){
            this.maxItem = Integer.parseInt(((Hashtable)data.get(0)).get("numOfItem").toString());
        }
        //Read takeleave_id from database according to page number and max row
        sql = "";
        sql += " SELECT takeLeave_id ";
        sql += " FROM (  SELECT rownum rn, takeLeave_id FROM hr_leave_takeLeaveForm ";
        if(!whereText.equals("")) sql += " WHERE " + whereText;
        sql += " ) d_table";
        sql += " WHERE d_table.rn >= " + minRow;
        sql += " AND d_table.rn < " + maxRow;
        field.clear();
        field.add("takeLeave_id");
        data.clear();
        data = db.getResultSet(sql, field, null);
        String takeLeaveIdList = "";
        if(data.size() > 0){
            for(int i = 0; i < data.size(); i++){
                if(i > 0) takeLeaveIdList += ",";
                takeLeaveIdList += ((Hashtable)data.get(i)).get("takeLeave_id").toString();
            }
        }
        //Retreive data detail
        if(!takeLeaveIdList.equals("")){
            sql = "";
            sql += " SELECT takeLeave_id, leaveFormType";
            sql += ", TO_CHAR(formIssueDate, 'YYYYMMDD') AS formIssueDate";
            sql += ", TO_CHAR(formStartDate, 'YYYYMMDD') AS formStartDate";
            sql += ", TO_CHAR(formEndDate, 'YYYYMMDD') AS formEndDate, formStatus";
            sql += ", ref_takeleave_id, formLeaveDays";
            sql += ", (SELECT emp_name FROM hr_v_employee WHERE emp_id = t1.emp_id) AS fromName";
            sql += ", (SELECT emp_name FROM hr_v_employee t2, hr_leave_token t3 WHERE t3.takeLeave_id = t1.takeLeave_id AND t2.emp_id = t3.to_emp_id) AS toName";
            sql += " FROM hr_leave_takeLeaveForm t1 ";
            sql += " WHERE takeLeave_id IN(" + takeLeaveIdList + ")";
            sql += " ORDER BY formIssueDate, formStartDate, formEndDate";
            field.add(TAKE_LEAVE_ID);
            field.add(FROM_NAME);
            field.add(TO_NAME);
            field.add(SUBMIT_DATE);
            field.add(LEAVE_FORM_TYPE);
            field.add(FORM_START_DATE);
            field.add(FORM_END_DATE);
            field.add(FORM_STATUS);
            field.add(REF_TAKELEAVE_ID);
            field.add(NUM_OF_LEAVE_DAY);
            searchResult = db.getResultSet(sql, field, null);
        }
    }
}
