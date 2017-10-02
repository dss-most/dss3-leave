/*
 * LeaveOrg.java
 *
 * Created on 9 เมษายน 2550, 13:44 น.
 *
 * To change this template, choose Tools | Template Manager
 * and open the template in the editor.
 */

package gitex.tu;

import gitex.utility.Database;
import java.util.*;
import gitex.html.*;
import gitex.tu.htmlForm.*;
/**
 *
 * @author pantape
 */
public class LeaveOrg{
    public String orgId = "";
    public String name = "";
    public String parentId = "";
    public ArrayList childId = new ArrayList();
    public ArrayList childName = new ArrayList();
    public String commanderId = "";
    public String commanderName = "";
    public String commanderTitle = "";
    public ArrayList supervisorId = new ArrayList();
    public ArrayList supervisorName = new ArrayList();
    public ArrayList supervisorTitle = new ArrayList();
    public ArrayList empId = new ArrayList();
    public ArrayList empName = new ArrayList();
    public ArrayList empTitle = new ArrayList();
    public ArrayList pathId = new ArrayList();
    public ArrayList pathName = new ArrayList();
    
    /**
     * Creates a new instance of LeaveOrg
     */
    public LeaveOrg() {
    }

    /**
     * Creates a new instance of LeaveOrg
     */
    public LeaveOrg(String orgId) {
        this.orgId = orgId;
        getData();
    }
    
