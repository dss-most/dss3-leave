/*
 * SysAdmin.java
 *
 * Created on 27 พฤษภาคม 2550, 23:42 น.
 *
 * To change this template, choose Tools | Template Manager
 * and open the template in the editor.
 */

package gitex.tu;

import gitex.utility.Database;
import javax.servlet.http.*;
import java.util.*;
import gitex.html.*;
import gitex.tu.htmlForm.*;
import gitex.tu.ldapAuth;
import java.sql.*;

/**
 *
 * @author pantape
 */
public class SysAdmin {
    /** Static value */
    public static String GLOBAL_SCOPE = "1";
    public static String LOCAL_SCOPE = "0";
    public static String EMP_ID = "emp_id";
    public static String ROLE_ID = "role_id";
    public static String ROLE_SCOPE = "role_scope";
    /** Private variables */
    private ArrayList idList = new ArrayList();
    private Hashtable roleName = new Hashtable();
    /** Creates a new instance of SysAdmin */
    public SysAdmin() {
        getInitialData();
    }
    /** Gets role name of each admin role */
    private void getInitialData(){
        Database db = new Database();
        String sql = "";
        sql = "SELECT role_id, roleDescription FROM hr_leave_userRole WHERE role_type = 1 ORDER BY role_id";
        ArrayList field = new ArrayList();
        field.add("role_id");
        field.add("roleDescription");
        ArrayList data = db.getResultSet(sql, field, null);
        if(data.size() > 0){
            for(int i = 0; i < data.size(); i++){
                String roleId = "";
                String desc = "";
                roleId = ((Hashtable)data.get(i)).get("role_id").toString();
                desc = ((Hashtable)data.get(i)).get("roleDescription").toString();
                roleName.put(roleId, desc);
                idList.add(roleId);
            }
        }        
    }
    /** Gets employee who is a system admin
     * @return a list of hash table contains emp_id, role_id and role_scope of a admin user
     */
    public ArrayList getAdminList(){
        Database db = new Database();
        String sql = "";
        ArrayList list = new ArrayList();
        sql = "SELECT emp_id, admin_role, role_scope FROM hr_leave_user";
        sql += " WHERE admin_role IS NOT NULL";
        ArrayList field = new ArrayList();
        field.add("emp_id");
        field.add("admin_role");
        field.add("role_scope");
        ArrayList data = db.getResultSet(sql, field, null);
        if(data.size() > 0){
            for(int i = 0; i < data.size(); i++){
                String empId = "";
                String roleId = "";
                String scope = "";
                empId = ((Hashtable)data.get(i)).get("emp_id").toString();
                roleId = ((Hashtable)data.get(i)).get("admin_role").toString();
                scope = ((Hashtable)data.get(i)).get("role_scope").toString();
                Hashtable hash = new Hashtable();
                hash.put(this.EMP_ID, empId);
                hash.put(this.ROLE_ID, roleId);
                hash.put(this.ROLE_SCOPE, scope);
                list.add(hash);
            }
        }
        return list;
    }
    
    /** Gets admin role id list
     * @return arraylist of role id
     */
    public ArrayList getRoleIdList(){
        return idList;
    }
    
    /** Gets role description specified by role id
     * @param roleId role id
     * @return description string of the role, blank string if no such role id
     */
    public String getRoleName(String roleId){
        if(roleName.containsKey(roleId)){
            return roleName.get(roleId).toString();
        }else return "";                
    }
    
    /* Sets a person to be an system admin
     * @param empId id of a person
     * @param roleId admin role id
     * @param roleScope admin scope
     * @return true if success, false otherwise
     */
    public boolean setToAdmin(String[] empId, String roleId, String roleScope){
        boolean res = false;
        String empIdSeq = "";
        if(empId != null){
            for(int i = 0; i < empId.length; i++){
                if(i > 0) empIdSeq += ", ";
                empIdSeq += empId[i];
            }
        }
        Database db = new Database();
        String sql = "";
        sql = "UPDATE hr_leave_user SET ";
        sql += " admin_role = " + roleId;
        sql += ", role_scope = " + roleScope;
        sql += " WHERE emp_id IN(" + empIdSeq + ")";
        res = db.executeUpdate(sql);
        return res;
    }

    /* Removes a person from being an system admin
     * @param empId id of a person
     * @return true if success, false otherwise
     */
    public boolean removeFromAdmin(String[] empId){
        boolean res = false;
        String empIdSeq = "";
        if(empId != null){
            for(int i = 0; i < empId.length; i++){
                if(i > 0) empIdSeq += ", ";
                empIdSeq += empId[i];
            }
        }
        Database db = new Database();
        String sql = "";
        sql = "UPDATE hr_leave_user SET ";
        sql += " admin_role = null";
        sql += ", role_scope = 0";
        sql += " WHERE emp_id IN(" + empIdSeq + ")";
        res = db.executeUpdate(sql);
        return res;
    }
}
