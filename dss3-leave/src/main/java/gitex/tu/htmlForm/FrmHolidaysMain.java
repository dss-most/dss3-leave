/*
 * FrmHolidaysMain.java
 *
 * Created on 14 มิถุนายน 2550, 13:27 น.
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
 *
 * @author pantape
 */
public class FrmHolidaysMain extends HtmlForm  {
    /** element name */
    public static String ELM_NAME_ID = "holidayId";
    
    /** element name */
    public static String ELM_NAME_NAME = "holidayName";
    
    /** element name */
    public static String ELM_NAME_DATE = "holidayDate";
    
    /** element name */
    public static String ELM_NAME_BUDGET_YEAR = "budgetYear";
    
    /** element name */
    public static String ELM_NAME_BUDGET_YEAR_TO_COPPY = "budgetYearToCoppy";

    /** element name */
    public static String ELM_NAME_TASK = "frmHolidaysTask";
    
    /** constant */
    public final String TASK_DELETE = "taskDeleteHolidays";
    public final String TASK_ADD = "taskAddHolidays";
    public final String TASK_COPPY = "taskCoppyHolidays";
    
    /** error msg **/
    public String errMsg = "";

    /** Creates a new instance of FrmHolidaysMain */
    public FrmHolidaysMain(HttpSession session, HttpServletRequest request, User user) {
        ArrayList elmName = new ArrayList();
        elmName.add(ELM_NAME_ID);
        elmName.add(ELM_NAME_NAME);
        elmName.add(ELM_NAME_DATE);
        elmName.add(ELM_NAME_BUDGET_YEAR);
        elmName.add(ELM_NAME_BUDGET_YEAR_TO_COPPY);
        elmName.add(ELM_NAME_TASK);
        this.setValues(request, elmName);
        
        String task = this.getValue(this.ELM_NAME_TASK);
        LeaveHolidays hol = new LeaveHolidays();
        if(task.equals(this.TASK_ADD)){
            String hDate = this.getValue(this.ELM_NAME_DATE);
            String hName = this.getValue(this.ELM_NAME_NAME);
            String budgetYear = this.getValue(this.ELM_NAME_BUDGET_YEAR);
            hol.add(hDate, hName, Integer.parseInt(budgetYear), user);
        }else if(task.equals(this.TASK_DELETE)){
            String [] aId = this.getValues(this.ELM_NAME_ID);
            String cId = "";
            for(int i = 0; i < aId.length; i++){
                if(i > 0) cId += ", ";
                cId += aId[i];
            }
            if(!cId.equals("")) hol.delete(cId);
        }else if(task.equals(this.TASK_COPPY)){
            int fromYear = Integer.parseInt(this.getValue(this.ELM_NAME_BUDGET_YEAR_TO_COPPY));
            int toYear = Integer.parseInt(this.getValue(this.ELM_NAME_BUDGET_YEAR));
            if(!hol.coppy(fromYear, toYear, user)) 
                errMsg = "ไม่สามารถสร้างสำเนาได้";            
        }
    }
}
