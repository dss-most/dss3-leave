/*
 * FrmSubmitCancelFull.java
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
public class FrmSubmitCancelFull extends HtmlForm {
    /** take leave id */
    public static final String ELM_NAME_TAKE_LEAVE_ID = "takeLeave_id";
    /** task result */
    public boolean isSuccess = false;
    /**
     * Creates a new instance of FrmSubmitCancelFull
     */
    public FrmSubmitCancelFull(HttpServletRequest request) {
        ArrayList elm = new ArrayList();
        elm.add(ELM_NAME_TAKE_LEAVE_ID);
        setValues(request, elm);
        
        String formStatus = "";
        FrmLeaveReq reqForm = new FrmLeaveReq(this.getValue(this.ELM_NAME_TAKE_LEAVE_ID));
        reqForm.setValue(reqForm.ELM_NAME_FORM_STATE, reqForm.FORM_STATE_DELETE);
        if(reqForm.getValue(reqForm.ELM_NAME_FORM_TYPE_ID).equals(reqForm.FORM_TYPE_OUT_COUNTRY_WITH_LEAVE)){
            ArrayList listSubForm = reqForm.getSubFormId();
            for(int i = 0; i < listSubForm.size(); i++){
                FrmLeaveReq subForm = new FrmLeaveReq();
                subForm.setValue(subForm.ELM_NAME_TAKE_LEAVE_ID, listSubForm.get(i).toString());
                subForm.setValue(subForm.ELM_NAME_FORM_STATE, subForm.FORM_STATE_DELETE);
                isSuccess = subForm.doDBTask();
                if(!isSuccess) break;
            }
        }
        isSuccess = reqForm.doDBTask();
        
    }
}
