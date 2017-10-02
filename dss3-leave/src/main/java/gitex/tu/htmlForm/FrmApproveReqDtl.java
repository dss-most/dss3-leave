/*
 * FrmApproveReqDtl.java
 *
 * Created on 12 ¡’π“§¡ 2550, 21:30 π.
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
 * Represents the frmApproveReq.jsp file
 * @author pantape
 */
public class FrmApproveReqDtl extends HtmlForm {
    /** take leave id */
    public static final String ELM_NAME_TAKE_LEAVE_ID = "takeLeave_id";
    
    /**
     * Creates a new instance of FrmApproveReqDtl
     */
    public FrmApproveReqDtl(HttpServletRequest request) {
        ArrayList elm = new ArrayList();
        elm.add(ELM_NAME_TAKE_LEAVE_ID);
        super.setValues(request, elm);
    }
    
}
