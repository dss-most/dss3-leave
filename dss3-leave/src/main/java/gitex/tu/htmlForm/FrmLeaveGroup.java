/*
 * FrmLeaveGroup.java
 *
 * Created on 5 ÁÕ¹Ò¤Á 2550, 12:52 ¹.
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
 * Repersents the frmInCountryLeave01.jsp file
 * @author pantape
 */
public class FrmLeaveGroup {
    /** leave group */
    public static String IN_COUNTRY = "0";
    public static String OUT_COUNTRY = "1";
    
    /** a list of leave type id */
    public ArrayList leaveFormId = new ArrayList();

    /** a list of leave category id */
    private Hashtable leaveCategoryId = new Hashtable();

    /** leave type name */
    private Hashtable leaveFormName = new Hashtable();
    
    /**
     * Creates a new instance of FrmLeaveGroup
     */
    public FrmLeaveGroup(HttpSession session, String leaveGroup) {
        /* Clear form which is stored in the session */
        String formSessionName = "";
        if(session.getAttribute(LutGlobalSessionName.FORM) != null){
            session.removeAttribute(LutGlobalSessionName.FORM);
        }
        if(session.getAttribute(LutGlobalSessionName.SUB_FORM) != null){
            session.removeAttribute(LutGlobalSessionName.SUB_FORM);
        }
        /* When initiated, obtain leave type id and leave type name then store in
         * relevant property
         */
        User user = (User) session.getAttribute(LutGlobalSessionName.USER);
        String sql = "SELECT * FROM hr_leave_formtype ";
        sql += " WHERE (for_male_or_female = 2 ";
        sql += " OR for_male_or_female = " + user.employee.sex + ")";
        sql += " AND for_in_or_out_country = " + leaveGroup;
        sql += " ORDER BY leaveFormType ";
        ArrayList field = new ArrayList();
        field.add("leaveFormType");
        field.add("leaveFormTypeDes");
        field.add("leaveCategory_id");
        Database db = new Database();
        ArrayList data = db.getResultSet(sql, field, null);
        if(data.size() > 0){
            for(int i = 0; i < data.size(); i++){
                String formId = ((Hashtable)data.get(i)).get("leaveFormType").toString();
                leaveFormId.add(formId);
                leaveFormName.put(formId, ((Hashtable)data.get(i)).get("leaveFormTypeDes").toString());
                leaveCategoryId.put(formId, ((Hashtable)data.get(i)).get("leaveCategory_id").toString());
            }
        }
    }
    
    /** Gets leave type name
     * @param leaveFormId leave form id
     * @return a name of the specified leave form id, blank string if the leave form id does not exist
     */
    public String getLeaveFormName(String leaveFormId){        
        if(leaveFormName.containsKey(leaveFormId)){
            return leaveFormName.get(leaveFormId).toString();
        }else
            return "";
    }

    /** Gets leave category id
     * @param leaveFormId leave form id
     * @return leave category id, blank string if the leave form id does not exist
     */
    public String getLeaveCategoryId(String leaveFormId){        
        if(leaveFormName.containsKey(leaveFormId)){
            return leaveCategoryId.get(leaveFormId).toString();
        }else
            return "";
    }
}
