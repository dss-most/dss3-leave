/*
 * FrmUserLogin.java
 *
 * To change this template, choose Tools | Template Manager
 * and open the template in the editor.
 */

package gitex.tu.htmlForm;

import gitex.html.HtmlForm;
import javax.servlet.http.*;
import java.util.*;

/**
 * Represents the login form in the web page
 * @author pantape
 */
public class FrmUserLogin extends HtmlForm {
    /** form name list */
    private ArrayList nameList;
       
    /** name of user name element */
    public static String ELM_NAME_USERNAME = "userName";
    
    /** name of password element */
    public static String ELM_NAME_PASSWORD = "password";
    
    /**
     * Creates a new instance of FrmUserLogin
     */
    public FrmUserLogin(HttpServletRequest request) {
        nameList = new ArrayList();
        nameList.add(ELM_NAME_USERNAME);
        nameList.add(ELM_NAME_PASSWORD);
        super.setValues(request, nameList);
    }
    
}