    private void getData(){
        Database db = new Database();
        String sql = "";
        ArrayList field = new ArrayList();
        ArrayList data = new ArrayList();
        
        //Get name and parent id
        sql = " SELECT org_name, NVL(org_org_id, 0) AS org_org_id ";
        sql += " FROM glb_v_organization ";
        sql += " WHERE org_id = " + this.orgId;
        field.add("org_name");
        field.add("org_org_id");
        data = db.getResultSet(sql, field, null);
        if(data.size() > 0){
            this.name = ((Hashtable)data.get(0)).get("org_name").toString();
            this.parentId = ((Hashtable)data.get(0)).get("org_org_id").toString();
        }
        
        //Get child
        sql = " SELECT org_id, org_name ";
        sql += " FROM glb_v_organization ";
        sql += "WHERE ";
        //if(this.orgId.equals("0")) sql += " super_parent_id = 0 AND org_org_id <> 0";
        sql += " org_org_id = " + this.orgId;
        sql += " ORDER BY org_name ";
        field.clear();
        field.add("org_id");
        field.add("org_name");
        data = db.getResultSet(sql, field, null);
        if(data.size() > 0){
            for(int i = 0; i < data.size(); i++){
                childId.add(((Hashtable)data.get(i)).get("org_id").toString());
                childName.add(((Hashtable)data.get(i)).get("org_name").toString());
            }
        }

        //Get commander
        sql = " SELECT t1.emp_id, t2.emp_name ";
        sql += ", NVL((SELECT tit_j_name FROM hr_v_title_j WHERE tit_j_id = t2.title_j_tt_j_id), 'ไม่ระบุ') AS emp_title";
        sql += " FROM hr_leave_commander t1, hr_v_employee t2 ";
        sql += " WHERE t1.org_id = " + this.orgId;
        sql += " AND t1.emp_id = t2.emp_id ";
        sql += " AND t1.isCommander = 1 ";
        sql += " ORDER BY t2.emp_name ";
        field.clear();
        field.add("emp_id");
        field.add("emp_name");
        field.add("emp_title");
        data = db.getResultSet(sql, field, null);
        if(data.size() > 0){
            for(int i = 0; i < data.size(); i++){
                this.commanderId = ((Hashtable)data.get(i)).get("emp_id").toString();
                this.commanderName = ((Hashtable)data.get(i)).get("emp_name").toString();
                this.commanderTitle = ((Hashtable)data.get(i)).get("emp_title").toString();
            }
        }

        //Get supervisor
        sql = " SELECT t1.emp_id, t2.emp_name ";
        sql += ", NVL((SELECT tit_j_name FROM hr_v_title_j WHERE tit_j_id = t2.title_j_tt_j_id), 'ไม่ระบุ') AS emp_title";
        sql += " FROM hr_leave_commander t1, hr_v_employee t2 ";
        sql += " WHERE t1.org_id = " + this.orgId;
        sql += " AND t1.emp_id = t2.emp_id ";
        sql += " AND t1.isCommander = 0 ";
        sql += " AND t1.isSupervisor = 1 ";
        sql += " ORDER BY t2.emp_name ";
        field.clear();
        field.add("emp_id");
        field.add("emp_name");
        field.add("emp_title");
        data = db.getResultSet(sql, field, null);
        if(data.size() > 0){
            for(int i = 0; i < data.size(); i++){
                supervisorId.add(((Hashtable)data.get(i)).get("emp_id").toString());
                supervisorName.add(((Hashtable)data.get(i)).get("emp_name").toString());
                supervisorTitle.add(((Hashtable)data.get(i)).get("emp_title").toString());
            }
        }
        
        //Get employee
        sql = " SELECT t1.emp_id, t2.emp_name ";
        sql += ", NVL((SELECT tit_j_name FROM hr_v_title_j WHERE tit_j_id = t2.title_j_tt_j_id), 'ไม่ระบุ') AS emp_title";
        sql += " FROM hr_leave_commander t1, hr_v_employee t2 ";
        sql += " WHERE t1.org_id = " + this.orgId;
        sql += " AND t1.emp_id = t2.emp_id ";
        sql += " AND t1.isCommander = 0 ";
        sql += " AND t1.isSupervisor = 0 ";
        sql += " ORDER BY t2.emp_name ";
        field.clear();
        field.add("emp_id");
        field.add("emp_name");
        field.add("emp_title");
        data = db.getResultSet(sql, field, null);
        if(data.size() > 0){
            for(int i = 0; i < data.size(); i++){
                empId.add(((Hashtable)data.get(i)).get("emp_id").toString());
                empName.add(((Hashtable)data.get(i)).get("emp_name").toString());
                empTitle.add(((Hashtable)data.get(i)).get("emp_title").toString());
            }
        }
        
        //Get org path
        //pathId.add(this.orgId);
        //pathName.add(this.name);
        String tempId = this.orgId;
        String tempName = "";
        while(Integer.parseInt(tempId) >= 0){
            pathId.add(tempId);
            sql = " SELECT NVL(org_org_id, -1) AS org_org_id, org_name ";
            sql += " FROM glb_v_organization ";
            sql += " WHERE org_id = " + tempId;
            field.clear();
            field.add("org_org_id");
            field.add("org_name");
            data = db.getResultSet(sql, field, null);
            if(data.size() > 0){
                tempId = ((Hashtable)data.get(0)).get("org_org_id").toString();
                tempName = ((Hashtable)data.get(0)).get("org_name").toString();
                pathName.add(tempName);
            }
        }
    }
    
