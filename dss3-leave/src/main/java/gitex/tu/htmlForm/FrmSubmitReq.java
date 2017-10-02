/*
 * FrmSubmitReq.java
 *
 * Created on 9 พ.ค. 2550, 9:51 น.
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
 * Represents the frmSumitResult.jsp file
 * @author pantape
 */
public class FrmSubmitReq extends HtmlForm{
    /** element name send to emp id */
    public static String ELM_NAME_TO_EMP_ID = "toEmpId";

    /** element name call back menu code on success */
    public static String ELM_NAME_CALLBACK_MENUCODE_ON_SUCCESS = "onSuccessCallbackTaskCode";

    /** element name call back tack code on success */
    public static String ELM_NAME_CALLBACK_TASKCODE_ON_SUCCESS = "onSuccessCallbackTaskCode";
    

    /** element name call back task code on fail */
    public static String ELM_NAME_CALLBACK_TASKCODE_ON_FAIL = "onFailCallBackTaskCode";
            
    /** result of the task */
    public boolean isSuccess = false;
    /**
     * Creates a new instance of FrmSubmitReq
     */
    public FrmSubmitReq(HttpSession session, HttpServletRequest request) {
        ArrayList elmName = new ArrayList();
        elmName.add(ELM_NAME_TO_EMP_ID);
        elmName.add(ELM_NAME_CALLBACK_MENUCODE_ON_SUCCESS);
        elmName.add(ELM_NAME_CALLBACK_TASKCODE_ON_SUCCESS);
        elmName.add(ELM_NAME_CALLBACK_TASKCODE_ON_FAIL);
        this.setValues(request, elmName);
        isSuccess = doSubmit(session, request);
    }
    
    /** Submits request
     * @param session http session
     * @param request http request
     * @return true if request is submitted successfully, false otherwise
     */
    private boolean doSubmit(HttpSession session, HttpServletRequest request){
        boolean res = false;
        if(session.getAttribute(LutGlobalSessionName.FORM) != null){
            User user = (User) session.getAttribute(LutGlobalSessionName.USER);
            FrmLeaveReq reqForm = (FrmLeaveReq) session.getAttribute(LutGlobalSessionName.FORM);
            reqForm.setValue(reqForm.ELM_NAME_FROM_EMP_ID, user.employee.empId);
            reqForm.setValue(reqForm.ELM_NAME_TO_EMP_ID, user.employee.commanderEmpId);
            res = reqForm.doDBTask();
            if(res){
                if(session.getAttribute(LutGlobalSessionName.SUB_FORM) != null){
                    ArrayList listSubForm = (ArrayList)session.getAttribute(LutGlobalSessionName.SUB_FORM);
                    for(int i = 0; i < listSubForm.size(); i++){
                        FrmLeaveReq subForm = (FrmLeaveReq)listSubForm.get(i);
                        subForm.setValue(subForm.ELM_NAME_REF_TAKE_LEAVE_ID, reqForm.getValue(reqForm.ELM_NAME_TAKE_LEAVE_ID));
                        res = subForm.doDBTask();
                    }
                }
            }
        }
        return res;
    }
    
}
