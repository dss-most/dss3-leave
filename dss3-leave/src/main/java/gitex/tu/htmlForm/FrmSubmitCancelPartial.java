/*
 * FrmSubmitCancelPartial.java
 *
 * Created on 17 ¡’π“§¡ 2550, 15:36 π.
 *
 * To change this template, choose Tools | Template Manager
 * and open the template in the editor.
 */

package gitex.tu.htmlForm;

import javax.servlet.http.*;
import java.util.*;
import gitex.html.*;
import gitex.tu.*;
import gitex.tu.htmlForm.*;
import gitex.utility.*;

/**
 *  Represents the frmSubmitCancelPartial.jsp file
 * @author pantape
 */
public class FrmSubmitCancelPartial extends HtmlForm {
    /** task result */
    public boolean isSuccess = false;
    /**
     * Creates a new instance of FrmSubmitCancelFull
     */
    public FrmSubmitCancelPartial(FrmLeaveReq reqForm) {
        isSuccess = doSubmit(reqForm);
    }
    
    /** Submits request
     * @param session http session
     * @param request http request
     * @return true if request is submitted successfully, false otherwise
     */
    private boolean doSubmit(FrmLeaveReq reqForm){
        boolean res = false;
        reqForm.setValue(reqForm.ELM_NAME_FORM_STATE, reqForm.FORM_STATE_NEW);
        reqForm.setValue(reqForm.ELM_NAME_STATUS, reqForm.FORM_STATUS_WAITING);
        reqForm.setValue(reqForm.ELM_NAME_FORM_TYPE_ID, reqForm.FORM_TYPE_CANCEL);
        res = reqForm.doDBTask();
        return res;
    }
    }
