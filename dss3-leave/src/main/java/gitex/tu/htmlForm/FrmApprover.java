/*
 * FrmApprover.java
 *
 * Created on 7 �չҤ� 2550, 16:04 �.
 *
 * To change this template, choose Tools | Template Manager
 * and open the template in the editor.
 */

package gitex.tu.htmlForm;

import javax.servlet.http.*;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.util.*;
import gitex.html.*;
import gitex.tu.*;
import gitex.utility.*;

/**
 * Represents the frmApprover.jsp file
 * @author pantape
 */
public class FrmApprover extends HtmlForm {
	public Logger logger = LoggerFactory.getLogger(this.getClass());
    /** task code of a task who calls this form */
    public static String ELM_NAME_CALLER_TASK_CODE = "callerTaskCode";

    /** menu code of a task who calls this form */
    public static String ELM_NAME_CALLER_MENU_CODE = "callerMenuCode";

    /** search 'first name' element name */
    public static String ELM_NAME_SEARCH_FNAME = "fName";
    
    /** search 'last name' element name */
    public static String ELM_NAME_SEARCH_LNAME = "lName";
        
    /** page number to be view in a search result */
    public static String ELM_NAME_PAGE_NUMBER = "pageNo";

    /** page size to be view in a search result */
    public static String ELM_NAME_PAGE_SIZE = "pageSize";
    
    /** a list of employee from search result */
    public ArrayList searchResult = new ArrayList();
    
    /** element name list */
    private ArrayList elementNameList = new ArrayList();
    
    /** Creates a new instance of FrmApprover */
    public FrmApprover(HttpServletRequest request, String userEmpId) {
        createElementNameList();
        this.setValues(request, elementNameList);
        /*
         * Uses search keyword to get a list of employee who is in a
         * command line of the user having EMP_ID = empId. Page number 
         * if not set, set default to 1. Page size set default to 25.
         */
        String searchKeyword = getValue(this.ELM_NAME_SEARCH_FNAME);
        Database db = new Database();
        ArrayList field = new ArrayList();
        field.add("emp_id");
        String sql = "";
        sql = " SELECT t1.emp_id, t2.emp_name ";
        sql += " FROM hr_leave_commander t1, hr_v_employee t2 ";
        sql += " WHERE t1.issupervisor = 1 ";
        sql += " AND t1.emp_id = t2.emp_id ";
        //sql += " AND t1.emp_id <> " + userEmpId;
        if(!searchKeyword.equals("")) sql += " AND t2.emp_name LIKE '%" + searchKeyword + "%' ";
        sql += " ORDER BY emp_name ";
        //log.debug(sql);
        ArrayList data = db.getResultSet(sql, field, null);
        if(data.size() > 0){
            for(int i = 0; i < data.size(); i++){
                Employee employee = new Employee(((Hashtable)data.get(i)).get("emp_id").toString());
                searchResult.add(employee);
            }
        }
    }

    /** Creates an element name list */
    private void createElementNameList(){
        elementNameList.add(this.ELM_NAME_CALLER_TASK_CODE);
        elementNameList.add(this.ELM_NAME_CALLER_MENU_CODE);
        elementNameList.add(this.ELM_NAME_SEARCH_FNAME);
        elementNameList.add(this.ELM_NAME_SEARCH_LNAME);
    }

}
