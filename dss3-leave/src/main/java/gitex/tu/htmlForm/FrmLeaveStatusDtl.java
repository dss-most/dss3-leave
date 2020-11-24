/*
 * FrmLeaveStatusDtl.java
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
public class FrmLeaveStatusDtl extends HtmlForm{
    /** take leave id */
    public static final String ELM_NAME_TAKE_LEAVE_ID = "takeLeave_id";
    
    /**
     * Creates a new instance of FrmLeaveStatusDtl
     */
    public FrmLeaveStatusDtl(HttpServletRequest request) {
        ArrayList elm = new ArrayList();
        elm.add(ELM_NAME_TAKE_LEAVE_ID);
        setValues(request, elm);
    }
    
}
