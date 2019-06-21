package gitex.tu.htmlForm;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import gitex.html.HtmlForm;
import gitex.utility.Database;

public class FrmPromotionHistory extends HtmlForm {

	/** element name budget year */
    public static String ELM_NAME_EMP_ID = "empId";


    /** a list contains all form status of the user */
    public ArrayList formList = new ArrayList();
    
    /** Creates a new instance of FrmVehicleHistory */
    public FrmPromotionHistory(HttpSession session, HttpServletRequest request){
        ArrayList elmName = new ArrayList();
        elmName.add(ELM_NAME_EMP_ID);
        this.setValues(request, elmName);
        String empId = this.getValue(ELM_NAME_EMP_ID);   

    }
    
    private ArrayList getFormList(String nationalId){
    	FrmPromotionReq promotionReqForm = new FrmPromotionReq();
        Database db = new Database();
        String sql = "";
        sql += " SELECT r1.id, r1.fiscalyear, r1.fiscalno, r1.issuedate"
        		+ ", r1.emp_name, r1.emp_national_id, r1.emp_title, r1.emp_title_level "
	            + ", r1.emp_title_no, r1.emp_dept_name, r1.salary_before"
	        	+ ", r1.salary_base, r1.percent_promotion, r1.salary_base, r1.salary_promotion "
	        	+ ", r1.salary_after, r1.additional_allowance, r1.assessment_level"
	        	+ ", r1.remark "
	        	+ " FROM hr_promotionRec r1 "
	        	+ " WHERE r1.emp_national_id = " + nationalId
	        	+ " ORDER BY r1.fiscalyear desc, r1.fiscalno desc";
        
        ArrayList field = new ArrayList();
        field.add(FrmPromotionReq.ELM_NAME_ID);
        field.add(FrmPromotionReq.ELM_NAME_FISCALYEAR);
        field.add(FrmPromotionReq.ELM_NAME_FISCAL_NO);
        field.add(FrmPromotionReq.ELM_NAME_ISSUE_DATE);
        field.add(FrmPromotionReq.ELM_NAME_EMP_NATIONAL_ID);
        field.add(FrmPromotionReq.ELM_NAME_EMP_NAME);
        field.add(FrmPromotionReq.ELM_NAME_EMP_TITLE);
        field.add(FrmPromotionReq.ELM_NAME_EMP_TITLE_LEVEL);
        field.add(FrmPromotionReq.ELM_NAME_EMP_TITLE_NO);
        field.add(FrmPromotionReq.ELM_NAME_DEPT_NAME);
        field.add(FrmPromotionReq.ELM_NAME_SALARY_BEFORE_PROMOTION);
        field.add(FrmPromotionReq.ELM_NAME_SALARY_BASE);
        field.add(FrmPromotionReq.ELM_NAME_EMP_TITLE_NO);
        field.add(FrmPromotionReq.ELM_NAME_PERCENT_PROMOTION);
        field.add(FrmPromotionReq.ELM_NAME_SALARY_PROMTION);
        field.add(FrmPromotionReq.ELM_NAME_SALARY_AFTER_PROMOTION);
        field.add(FrmPromotionReq.ELM_NAME_ADDITIONAL_ALLOWANCE);
        field.add(FrmPromotionReq.ELM_NAME_ASSESSMENT_LEVEL);
        field.add(FrmPromotionReq.ELM_NAME_REMARK);
       
        
        return db.getResultSet(sql, field, null);
    }
    
    /** Get leave history from the specified emp id and budget year
     * @param empId employee id
     */
    public void setInfo(String empId){
        this.setValue(this.ELM_NAME_EMP_ID, String.valueOf(empId));
        this.formList = getFormList(empId);
        
        
    }
    
	
}
