/*
 * FrmSubmitApprove.java
 *
  * Created on 12 มีนาคม 2550, 22:00 น.
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
 * Represents the frmSubmitApprove.jsp
 * @author pantape
 */
public class FrmSubmitApprove extends HtmlForm {
    /** approve allow value */
    public static final String ALLOW = "1";
    /** approve not allow value */
    public static final String NOT_ALLOW = "2";
    /** approve forward value */
    public static final String FORWARD = "3";
    /** take leave id */
    public static final String ELM_NAME_TAKE_LEAVE_ID = "takeLeave_id";
    /** approve value */
    public static final String ELM_NAME_APPROVE_VALUE = "approveValue";
    /** approve comment */
    public static final String ELM_NAME_APPROVE_COMMENT = "approveComment";
    /** approve comment */
    public static final String ELM_NAME_TO_EMP_ID = "to_emp_id";
    /** task result */
    public boolean isSuccess = false;
    /**
     * Creates a new instance of FrmApproveReqDtl
     */
    public FrmSubmitApprove(HttpServletRequest request, FrmLeaveReq reqForm, User user) {
        ArrayList elm = new ArrayList();
        elm.add(ELM_NAME_TAKE_LEAVE_ID);
        elm.add(ELM_NAME_APPROVE_VALUE);
        elm.add(ELM_NAME_APPROVE_COMMENT);
        setValues(request, elm);
        
        String formStatus = "";
        reqForm.setValue(reqForm.ELM_NAME_USER_EMP_ID, user.employee.empId);
        if(getValue(this.ELM_NAME_APPROVE_VALUE).equals(ALLOW)){
            reqForm.setValue(reqForm.ELM_NAME_LOG_DETAIL, "อนุญาต");
            reqForm.setValue(reqForm.ELM_NAME_LOG_TYPE, reqForm.FORM_LOG_APPROVE);
            reqForm.setValue(reqForm.ELM_NAME_STATUS, reqForm.FORM_STATUS_ALLOW);
        }else if(getValue(this.ELM_NAME_APPROVE_VALUE).equals(NOT_ALLOW)){
            reqForm.setValue(reqForm.ELM_NAME_LOG_DETAIL, "ไม่อนุญาตเนื่องจาก " + getValue(this.ELM_NAME_APPROVE_COMMENT));
            reqForm.setValue(reqForm.ELM_NAME_LOG_TYPE, reqForm.FORM_LOG_APPROVE);
            reqForm.setValue(reqForm.ELM_NAME_STATUS, reqForm.FORM_STATUS_NOT_ALLOW);
        }else if(getValue(this.ELM_NAME_APPROVE_VALUE).equals(FORWARD)){
            Employee commander = new Employee(user.employee.commanderEmpId);
            if(commander.fullName.equals("")) commander.fullName = "ไม่มี";
            reqForm.setValue(reqForm.ELM_NAME_LOG_DETAIL, "รับทราบและส่งต่อให้ผู้มีอำนาจ(" + commander.fullName + ") พิจารณาต่อไป");
            reqForm.setValue(reqForm.ELM_NAME_LOG_TYPE, reqForm.FORM_LOG_FORWARD);
            reqForm.setValue(reqForm.ELM_NAME_FROM_EMP_ID, user.employee.empId);
            reqForm.setValue(reqForm.ELM_NAME_TO_EMP_ID, commander.empId);
        }
        reqForm.setValue(reqForm.ELM_NAME_FORM_STATE, reqForm.FORM_STATE_UPDATE_STATUS);
        isSuccess = reqForm.doDBTask();
    }
    
    /** Gets approve name 
     * @param value type of approval
     * @return approval name
     */
    public String getApproveName(String value){
        if(value.equals(ALLOW))
            return "อนุญาต";
        else if(value.equals(NOT_ALLOW))
            return "ไม่อนุญาต";
        else if(value.equals(FORWARD))
            return "รับทราบและส่งต่อไปยังผู้มีอำนาจพิจารณา";
        else return "ไม่ระบุ";
    }
}
