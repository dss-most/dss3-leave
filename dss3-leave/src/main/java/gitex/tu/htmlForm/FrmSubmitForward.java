/*
 * FrmSubmitForward.java
 *
 * Created on 9 ����¹ 2550, 10:37 �.
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
 *
 * @author pantape
 */
public class FrmSubmitForward extends HtmlForm {
    /** take leave id */
    public static final String ELM_NAME_TAKE_LEAVE_ID = "takeLeave_id";
    /** approve comment */
    public static final String ELM_NAME_TO_EMP_ID = "to_emp_id";
    /** task result */
    public boolean isSuccess = false;
    /**
     * Creates a new instance of FrmApproveReqDtl
     */
    public FrmSubmitForward(HttpServletRequest request, User user) {
        ArrayList elm = new ArrayList();
        elm.add(ELM_NAME_TAKE_LEAVE_ID);
        elm.add(ELM_NAME_TO_EMP_ID);
        setValues(request, elm);
        Employee emp = new Employee(this.getValue(ELM_NAME_TO_EMP_ID));
        FrmLeaveReq reqForm = new FrmLeaveReq(this.getValue(ELM_NAME_TAKE_LEAVE_ID));
        reqForm.setValue(reqForm.ELM_NAME_USER_EMP_ID, user.employee.empId);
        reqForm.setValue(reqForm.ELM_NAME_LOG_DETAIL, "เปลี่ยนผู้พิจารณาคำร้องเป็น " + emp.fullName);
        reqForm.setValue(reqForm.ELM_NAME_LOG_TYPE, reqForm.FORM_LOG_FORWARD);
        reqForm.setValue(reqForm.ELM_NAME_TO_EMP_ID, this.getValue(ELM_NAME_TO_EMP_ID));
        reqForm.setValue(reqForm.ELM_NAME_FORM_STATE, reqForm.FORM_STATE_UPDATE_STATUS);
        isSuccess = reqForm.doDBTask();
    }
}
