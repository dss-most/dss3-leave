/*
 * User.java
 *
 * Created on 26 ����Ҿѹ�� 2550, 9:49 �.
 *
 * To change this template, choose Tools | Template Manager
 * and open the template in the editor.
 */

package gitex.tu;

import gitex.utility.Database;
import javax.servlet.http.*;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.util.*;
import gitex.html.*;
import gitex.tu.htmlForm.*;
import gitex.tu.ldapAuth;
import java.sql.*;

/**
 * Represents the TU application user.
 * @author pantape
 */
public class User {
	public Logger logger = LoggerFactory.getLogger(this.getClass());
    
    /** static value of user ROLE none user. This value indicates
     * the unauthorised user.
     */
    public static String ROLE_NONE_USER = "-1";
    
    public static String ROLE_NORMAL_USER = "1";

    public static String ROLE_APPROVER = "2";

    public static String ROLE_GLOBAL_ADMIN = "100";
    
    public static String ROLE_TYPE_USER = "0";
    
    public static String ROLE_TYPE_ADMIN = "1";

    /** admin scope (local or global)*/
    public boolean isGlobalAdmin = false;

    /** user login name */
    private String loginName = "";
    
    /** user password */
    private String password = "";
    
    /** user emp id */
    private String empId = "";
    
    /** user ROLE for using the application */
    private String userRole = "";

    /** admin ROLE for using the application */
    private String adminRole = "";
    
    /** user employee detail */
    public Employee employee = new Employee();
    
    /** module which user can access */
    public UserAppModule userModule = new UserAppModule();
    
    /** module which admin can access */
    public UserAppModule adminModule = new UserAppModule("");

    /** Creates a new instance of User
     * @param session http session
     * @param request http servlet request
     */
    public User(HttpSession session, HttpServletRequest request, LeaveReqHtmlPage htmlPage) {
        /*
         * When iniciated,  authenticate the user.
         * If the user is not authenticated, set user ROLE to none user for example
         * userRole = ROLE_NONE_USER. Otherwise, create object employee to store
         * user detail, set user ROLE and the other ROLE values and store this user into the session object.
         */
            this.userRole = this.ROLE_NONE_USER;
            FrmUserLogin loginForm = new FrmUserLogin(request);
            loginName = loginForm.getValue(loginForm.ELM_NAME_USERNAME);
            password = loginForm.getValue(loginForm.ELM_NAME_PASSWORD);
            if(!loginName.equals("")){
                if(authenticate(loginName, password)){
                    initialiseUserByEmpId();
                    updateLeaveCarryForward();
                    employee = new Employee(empId);
                    userModule = new UserAppModule(userRole);
                    adminModule = new UserAppModule(adminRole);
                }else{
                    empId = "";
                    userRole = ROLE_NONE_USER;
                    htmlPage.setErrMsg("��辺��������к� ��س��ͧ�ա����");
                }
            }
    }

    /** Creates a new instance of User
     * @param empId employee id of the user
     */
    public User(String empId) {
        this.empId = empId;
        initialiseUserByEmpId();
        updateLeaveCarryForward();
        employee = new Employee(empId);
        userModule = new UserAppModule(userRole);
        adminModule = new UserAppModule(adminRole);     
     }
    
    /** Authenticates user, if the user can be authenticated,
     * the user empId and userRole will be set accordingly
     * @param loginName user login name
     * @param password user login password
     * @return true if user can authenticate, false otherwise
     */
    private boolean authenticate(String loginName, String password){
        /* Authentication process */
        boolean authRes = false;
        Database db = new Database();
        ArrayList field = new ArrayList();
        field.add("emp_emp_id");
        String sql = "";
        sql = "SELECT emp_emp_id ";
        sql += " FROM hr_leave_v_s_user t1 ";
        sql += " WHERE ";
        sql += " t1.login = UPPER('" + loginName + "') ";
        sql += " AND t1.password = '" + password + "'";
        ArrayList data = db.getResultSet(sql, field, null);
        if(data.size() > 0){
            this.empId = ((Hashtable)data.get(0)).get("emp_emp_id").toString();
            authRes = true;
        }
        return authRes;
    }
    
