/*
 * UserAppModule.java
 *
 * Created on 3 �չҤ� 2550, 12:58 �.
 *
 * To change this template, choose Tools | Template Manager
 * and open the template in the editor.
 */

package gitex.tu;

import javax.servlet.http.*;

import org.jfree.util.Log;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.util.*;
import gitex.utility.*;
import th.go.dss.BuildInfo;

/**
 * Contains module name and permission corresponding to the user roll
 * @author pantape
 */
public class UserAppModule {
	
	public static Logger logger = LoggerFactory.getLogger(UserAppModule.class);
	
    /** a list of module code */
    public ArrayList moduleCode = new ArrayList();
    
    /** permission level for each module */
    private Hashtable permissionLevel = new Hashtable();
    
    /** module name */
    private Hashtable moduleName = new Hashtable();
    
    /** Creates a new blank instance of UserAppModule */
    public UserAppModule(){
        moduleCode.add(LutLeaveReqMenuCode.WELCOME);
        LutLeaveReqMenuCode menuCode = new LutLeaveReqMenuCode();
        moduleName.put(LutLeaveReqMenuCode.WELCOME, menuCode.getMenuName(menuCode.WELCOME));
    }
    
    /** Creates a new instance of UserAppModule 
     * @param roleId roll id
     */
    public UserAppModule(String roleId) {
        /* When iniciated, use the roll id to obtain module code,
         * module permission level and module name and store into
         * the relavant property. For permissionLevel and moduleName
         * property, use moduleCode as a key to get the property value.
         */
        LutLeaveReqMenuCode menuCode = new LutLeaveReqMenuCode();
        
        //moduleCode.add(menuCode.WELCOME);
        //moduleName.put(menuCode.WELCOME, menuCode.getMenuName(menuCode.WELCOME));
        if(!roleId.equals("")){
            Database db = new Database();
            ArrayList field = new ArrayList();
            field.add("progModule_id");
            field.add("rolePermission");
            String sql = "";
            sql = "SELECT t1.* ";
            sql += " FROM hr_leave_rolePermission t1, hr_leave_progModule t2 ";
            sql += " WHERE t1.role_id = " + roleId;
            sql += " AND t1.progModule_id = t2.progModule_id ";
            sql += " AND t2.is_active = 1 ";
            sql += " ORDER BY t1.progModule_id ";
            
            logger.debug(sql);
            
            ArrayList data = db.getResultSet(sql, field, null);
            if(data.size() > 0){
                for(int i = 0; i < data.size(); i++){
                    String module_id = ((Hashtable)data.get(i)).get("progModule_id").toString();
                    String permission = ((Hashtable)data.get(i)).get("rolePermission").toString();
                    moduleCode.add(module_id);
                    moduleName.put(module_id, menuCode.getMenuName(module_id));
                    permissionLevel.put(module_id, permission);

                }
            }
        }
    }
    
    /** Gets module permission level
     * @param moduleCode module code
     * @return string represent permission level, blank string if the module code does not exist
     */
    public String getPermissionLevel(String moduleCode){
        if(permissionLevel.containsKey(moduleCode)){
            return permissionLevel.get(moduleCode).toString();
        }else
            return "";        
    }
    
    /** Gets module name
     * @param moduleCode module code
     * @return module name, blank string if the module code does not exist
     */
    public String getName(String moduleCode){
        if(moduleName.containsKey(moduleCode)){
            return moduleName.get(moduleCode).toString();
        }else
            return "";        
    }
}
