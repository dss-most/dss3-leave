/*
 * LeaveReqHtmlPage.java
 *
 * Created on 2 ¡’π“§¡ 2550, 22:37 π.
 *
 * To change this template, choose Tools | Template Manager
 * and open the template in the editor.
 */

package gitex.tu;

import javax.servlet.http.*;
import java.util.*;
import gitex.html.*;

/**
 * Contains all information needed for generating the HTML page
 * @author pantape
 */
public class LeaveReqHtmlPage extends HtmlPage {
    /** current login user */
    private User user;
    
    
    /**
     * Creates a new instance of LeaveReqHtmlPage 
     * 
     * 
     * @see LutGlobalRequestName
     * @param session HTTP session
     * @param request HTTP request
     */
    public LeaveReqHtmlPage(HttpSession session, HttpServletRequest request) {
        super(session, request);
        if(session.getAttribute(LutGlobalSessionName.USER) != null){
            user = (User)session.getAttribute(LutGlobalSessionName.USER);
        }else if(session.getAttribute(LutGlobalSessionName.EMP_ID) != null){
            String empId = session.getAttribute(LutGlobalSessionName.EMP_ID).toString();
            user = new User(empId);
        }else{
            logoutUser(session);
            user = new User(session, request, this);
        }
        
         
        if(user.getRole(user.ROLE_TYPE_USER).equals(user.ROLE_NONE_USER)){
            this.setMenuCode(LutLeaveReqMenuCode.WELCOME);
            this.setTaskCode(LutLeaveReqTaskCode.LOGIN_USER);
        }else{
        	session.setAttribute("Login", user.getLoginName());
        	
            session.setAttribute(LutGlobalSessionName.USER, user);
            session.setAttribute(LutGlobalSessionName.EMP_ID, user.employee.empId);
            if(this.menuCode.equals("") || this.taskCode.equals("")){
                this.setMenuCode(LutLeaveReqMenuCode.WELCOME);
                this.setTaskCode(LutLeaveReqTaskCode.VIEW_LEAVE_STAT);
            }
        }
    }
    
    /** Gets current user
     * @return current user
     * @see User
     */
    public User getUser(){
        return user;
    }
    
    /** Logs out user */
    public static void logoutUser(HttpSession session){
        if(session.getAttribute(LutGlobalSessionName.USER) != null){
            session.removeAttribute(LutGlobalSessionName.USER);
        }
        if(session.getAttribute(LutGlobalSessionName.EMP_ID) != null){
            session.removeAttribute(LutGlobalSessionName.EMP_ID);
        }
        if(session.getAttribute(LutGlobalSessionName.MENU_CODE) != null){
            session.removeAttribute(LutGlobalSessionName.MENU_CODE);
        }
        if(session.getAttribute(LutGlobalSessionName.TASK_CODE) != null){
            session.removeAttribute(LutGlobalSessionName.TASK_CODE);
        }
    }
    
}
