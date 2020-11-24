/*
 * HtmlPage.java
 *
 *
 */

package gitex.html;

import javax.servlet.http.*;
import java.util.*;

/**
 * Contains all information needed for generating the HTML page
 * @author pantape
 */
public class HtmlPage {
    
    /** current selected menu */
    protected String menuCode = "";
    
    /** current task */
    protected String taskCode = "";
    
    /** current page number */
    protected String pageNo = "";
    
    /** error message */
    protected String errMsg = "";
    
    /**
     * Creates a new instance of HtmlPage. All global variables stored
     * in the session object and request object (menu code, task code, page no 
     * and error message) will be retrieved. 
     * The values stored in the request object takes higher privilege.
     * @param session HTTP session
     * @param request HTTP request
     * @see LutGlobalSessionName
     * @see LutGlobalRequestName
     */
    public HtmlPage(HttpSession session, HttpServletRequest request) {
        /* Retrieves global session variables */
        if(session.getAttribute(LutGlobalSessionName.MENU_CODE) != null){
            menuCode = session.getAttribute(LutGlobalSessionName.MENU_CODE).toString();
        }
        if(session.getAttribute(LutGlobalSessionName.TASK_CODE) != null){
            taskCode = session.getAttribute(LutGlobalSessionName.TASK_CODE).toString();
        }
        if(session.getAttribute(LutGlobalSessionName.PAGE_NO) != null){
            pageNo = session.getAttribute(LutGlobalSessionName.PAGE_NO).toString();
        }
        /* Retrieves global request variables */
        if(request.getParameter(LutGlobalRequestName.MENU_CODE) != null){
            menuCode = request.getParameter(LutGlobalRequestName.MENU_CODE).toString();
            session.setAttribute(LutGlobalRequestName.MENU_CODE, menuCode);
        }
        if(request.getParameter(LutGlobalRequestName.TASK_CODE) != null){
            taskCode = request.getParameter(LutGlobalRequestName.TASK_CODE).toString();
            session.setAttribute(LutGlobalRequestName.TASK_CODE, taskCode);
        }
        if(request.getParameter(LutGlobalRequestName.PAGE_NO) != null){
            pageNo = request.getParameter(LutGlobalRequestName.PAGE_NO).toString();
            session.setAttribute(LutGlobalRequestName.PAGE_NO, pageNo);
        }
    }
    
    /** Gets selected menu code for generating appropriate user menu
     * @return current selected menu code
     */
    public String getMenuCode(){
        return menuCode;
    }

    /** Sets selected menu code for generating appropriate user menu
     * @param newMenuCode menu code wanted to be set to
     */
    public void setMenuCode(String newMenuCode){
        menuCode = newMenuCode;
    }

    /** Gets current task code for generating relevant UI
     * @return current selected task code
     */
    public String getTaskCode(){
        return taskCode;
    }

    /** Sets current task code for generating relevant UI
     * @param newTaskCode task code wanted to be set to
     */
    public void setTaskCode(String newTaskCode){
        taskCode = newTaskCode;
    }
    
    /** Gets error message
     * @return error message
     */
    public String getErrMsg(){
        return errMsg;
    }
    
    /** Sets error message
     * @param msg error message
     */
    public void setErrMsg(String msg){
        errMsg = msg;
    }
}