    private void initialiseUserByEmpId(){
        Database db = new Database();
        ArrayList field = new ArrayList();
        field.add("user_role");
        field.add("admin_role");
        field.add("role_scope");
        String sql = "";
        sql = "SELECT user_role, admin_role, role_scope ";
        sql += " FROM hr_leave_user t1 ";
        sql += " WHERE t1.emp_id = " + this.empId;
        ArrayList data = db.getResultSet(sql, field, null);
        if(data.size() > 0){
            this.userRole = ((Hashtable)data.get(0)).get("user_role").toString();
            this.adminRole = ((Hashtable)data.get(0)).get("admin_role").toString();
            String roleScope = "";
            roleScope = ((Hashtable)data.get(0)).get("role_scope").toString();
            if(!adminRole.equals("") && roleScope.equals("1")) this.isGlobalAdmin = true;
        }else{
            //User exists in the main system but not yet in the LEAVE REQUEST system,
            //so the user will be added to this system.
            
            //1. Add the user to table hr_leave_user, set user role to narmal(1), admin role
            // to none(null).
            Employee emp = new Employee();
            emp.empId = this.empId;
            field.clear();
            field.add("emp_name");
            field.add("parentOrgId");
            sql = " SELECT t1.emp_name"; // table hr_v_employee
            sql += ", t2.org_id AS parentOrgId ";// table glb_v_organization
            sql += " FROM hr_v_employee t1, glb_v_organization t2, hr_v_head_count t3";
            sql += " WHERE t1.emp_id = " + empId;
            sql += " AND t1.hc_head_count_id = t3.head_count_id ";
            sql += " AND t3.int_org_id = t2.org_id ";
            //log.debug(sql);
            data = db.getResultSet(sql, field, null);
            if(data.size() > 0){
                emp.fullName = ((Hashtable)data.get(0)).get("emp_name").toString();
                emp.parentORGId = ((Hashtable)data.get(0)).get("parentOrgId").toString();
            }
            this.userRole = "1";
            this.adminRole = "";
            sql = "INSERT INTO hr_leave_user(";
            sql += "emp_id, userDetail, user_role, admin_role, ";
            sql += "role_scope, status, updateDate, user_emp_id";
            sql += ")VALUES(";
            sql += this.empId + ", '" + emp.fullName + "', 1, null, ";
            sql += " 0, 1, SYSDATE, " + this.empId;
            sql += ")";
            db.executeUpdate(sql);
            
            //2. Add the user to table hr_leave_commander
            LeaveOrg org = new LeaveOrg(emp.parentORGId);
            if(org.commanderId.equals("")) org.commanderId = "0";
            String orgPath = "";
            for(int i = 0; i < org.pathId.size(); i++){
                if(i > 0) orgPath += ".";
                orgPath += org.pathId.get(org.pathId.size() - i - 1);
            }
            sql = " INSERT INTO hr_leave_commander(";
            sql += "commander_id, emp_id, parent_emp_id, super_emp_id ";
            sql += ", org_id, org_org_id, org_path ";
            sql += ", isCommander, isSupervisor, titleLevel_id ";
            sql += ", user_emp_id, updateDate ";
            sql += ")VALUES(";
            sql += this.empId + ", " + this.empId + ", " + org.commanderId + ", 0";
            sql += ", " + org.orgId + ", " + org.parentId + ", '" + orgPath + "'";
            sql += ", 0, 0, 0";
            sql += ", " + this.empId + ", SYSDATE";
            sql += ")";
            db.executeUpdate(sql);
        }
    }
    
