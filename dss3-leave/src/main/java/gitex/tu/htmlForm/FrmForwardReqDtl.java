/*
 * FrmForwardReqDtl.java
 *
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
 * Represents the frmForwardReqDtl.jsp file
 * @author pantape
 */
public class FrmForwardReqDtl extends HtmlForm {
    /** take leave id */
    public static final String ELM_NAME_TAKE_LEAVE_ID = "takeLeave_id";
    
    /**
     * Creates a new instance of FrmApproveReqDtl
     */
    public FrmForwardReqDtl(HttpServletRequest request) {
        ArrayList elm = new ArrayList();
        elm.add(ELM_NAME_TAKE_LEAVE_ID);
        super.setValues(request, elm);
    }
    
}
