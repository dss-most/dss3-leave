package gitex.tu.htmlForm;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import gitex.html.HtmlForm;
import gitex.utility.Database;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class FrmVehicleHistory extends HtmlForm {

    public Logger logger = LoggerFactory.getLogger(this.getClass());

	/** element name budget year */
    public static String ELM_NAME_EMP_ID = "empId";

    /** element name budget year */
    public static String ELM_NAME_BUDGET_YEAR = "budgetYear";

    /** a list contains all form status of the user */
    public ArrayList formList = new ArrayList();
    
    /** Creates a new instance of FrmVehicleHistory */
    public FrmVehicleHistory(HttpSession session, HttpServletRequest request){
        ArrayList elmName = new ArrayList();
        elmName.add(ELM_NAME_EMP_ID);
        elmName.add(ELM_NAME_BUDGET_YEAR);
        this.setValues(request, elmName);
        String empId = this.getValue(ELM_NAME_EMP_ID);
        String budgetYear = this.getValue(ELM_NAME_BUDGET_YEAR);
        
        logger.debug(">>>>> vehicle sql :" + budgetYear);
        
        if(!empId.equals("") && !budgetYear.equals("")){
            formList = getFormList(empId, Integer.parseInt(budgetYear));
        }
        
    }
    
    private ArrayList getFormList(String empId, int budgetYear){
    	FrmVehicleReq vehicleReqForm = new FrmVehicleReq();
        Database db = new Database();
        String sql = "";
        sql += " SELECT t1.id, t1.formrunningnum,t1.emp_title, t1.fiscalyear, t2.emp_name ";
        sql += ", TO_CHAR(t1.vehiclerequestdate, 'YYYY-MM-DD') AS vehiclerequestdate";
        sql += ", TO_CHAR(t1.formissuedate, 'YYYY-MM-DD') AS formissuedate";
        sql += ", t1.org_head_work_title, t1.placetogo, t1.reasontogo, t1.remark";
        sql += ", TO_CHAR(t1.vehiclestarttime,'HH24:MI') vehiclestarttime";
        sql += ", TO_CHAR(t1.vehicleendtime, 'HH24:MI') vehicleendtime";
        sql += " FROM hr_vehicle_reqform t1  INNER JOIN hr_employee t2 on t1.emp_id = t2.emp_id ";//, hr_leave_takeLeaveRec t2 ";
        sql += " WHERE t1.emp_id = " + empId;
        sql += " AND t1.fiscalyear = " + budgetYear;
        sql += " ORDER BY t1.formissuedate desc";
        
        logger.debug("vehicle sql :" + sql);
        
        ArrayList field = new ArrayList();
        field.add(FrmVehicleReq.ELM_NAME_ID);
        field.add(FrmVehicleReq.ELM_NAME_FISCALYEAR);
        field.add(FrmVehicleReq.ELM_NAME_FORM_RUNNING_NUM);
        field.add(FrmVehicleReq.ELM_NAME_VEHICLE_REQ_DATE);
        field.add(FrmVehicleReq.ELM_NAME_VEHICLE_START_TIME);
        field.add(FrmVehicleReq.ELM_NAME_VEHICLE_END_TIME);
        field.add(FrmVehicleReq.ELM_NAME_FORM_ISSUE_DATE);
        field.add(FrmVehicleReq.ELM_NAME_ORG_HEAD_WORK_TITLE);
        field.add(FrmVehicleReq.ELM_NAME_PLACE_TO_GO);
        field.add(FrmVehicleReq.ELM_NAME_REASON_TO_GO);
        field.add(FrmVehicleReq.ELM_NAME_REMARK);
        field.add(FrmVehicleReq.ELM_NAME_REQ_NAME);
        field.add(FrmVehicleReq.ELM_NAME_REQ_TITLE);
        
        return db.getResultSet(sql, field, null);
    }
    
    /** Get leave history from the specified emp id and budget year
     * @param empId employee id
     * @param budgetYear budget year
     */
    public void setInfo(String empId, int budgetYear){
        this.setValue(this.ELM_NAME_BUDGET_YEAR, String.valueOf(budgetYear));
        this.setValue(this.ELM_NAME_EMP_ID, String.valueOf(empId));
        this.formList = getFormList(empId, budgetYear);
    }
    
	
}
