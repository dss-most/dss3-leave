/*
 * LutLeaveReqTaskCode.java
 *
 * Created on 2 �չҤ� 2550, 23:32 �.
 *
 * To change this template, choose Tools | Template Manager
 * and open the template in the editor.
 */

package gitex.tu;

import javax.servlet.http.*;
import java.util.*;

/**
 * Provides mapping from task code to corresponding form
 * @author pantape
 */
public class LutLeaveReqTaskCode {
    /** task code to jsp file mapper */
    private Hashtable mapper;
  
    /** login user*/
    public static String LOGIN_USER = "M1-1"; //M = Menu
    
    /** view leave statistic */
    public static String VIEW_LEAVE_STAT = "M1-2";
    
    /** check leave req status step 1*/
    public static String CHECK_REQ_STATUS_1 = "M2-1";
    
    /** check leave req status step 2*/
    public static String CHECK_REQ_STATUS_2 = "M2-2";

    /** request for in country leave step 1 */
    public static String REQ_IN_COUNTRY_LEAVE_1 = "M3-1";
    
    /** request for in country leave step 2 */
    public static String REQ_IN_COUNTRY_LEAVE_2 = "M3-2";

    /** request for in country leave step 3 */
    public static String REQ_IN_COUNTRY_LEAVE_3 = "M3-3";
    
    /** request for out country leave step 1 */
    public static String REQ_OUT_COUNTRY_LEAVE_1 = "M4-1";
    
    /** request for out country leave step 1 */
    public static String REQ_OUT_COUNTRY_LEAVE_2 = "M4-2";

    /** request for out country leave step 1 */
    public static String REQ_OUT_COUNTRY_LEAVE_3 = "M4-3";

    /** view leave history step 1 */
    public static String VIEW_LEAVE_HISTORY_1 = "M5-1";

    /** view waiting approve request step 1 */
    public static String VIEW_WAITING_APPROVE_REQ_1 = "M6-1";
    
    /** view waiting approve request step 2 */
    public static String VIEW_WAITING_APPROVE_REQ_2 = "M6-2";

    /** view leave report */
    public static String VIEW_LEAVE_REPORT_1 = "M7-1";

    /** manage leave */
    public static String MANAGE_LEAVE_1 = "M8-1";

    /** view waiting forward request step 1 */
    public static String VIEW_WAITING_FORWARD_REQ_1 = "M8-x1";

    /** view waiting forward request step 2 */
    public static String VIEW_WAITING_FORWARD_REQ_2 = "M8-x2";

    /** manage commander tree step 1 */
    public static String MANAGE_COMMAND_TREE_1 = "M9-1";

    /** manage system administrator */
    public static String MANAGE_ADMIN_1 = "M10-1";

    /** manage system administrator */
    public static String MANAGE_VISA_DOC_1 = "M11-1";
    
    /** manage system administrator */
    public static String MANAGE_LEAVE_EXTRA_1 = "M12-1";
    
    /** manage system administrator */
    public static String MANAGE_HOLIDAYS_1 = "M13-1";
    
    /** select leave request approver */
    public static String SELECT_REQ_APPROVER = "SelectReqApprover";

    /** submit request to the approver */
    public static String SUBMIT_REQ = "SubmitRequest";

    /** submit approver result */
    public static String SUBMIT_APPROVE = "SubmitApprove";
    
    /** view waiting forward request step 2 */
    public static String SUBMIT_FORWARD = "submitForward";

    /** submit cancel */
    public static String SUBMIT_CANCEL_FULL = "SubmitCancelFull";

    /** submit cancel partial */
    public static String SUBMIT_CANCEL_PARTIAL = "SubmitCancelPartial";

    /** preview cancel artial */
    public static String PREVIEW_CANCEL_PARTIAL = "PreviewCancelPartial";

    /** input cancel artial */
    public static String INPUT_CANCEL_PARTIAL = "InputCancelPartial";

    /** log out */
    public static String LOGOUT_USER = "M99-1";
    
    /** period  */
    
    public static String PERIOD= "M14-1";
    
    
    public static String WORKTIME="M15-1";
    
    /** Misc Form */
    public static String VIEW_MISC_FORM = "M16-1";
    
    public static String VIEW_MISC_FORM_MEETING = "M16-2";
    public static String VIEW_MISC_VEHICLE_HISTORY = "M16-3";
    public static String VIEW_MISC_FORM_VEHICLE = "M16-4";
    public static String VIEW_MISC_FORM_VEHICLE_CONFIRM = "M16-5";
    
    
    