    /** Update leave carryforward for next budget year
     */
    private void updateLeaveCarryForward(){
        gitex.utility.Date date = new gitex.utility.Date();
        int budgetYear = date.getCurrentBudgetYear();
        Employee employee = new Employee(this.empId);
        employee.getLeaveStat(budgetYear);        
        FrmLeaveReq reqForm = new FrmLeaveReq();
        String leaveCatId = reqForm.getCategoryId(reqForm.FORM_TYPE_VACATION);
        double maxCarryForward = employee.getMaxCarryForward(leaveCatId);
        double maxLeaveDay = employee.getMaxLeaveDay(leaveCatId);
        double usedLeaveDay = employee.getNumOfLeaveDay(leaveCatId);
        double carryForward = employee.getAmountCarryForward(date.getCurrentBudgetYear(), leaveCatId);
        double netCarryForward = 0;
        double leaveDayLeft = maxLeaveDay + carryForward - usedLeaveDay;
        if(leaveDayLeft > maxCarryForward) netCarryForward = maxCarryForward;
        else if(leaveDayLeft > 0) netCarryForward = leaveDayLeft;
        Database db = new Database();
        String sql = "";
        sql = "SELECT carryForward_id ";
        sql += " FROM hr_leave_carryForward ";
        sql += " WHERE emp_id = " + this.empId;
        sql += " AND budget_year = " + (budgetYear + 1);
        sql += " AND leaveCategory_id = " + leaveCatId;
        ArrayList field = new ArrayList();
        field.add("carryForward_id");
        ArrayList data = db.getResultSet(sql, field, null);
        if(data.size() > 0){
            //Update the record
            String carryForwardId = ((Hashtable)data.get(0)).get("carryForward_id").toString();
            sql = " UPDATE hr_leave_carryForward";
            sql += " SET amount = " + netCarryForward;
            sql += ", updateDate = SYSDATE ";
            sql += " WHERE carryForward_id = " + carryForwardId;
            //log.debug(sql);
            db.executeUpdate(sql);
        }else{
            //Create a new record
            sql = "INSERT INTO hr_leave_carryForward";
            sql += "(emp_id, budget_year, leaveCategory_id, amount, user_emp_id, updatedate)";
            sql += "VALUES(";
            sql += this.empId + ", " + (budgetYear + 1) + ", " + leaveCatId + ", " + netCarryForward + ", " + this.empId + ", SYSDATE";
            sql += ")";
            db.executeUpdate(sql);
        }              
    }
    /** Gets user ROLE
     * @return string represent user ROLE
     */
    public String getRole(String roleType){
        if(roleType.equals(this.ROLE_TYPE_USER)) return userRole;
        else if(roleType.equals(this.ROLE_TYPE_ADMIN)) return adminRole;
        else return "";
    }
    
    /** Gets user loginname
     * @return string loginname
     */
    public String getLoginName() {
    	return this.loginName;
    }
    
    public String getLeaveFingerScanToday() {
    	String leaveTime = "";
    	String fingerScanTime = this.getEarliestFingerScanToday();
    	Boolean workTimeLessThan8Hour = false;
    	
    	if( fingerScanTime.equals(" ยังไม่มีการลงเวลาในระบบ ") ) {
    		leaveTime = " ไม่พบข้อมูลการลงเวลาเข้าทำงาน "; 
    		
    		return leaveTime;
    	}
    	
    	logger.debug(fingerScanTime);
    	
    	Integer hour =  Integer.parseInt(fingerScanTime.substring(0, 2));
    	Integer min = Integer.parseInt(fingerScanTime.substring(3, 5));
    	
    	if( hour <= 7 && min < 30 ) {
    		hour = 15;
    		min = 30;
    	} else if(hour < 7) {
    		hour = 15;
    		min = 30;    		
    	} else if  (hour + 8 >= 17 && min > 30) {
    		hour = 17;
    		min = 30;
    		workTimeLessThan8Hour = true;
    		
    	} else {
    		hour = hour + 8;
    	}

    	
    	leaveTime = String.format("%02d" , hour) + ":" + String.format("%02d" , min) + "น.";
    	
    	if(workTimeLessThan8Hour) {
    		leaveTime += "<span style=\"color:red;\"> ปฎิบัติงานไม่ครบ 8 ชม. </span>";
    	}
    	
    	return leaveTime;
    }
    
    public String getEarliestFingerScanToday() {
    	Database db = new Database();
    	
    	
    	String fingerScanTime = " ยังไม่มีการลงเวลาในระบบ ";
    	String currentDate = gitex.utility.Date.getDate(gitex.utility.Date.DATE_ENG);
    	
    	String sql = "select  m.work_date work_date , \n" + 
    			"     to_char( min(m.work_time),'HH24:MI' ) in_time \n" + 
    			"from hr_worktemp m, hr_employee e \n" + 
    			"where m.card_id = e.tag_no \n" + 
    			"    and e.emp_id= " + this.empId + " \n" +
    			"	 and m.work_date = trunc(sysdate) " + 
    			"group by m.work_date \n" +
    			"";
    	
		logger.debug(sql);
    	ArrayList field = new ArrayList();	
    	field.add("IN_TIME");
    	
		 ArrayList data = db.getResultSet(sql, field, null);
		 
		 logger.debug("data.size(): " + data.size());
		 
         if(data.size() > 0){
        	 Hashtable h = (Hashtable)data.get(0);

        	  // Creating an empty enumeration to store 
             Enumeration enu = h.keys(); 
       
             System.out.println("The enumeration of keys are:"); 
       
             // Displaying the Enumeration 
             while (enu.hasMoreElements()) { 
                 logger.debug(enu.nextElement().toString()); 
             } 
        	 
        	 
        	 fingerScanTime = ((Hashtable)data.get(0)).get("IN_TIME").toString() + " น.";
         }
    	
		return fingerScanTime;
    	
    }
}