    public void setToCommander(String empId, String userEmpId){
        Database db = new Database();
        String sql = "";
        //Read parent org commander id
        sql = " SELECT emp_id, parent_emp_id ";
        sql += " FROM hr_leave_commander ";
        sql += " WHERE org_id = " + this.orgId;
        sql += " AND isCommander = 1";
        ArrayList field = new ArrayList();
        ArrayList data = new ArrayList();
        field.add("emp_id");
        field.add("parent_emp_id");
        data = db.getResultSet(sql, field, null);
        String parentEmpId = "0";
        String xCommanderEmpId = "0";
        if(data.size() > 0){
            parentEmpId = ((Hashtable)data.get(0)).get("parent_emp_id").toString();
            xCommanderEmpId = ((Hashtable)data.get(0)).get("emp_id").toString();
        }
        
        //Change user role of old commander to normal user
        sql = " UPDATE hr_leave_user SET ";
        sql += " user_role = " + User.ROLE_NORMAL_USER;
        sql += ", user_emp_id = " + userEmpId;
        sql += ", updateDate = SYSDATE";
        sql += " WHERE emp_id = (";
        sql += "         SELECT emp_id FROM hr_leave_commander ";
        sql += "        WHERE ";
        sql += "         org_id = " + this.orgId;
        sql += "        AND isCommander = 1) ";
        db.executeUpdate(sql);
        
        //Set the old commander to normal employee
        sql = " UPDATE hr_leave_commander ";
        sql += " SET isSupervisor = 0, isCommander = 0 ";
        sql += ", user_emp_id = " + userEmpId;
        sql += ", updateDate = SYSDATE";
        sql += " WHERE ";
        sql += " org_id = " + this.orgId;
        sql += " AND isCommander = 1 ";
        db.executeUpdate(sql);

        //Set a commander of the new commander
        sql = " UPDATE hr_leave_commander ";
        sql += " SET isSupervisor = 1, isCommander = 1, parent_emp_id = " + parentEmpId;
        sql += ", user_emp_id = " + userEmpId;
        sql += ", updateDate = SYSDATE";
        sql += " WHERE emp_id = " + empId;
        sql += " AND org_id = " + this.orgId;
        db.executeUpdate(sql);

        //Set a new commander user role to approver
        sql = " UPDATE hr_leave_user SET user_role = " + User.ROLE_APPROVER;
        sql += ", user_emp_id = " + userEmpId;
        sql += ", updateDate = SYSDATE";
        sql += " WHERE emp_id = " + empId;
        db.executeUpdate(sql);
        
        //Set new commander to all employee in the org
        sql = " UPDATE hr_leave_commander ";
        sql += " SET parent_emp_id = " + empId;
        sql += ", user_emp_id = " + userEmpId;
        sql += ", updateDate = SYSDATE";
        sql += " WHERE isCommander = 0 ";
        sql += " AND org_id = " + this.orgId;
        db.executeUpdate(sql);

        //Set new commander to all commander of child org
        if(this.childId.size() > 0){
            String childString = "";
            for(int i = 0; i < this.childId.size(); i++){
                if(i > 0) childString += ",";
                childString += this.childId.get(i).toString();
            }
            sql = " UPDATE hr_leave_commander ";
            sql += " SET parent_emp_id = " + empId;
            sql += ", user_emp_id = " + userEmpId;
            sql += ", updateDate = SYSDATE";
            sql += " WHERE ";
            sql += " org_id IN(" + childString + ")";
            sql += " AND isCommander = 1";
            db.executeUpdate(sql);
        }
        //Change to_emp_id in hr_leave_token to point to new commander
        sql = " UPDATE hr_leave_token SET to_emp_id = " + empId;
        sql += ", user_emp_id = " + userEmpId;
        sql += ", updateDate = SYSDATE";
        sql += " WHERE to_emp_id = " + xCommanderEmpId;
        sql += " AND takeLeave_id IN(";
        sql += "         SELECT takeLeave_id FROM hr_leave_takeLeaveForm ";
        sql += "        WHERE formStatus = " + FrmLeaveReq.FORM_STATUS_WAITING;
        sql += " ) ";
        db.executeUpdate(sql);
        
        getData();
    }

    public void setToSupervisor(String empId, String userEmpId){
        Database db = new Database();
        String sql = "";
        sql = " UPDATE hr_leave_commander ";
        sql += " SET isSupervisor = 1 ";
        sql += ", user_emp_id = " + userEmpId;
        sql += ", updateDate = SYSDATE";
        sql += " WHERE emp_id = " + empId;
        sql += " AND org_id = " + this.orgId;
        db.executeUpdate(sql);
        //Change user role
        sql = " UPDATE hr_leave_user SET user_role = " + User.ROLE_APPROVER;
        sql += ", user_emp_id = " + userEmpId;
        sql += ", updateDate = SYSDATE";
        sql += " WHERE emp_id = (";
        sql += "         SELECT emp_id FROM hr_leave_commander ";
        sql += "        WHERE emp_id = " + empId;
        sql += "        AND org_id = " + this.orgId;
        sql += " ) ";
        db.executeUpdate(sql);

        getData();
    }
    
