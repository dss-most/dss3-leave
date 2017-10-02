/*
 * FrmLeaveStat.java
 *
 * Created on 4 ¡’π“§¡ 2550, 18:22 π.
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
 * Contains data for the frmLeaveStat.jsp file
 * 
 * @author pantape
 */
public class FrmLeaveStat extends HtmlForm {
    
    /** element name budget year */
    public static String ELM_NAME_BUDGET_YEAR = "budgetYear";

    /**
     * Creates a new instance of FrmLeaveStat 
     * 
     * @param session http session
     * @param request http request
     */
    public FrmLeaveStat(HttpSession session, HttpServletRequest request) {
        ArrayList elmName = new ArrayList();
        elmName.add(ELM_NAME_BUDGET_YEAR);
        this.setValues(request, elmName);
    }
    
}
