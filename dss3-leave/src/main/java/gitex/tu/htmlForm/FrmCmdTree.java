/*
 * FrmCmdTree.java
 *
 * Created on 9 เมษายน 2550, 21:29 น.
 *
 * To change this template, choose Tools | Template Manager
 * and open the template in the editor.
 */

package gitex.tu.htmlForm;

import javax.servlet.http.*;
import java.util.*;
import gitex.tu.*;
import gitex.html.*;

/**
 *
 * @author pantape
 */
public class FrmCmdTree extends HtmlForm{
    /** element name */
    public static String ELM_NAME_ORG_ID = "orgId";
    /** element name */
    public static String ELM_NAME_MOVE_TO_ORG_ID = "toOrgId";
    /** element name */
    public static String ELM_NAME_EMP_ID = "empId";
    /** element name */
    public static String ELM_NAME_TASK = "task";

    /** task name */
    public final String SET_TO_COMMANDER = "1";
    public final String SET_TO_SUPERVISOR = "2";
    public final String SET_TO_NORMAL = "3";
    public final String MOVE_EMP = "4";
    
    /** Creates a new instance of FrmCmdTree */
    public FrmCmdTree(HttpServletRequest request, User user) {
        ArrayList elmName = new ArrayList();
        elmName.add(ELM_NAME_ORG_ID);
        elmName.add(ELM_NAME_MOVE_TO_ORG_ID);
        elmName.add(ELM_NAME_EMP_ID);
        elmName.add(ELM_NAME_TASK);
        this.setValues(request, elmName);
        
        String userEmpId = user.employee.empId;
        String orgId = this.getValue(ELM_NAME_ORG_ID);
        String toOrgId = this.getValue(ELM_NAME_MOVE_TO_ORG_ID);
        String empId[] = this.getValues(ELM_NAME_EMP_ID);
        String task = this.getValue(ELM_NAME_TASK);
        if(!orgId.equals("") && empId != null && !task.equals("")){
            LeaveOrg thisOrg = new LeaveOrg(orgId);
            if(task.equals(SET_TO_COMMANDER)){
                thisOrg.setToCommander(empId[0], userEmpId);
            }else if(task.equals(SET_TO_SUPERVISOR)){
                thisOrg.setToSupervisor(empId[0], userEmpId);
            }else if(task.equals(SET_TO_NORMAL)){
                thisOrg.setToNormal(empId[0], userEmpId);
            }else if(task.equals(MOVE_EMP)){
                thisOrg.moveEmployee(empId, toOrgId, userEmpId);
            }
        }
    }
    
}