    public void setToNormal(String empId, String userEmpId){
        Database db = new Database();
        String sql = "";
        sql = " UPDATE hr_leave_commander ";
        sql += " SET isSupervisor = 0, isCommander = 0 ";
        sql += ", user_emp_id = " + userEmpId;
        sql += ", updateDate = SYSDATE";
        sql += " WHERE emp_id = " + empId;
        sql += " AND org_id = " + this.orgId;
        db.executeUpdate(sql);
        
        //Change user role
        sql = " UPDATE hr_leave_user SET user_role = " + User.ROLE_NORMAL_USER;
        sql += ", user_emp_id = " + userEmpId;
        sql += ", updateDate = SYSDATE";
        sql += " WHERE emp_id = (";
        sql += "         SELECT emp_id FROM hr_leave_commander ";
        sql += "        WHERE emp_id = " + empId;
        sql += "        AND org_id = " + this.orgId;
        sql += " ) ";
        db.executeUpdate(sql);

        //Change to_emp_id in hr_leave_token to point to commander if this person is a supervisor before
        sql = " UPDATE hr_leave_token SET to_emp_id = " + this.commanderId;
        sql += ", user_emp_id = " + userEmpId;
        sql += ", updateDate = SYSDATE";
        sql += " WHERE to_emp_id = " + empId;
        sql += " AND takeLeave_id IN(";
        sql += "         SELECT takeLeave_id FROM hr_leave_takeLeaveForm ";
        sql += "        WHERE formStatus = " + FrmLeaveReq.FORM_STATUS_WAITING;
        sql += " ) ";
        db.executeUpdate(sql);
        getData();
    }

    public void moveEmployee(String[] empId, String orgId, String userEmpId){
        Database db = new Database();
        String sql = "";
        String empIdSeq = "";
        for(int i = 0; i < empId.length; i++){
            if(i > 0) empIdSeq += ", ";
            empIdSeq += empId[i];
        }
        Hashtable prevCmd = new Hashtable();
        sql = "SELECT emp_id, parent_emp_id ";
        sql += " FROM hr_leave_commander ";
        sql += " WHERE emp_id IN(" + empIdSeq + ") ";
        ArrayList field = new ArrayList();
        field.add("emp_id");
        field.add("parent_emp_id");
        ArrayList data = db.getResultSet(sql, field, null);
        if(data.size() > 0){
            for(int i = 0; i < data.size(); i++){
                prevCmd.put(((Hashtable)data.get(i)).get("emp_id").toString(), ((Hashtable)data.get(i)).get("parent_emp_id").toString());
            }
        }
        
        //Move to new Org
        LeaveOrg org = new LeaveOrg(orgId);
        if(org.commanderId.equals("")) org.commanderId = "0";
        String orgPath = "";
        for(int i = 0; i < org.pathId.size(); i++){
            if(i > 0) orgPath += ".";
            orgPath += org.pathId.get(org.pathId.size() - i - 1);
        }
        sql = " UPDATE hr_leave_commander SET ";
        sql += " parent_emp_id = " + org.commanderId;
        sql += ", org_id = " + org.orgId;
        sql += ", org_org_id = " + org.parentId;
        sql += ", org_path = '" + orgPath + "' ";
        sql += ", isCommander = 0, isSupervisor = 0, titleLevel_id = 0";
        sql += ", user_emp_id = " + userEmpId;
        sql += ", updateDate = SYSDATE ";
        sql += "WHERE emp_id IN(" + empIdSeq + ")";
        db.executeUpdate(sql);
        
        //Update leave request
        for(int i = 0; i < empId.length; i++){
            sql = "UPDATE hr_leave_token SET ";
            sql += " to_emp_id = " + org.commanderId;
            sql += ", user_emp_id = " + userEmpId;
            sql += ", updateDate = SYSDATE ";
            sql += " WHERE ";
            sql += " from_emp_id = " + empId[i];
            sql += " AND to_emp_id = " + prevCmd.get(empId[i]).toString();
            db.executeUpdate(sql);
        }
    }
}
