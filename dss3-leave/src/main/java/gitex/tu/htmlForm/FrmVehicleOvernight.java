package gitex.tu.htmlForm;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import gitex.html.HtmlForm;
import gitex.utility.Database;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class FrmVehicleOvernight extends HtmlForm {

    public Logger logger = LoggerFactory.getLogger(this.getClass());

	/** element name budget year */
    public static String ELM_NAME_EMP_ID = "empId";

    /** element name budget year */
    public static String ELM_NAME_BUDGET_YEAR = "budgetYear";

    /** a list contains all form status of the user */
    public ArrayList formList = new ArrayList();
    
    /** Creates a new instance of FrmVehicleHistory */
    public FrmVehicleOvernight(HttpSession session, HttpServletRequest request){
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
    	FrmVehicleOvernightReq vehicleOvernightReqForm = new FrmVehicleOvernightReq();
        Database db = new Database();
        String sql = "";
        sql += " SELECT t1.id, t1.formrunningnum,t1.emp_title, t1.fiscalyear, t2.emp_name ";
        sql += ", TO_CHAR(t1.formissuedate, 'YYYY-MM-DD') AS formissuedate";
        sql += ", t1.org_head_work_title, t1.reason, t1.status";
        sql += ", TO_CHAR(t1.start_overnight,'YYYY-MM-DD') start_overnight";
        sql += ", TO_CHAR(t1.end_overnight, 'YYYY-MM-DD') end_overnight";
        sql += ", t1.license_number, p1.province_name license_province" ;
        sql += " FROM hr_vehicle_overnight_reqform t1  INNER JOIN hr_employee t2 on t1.emp_id = t2.emp_id ";//, hr_leave_takeLeaveRec t2 ";
        sql += "	INNER JOIN glb_province p1 on t1.license_province_id = p1.province_id ";
        sql += " WHERE t1.emp_id = " + empId;
        sql += " AND t1.fiscalyear = " + budgetYear;
        sql += " ORDER BY t1.formissuedate desc";
        
        logger.debug("vehicle sql :" + sql);
        
        ArrayList field = new ArrayList();
        field.add(FrmVehicleOvernightReq.ELM_NAME_ID);
        field.add(FrmVehicleOvernightReq.ELM_NAME_FISCALYEAR);
        field.add(FrmVehicleOvernightReq.ELM_NAME_FORM_RUNNING_NUM);
        field.add(FrmVehicleOvernightReq.ELM_NAME_START_OVERNIGHT);
        field.add(FrmVehicleOvernightReq.ELM_NAME_END_OVERNIGHT);
        field.add(FrmVehicleOvernightReq.ELM_NAME_FORM_ISSUE_DATE);
        field.add(FrmVehicleOvernightReq.ELM_NAME_ORG_HEAD_WORK_TITLE);
        field.add(FrmVehicleOvernightReq.ELM_NAME_STATUS);
        field.add(FrmVehicleOvernightReq.ELM_NAME_REASON);
        field.add(FrmVehicleOvernightReq.ELM_NAME_REQ_NAME);
        field.add(FrmVehicleOvernightReq.ELM_NAME_REQ_TITLE);
        field.add(FrmVehicleOvernightReq.ELM_NAME_LICENSE_NUMBER);
        field.add(FrmVehicleOvernightReq.ELM_NAME_LICENSE_PROVINCE);
        
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
