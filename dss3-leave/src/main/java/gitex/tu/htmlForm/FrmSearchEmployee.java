/*
 * FrmSearchEmployee.java
 * 
 * Created on 12 พฤษภาคม 2550, 15:00 น.
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
public class FrmSearchEmployee extends HtmlForm  {
    /** element name */
    public static String ELM_NAME_KEYWORD = "keyword";
    /** page number to be view in a search result */
    public static String ELM_NAME_PAGE_NO = "pageNo";
    /** page size to be view in a search result */
    public static String ELM_NAME_PAGE_SIZE = "maxRow";
    /** element name */
    public static String ELM_NAME_IS_NEW_SEARCH = "isNewSearch";
    
    /** a list of employee from search result */
    public ArrayList searchResult = new ArrayList();
    
    /** max item found */
    public int maxItem = 0;
    
    /** current page number */
    public int pageNo = 1;
    
    /** current page size */
    public int pageSize = 25;
    
    /** flag indicates if there is any key word entered */
    public boolean isContainKeyword = false;
    
    /** flag indecates if this is a new search request */
    public boolean isNewSearch = false;
    
    /** element name list */
    private ArrayList elementNameList = new ArrayList();
    
    /** Creates a new instance of FrmSearchEmployee */
    public FrmSearchEmployee(HttpServletRequest request) {
        createElementNameList();
        this.setValues(request, elementNameList);
        if(!this.getValue(ELM_NAME_KEYWORD).equals("")){
            isContainKeyword = true;
        }         

        if(!this.getValue(ELM_NAME_IS_NEW_SEARCH).equals("")){
            isNewSearch = true;
        }         

        if(this.getValue(ELM_NAME_PAGE_NO).equals("")){
            this.setValue(ELM_NAME_PAGE_NO, "1");
        }else{
            pageNo = Integer.parseInt(this.getValue(ELM_NAME_PAGE_NO).toString());
        }
        if(this.getValue(ELM_NAME_PAGE_SIZE).equals("")){
            this.setValue(ELM_NAME_PAGE_SIZE, "25");
        }else{
            pageSize = Integer.parseInt(this.getValue(ELM_NAME_PAGE_SIZE).toString());
        }
        
        if(isContainKeyword) doSearch();
    }
    
    /** Creates an element name list */
    private void createElementNameList(){
        elementNameList.add(this.ELM_NAME_KEYWORD);
        elementNameList.add(this.ELM_NAME_PAGE_NO);
        elementNameList.add(this.ELM_NAME_PAGE_SIZE);
        elementNameList.add(this.ELM_NAME_IS_NEW_SEARCH);
    }

    /** Gets form list from database
     */
    public void doSearch(){
        Database db = new Database();
        ArrayList field = new ArrayList();
        ArrayList data = new ArrayList();
        String name = this.getValue(ELM_NAME_KEYWORD);
        int minRow = (pageNo - 1) * pageSize + 1;
        int maxRow = minRow + pageSize;
        int whereCount = 0;
        String sql = "";
        //Count total item found
        sql = " SELECT count(*) AS numOfItem ";
        sql += " FROM hr_v_employee t1, hr_leave_commander t2 ";
        sql += " WHERE t1.emp_name LIKE '%" + name + "%' ";
        sql += " AND t1.emp_id = t2.emp_id ";
        field.add("numOfItem");
        data = db.getResultSet(sql, field, null);
        if(data.size() > 0){
            maxItem = Integer.parseInt(((Hashtable)data.get(0)).get("numOfItem").toString());
        }
        //Read takeleave_id from database according to page number and max row
        sql = " SELECT t1.emp_id ";
        sql += " FROM hr_leave_commander t1, hr_v_employee t2 ";
        sql += " WHERE ";
        sql += " t1.emp_id = t2.emp_id ";
        if(!name.equals("")) sql += " AND t2.emp_name LIKE '%" + name + "%' ";
        sql += " AND rowNum >= " + minRow;
        sql += " AND rowNum < " + maxRow;
        sql += " ORDER BY t2.emp_name ";
        field.clear();
        field.add("emp_id");
        data.clear();
        data = db.getResultSet(sql, field, null);
        if(data.size() > 0){
            for(int i = 0; i < data.size(); i++){
                Employee employee = new Employee(((Hashtable)data.get(i)).get("emp_id").toString());
                searchResult.add(employee);
            }
        }
    }
}

