/*
 * FrmSysAdmin.java
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
public class FrmSysAdmin extends HtmlForm{
    /** element name */
    public static String ELM_NAME_EMP_ID = "empId";
    /** element name */
    public static String ELM_NAME_ROLE_ID = "roleId";
    /** element name */
    public static String ELM_NAME_ROLE_SCOPE = "adminScope";
    /** element name */
    public static String ELM_NAME_TASK = "task";

    /** task name */
    public final String SET_TO_ADMIN = "1";
    public final String REMOVE_FROM_ADMIN = "2";
    
    /** Creates a new instance of FrmCmdTree */
    public FrmSysAdmin(HttpServletRequest request, User user) {
        ArrayList elmName = new ArrayList();
        elmName.add(ELM_NAME_EMP_ID);
        elmName.add(ELM_NAME_ROLE_ID);
        elmName.add(ELM_NAME_ROLE_SCOPE);
        elmName.add(ELM_NAME_TASK);
        this.setValues(request, elmName);
        
        String userEmpId = user.employee.empId;
        String roleId = this.getValue(ELM_NAME_ROLE_ID);
        String roleScope = this.getValue(ELM_NAME_ROLE_SCOPE);
        String empId[] = this.getValues(ELM_NAME_EMP_ID);
        String task = this.getValue(ELM_NAME_TASK);
        if(!task.equals("")){
            SysAdmin admin = new SysAdmin();
            if(task.equals(SET_TO_ADMIN)){
                admin.setToAdmin(empId, roleId, roleScope);
            }else if(task.equals(REMOVE_FROM_ADMIN)){
                admin.removeFromAdmin(empId);
            }
        }
    }
}