    /**
     * Creates a new instance of LutLeaveReqTaskCode
     */
    public LutLeaveReqTaskCode() {
        mapper = new Hashtable();
        mapper.put(LOGIN_USER, "frmUserLogin.jsp");
        mapper.put(VIEW_LEAVE_STAT, "frmLeaveStatMain.jsp");
        mapper.put(CHECK_REQ_STATUS_1, "frmLeaveStatusMain.jsp");
        mapper.put(CHECK_REQ_STATUS_2, "frmLeaveStatusDtl.jsp");
        mapper.put(REQ_IN_COUNTRY_LEAVE_1, "frmInCountryLeaveMain.jsp");
        mapper.put(REQ_IN_COUNTRY_LEAVE_2, "frmInCountryLeaveInput.jsp");
        mapper.put(REQ_IN_COUNTRY_LEAVE_3, "frmInCountryLeavePreview.jsp");
        mapper.put(REQ_OUT_COUNTRY_LEAVE_1, "frmOutCountryLeaveMain.jsp");
        mapper.put(REQ_OUT_COUNTRY_LEAVE_2, "frmOutCountryLeaveInput.jsp");
        mapper.put(REQ_OUT_COUNTRY_LEAVE_3, "frmOutCountryLeavePreview.jsp");
        mapper.put(VIEW_LEAVE_HISTORY_1, "frmLeaveHistoryMain.jsp");
        mapper.put(VIEW_WAITING_APPROVE_REQ_1, "frmApproveReqMain.jsp");
        mapper.put(VIEW_WAITING_APPROVE_REQ_2, "frmApproveReqDtl.jsp");
        mapper.put(VIEW_LEAVE_REPORT_1, "frmLeaveReportMain.jsp");
        mapper.put(MANAGE_LEAVE_1, "frmSearchLeaveMain.jsp");
        mapper.put(VIEW_WAITING_FORWARD_REQ_1, "frmForwardReqMain.jsp");
        mapper.put(VIEW_WAITING_FORWARD_REQ_2, "frmForwardReqDtl.jsp");
        mapper.put(MANAGE_COMMAND_TREE_1, "frmCmdTreeMain.jsp");
        mapper.put(MANAGE_ADMIN_1, "frmSysAdminMain.jsp");
        mapper.put(MANAGE_VISA_DOC_1, "frmSearchVisaDocMain.jsp");
        mapper.put(MANAGE_LEAVE_EXTRA_1, "frmLeaveExtraMain.jsp");
        mapper.put(MANAGE_HOLIDAYS_1, "frmHolidaysMain.jsp");
        mapper.put(SELECT_REQ_APPROVER, "frmApprover.jsp");
        mapper.put(SUBMIT_REQ, "frmSubmitReq.jsp");
        mapper.put(SUBMIT_APPROVE, "frmSubmitApprove.jsp");
        mapper.put(SUBMIT_FORWARD, "frmSubmitForward.jsp");
        mapper.put(SUBMIT_CANCEL_FULL, "frmSubmitCancelFull.jsp");
        mapper.put(INPUT_CANCEL_PARTIAL, "frmInputCancelPartial.jsp");
        mapper.put(PREVIEW_CANCEL_PARTIAL, "frmPreviewCancelPartial.jsp");
        mapper.put(SUBMIT_CANCEL_PARTIAL, "frmSubmitCancelPartial.jsp");
        mapper.put(LOGOUT_USER, "frmLogoutUser.jsp");
        mapper.put(PERIOD,"frmPeriod.jsp");
        mapper.put(WORKTIME, "worktime.jsp");
        mapper.put(VIEW_MISC_FORM, "M16_miscform.jsp");
        mapper.put(VIEW_MISC_FORM_MEETING, "M16-2_meetingform.jsp");
        mapper.put(VIEW_MISC_VEHICLE_HISTORY, "M16-3_frmVehicleHistoryMain.jsp");
        mapper.put(VIEW_MISC_FORM_VEHICLE, "M16-4_vehicleform.jsp");
        mapper.put(VIEW_MISC_FORM_VEHICLE_CONFIRM, "M16-5_vehicleformConfirm.jsp");
    }
    
    /** Gets jsp form name for the task code
     * @param taskCode task code for mapping
     * @return JSP file name corresponding to the provided task code.
     * If the task code does not exist, blank string is retruned.
     */
    public String getJSPFormName(String taskCode){
        if(mapper.containsKey(taskCode)){
            return mapper.get(taskCode).toString();
        }else
            return "";        
    }
    
}
