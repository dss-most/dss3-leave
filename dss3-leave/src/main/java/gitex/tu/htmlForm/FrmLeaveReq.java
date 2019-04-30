/*
 * FrmLeaveReq.java
 *
 * Created on 7 เน�เธ�เธ�เธตเธ�เธฒเธ�เน�เธ�เธ� 2550, 20:51 เน�เธ�เธ�.
 *
 * To change this template, choose Tools | Template Manager
 * and open the template in the editor.
 */

package gitex.tu.htmlForm;

import javax.servlet.http.*;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;



import java.util.*;
import gitex.html.*;
import gitex.utility.*;
import gitex.tu.*;

/**
 * Provides common form properties and method
 * @author pantape
 */
public class FrmLeaveReq extends HtmlForm {
	final static Logger log = LoggerFactory.getLogger(HtmlForm.class);
	
    /* form No Sign In request value */
    public final String FORM_NSI_0730 = "1";
    public final String FORM_NSI_0830 = "2";
    public final String FORM_NSI_0930 = "3";
    public final String FORM_NSI_IN = "1";
    public final String FORM_NSI_OUT = "2";
    public final String FORM_NSI_IN_OUT = "3";
            
    /* form state value */
    public final String FORM_STATE_NEW = "insert";
    public final String FORM_STATE_UPDATE_STATUS = "updateStatus";
    public final String FORM_STATE_DELETE = "delete";
    
    /* form type value */
    public final String FORM_TYPE_SICKNESS = "1";
    public final String FORM_TYPE_PRIVATE = "2";
    public final String FORM_TYPE_VACATION = "3";
    public final String FORM_TYPE_BE_MONK = "4";
    public final String FORM_TYPE_GO_HAJJ = "5";
    public final String FORM_TYPE_GIVE_BIRTH = "6";
    public final String FORM_TYPE_MILITARY_CALL = "7";
    public final String FORM_TYPE_OUT_COUNTRY_WITH_LEAVE = "10";
    public final String FORM_TYPE_OUT_COUNTRY_WITHOUT_LEAVE = "11";
    public final String FORM_TYPE_CANCEL = "12";
    public final String FORM_TYPE_NO_SIGN_IN_OUT = "14";

    /* form status value */
    public static final String FORM_STATUS_WAITING = "1";
    public static final String FORM_STATUS_ALLOW = "2";
    public static final String FORM_STATUS_CANCEL = "3";
    public static final String FORM_STATUS_PARTIAL_CANCEL = "4";
    public static final String FORM_STATUS_NOT_ALLOW = "5";
    
    /* form log type value */
    public final String FORM_LOG_CREATE = "1";
    public final String FORM_LOG_FORWARD = "2";
    public final String FORM_LOG_APPROVE = "3";
    public final String FORM_LOG_CANCEL = "4";
    
    /* form period value */
    public final String FORM_PERIOD_MORNING = "0";
    public final String FORM_PERIOD_AFTERNOON = "1";

    /* form need visa value */
    public final String FORM_NOT_NEED_VISA = "0";
    public final String FORM_NEED_VISA = "1";

    /* form is leave before value */
    public final String FORM_HAS_LEAVED_BEFORE = "1";
    public final String FORM_NEVER_LEAVED_BEFORE = "0";

    /** form element name leave id **/
    public static final String ELM_NAME_TAKE_LEAVE_ID = "takeLeave_id";

    /** form element name budget year **/
    public static final String ELM_NAME_BUDGET_YEAR = "budgetYear";

    /** form element name form type id **/
    public static final String ELM_NAME_FORM_TYPE_ID = "leaveFormType";
    
    /** form element name sub form type id **/
    public static final String ELM_NAME_SUB_FORM_TYPE_ID = "subLeaveFormType";

    /** form element name sub form count **/
    public static final String ELM_NAME_SUB_FORM_COUNT = "subFormCount";

    /** form element name sub form delete **/
    public static final String ELM_NAME_SUB_FORM_DELETE = "subFormDelete";

    /** form element name form type id **/
    public static final String ELM_NAME_FORM_CAT_ID = "leaveCategory_id";

    /** form element name form state **/
    public static final String ELM_NAME_FORM_STATE = "formState";
    
    /** form element name employee id **/
    public static final String ELM_NAME_EMP_ID = "emp_id";

    /** form element name work title of organisation head **/
    public static final String ELM_NAME_ORG_HEAD_WORK_TITLE = "org_head_work_title";

    /** form element name status */
    public static final String ELM_NAME_STATUS = "formStatus";

    /** form element name issue date */
    public static final String ELM_NAME_MAKE_REQ_DATE = "formIssueDate";

    /** form element name issue date */
    public static final String ELM_NAME_MAKE_REQ_ORG = "issueLocation";

    /** form element name leave start date */
    public static final String ELM_NAME_LEAVE_START_DATE = "startDate";
    
    /** form element name leave start date period */
    public static final String ELM_NAME_LEAVE_START_DATE_PERIOD = "startDatePeriod";
    
    /** form element name leave end date */
    public static final String ELM_NAME_LEAVE_END_DATE = "endDate";
    
    /** form element name leave start end period */
    public static final String ELM_NAME_LEAVE_END_DATE_PERIOD = "endDatePeriod";

        /** form element name leave start date */
    public static final String ELM_NAME_FORM_START_DATE = "formStartDate";
    
    /** form element name leave start date period */
    public static final String ELM_NAME_FORM_START_DATE_PERIOD = "formStartDatePeriod";
    
    /** form element name leave end date */
    public static final String ELM_NAME_FORM_END_DATE = "formEndDate";
    
    /** form element name leave start end period */
    public static final String ELM_NAME_FORM_END_DATE_PERIOD = "formEndDatePeriod";

    /** form element name leave day count master*/
    public static final String ELM_NAME_LEAVE_DAY_COUNT_MASTER = "formLeaveDays";
    
    /** form element name leave day count child*/
    public static final String ELM_NAME_LEAVE_DAY_COUNT_CHILD = "takeLeaveDays";
 
    /** form element name contact detail */
    public static final String ELM_NAME_CONTACT_DETAIL = "contactAddress";

    /** form element name text 1 */
    public static final String ELM_NAME_TEXT_1 = "fldText1";
    
    /** form element name text 2 */
    public static final String ELM_NAME_TEXT_2 = "fldText2";
    
    /** form element name text 3 */
    public static final String ELM_NAME_TEXT_3 = "fldText3";
    
    /** form element name text 4 */
    public static final String ELM_NAME_TEXT_4 = "fldText4";

    /** form element name text 5 */
    public static final String ELM_NAME_TEXT_5 = "fldText5";

    /** form element name detail date */
    public static final String ELM_NAME_DETAIL_DATE = "assignDate";
    
    /** form element name to country (use in out country leave only) */
    public static final String ELM_NAME_TO_COUNTRY = "to_country";

    /** form element name 'is leave before'*/
    public static final String ELM_NAME_IS_LEAVE_BEFORE = "is_leave_before";

    /** form element name remark */
    public static final String ELM_NAME_REMARK = "remark";

    /** form element name send form to */
    public static final String ELM_NAME_TO_EMP_ID = "to_emp_id";

    /** form element name send form by */
    public static final String ELM_NAME_FROM_EMP_ID = "from_emp_id";

    /** form element name send for **/
    public static final String ELM_NAME_SEND_PURPOSE = "sendPurpose_id";

    /** form element name user emp id */
    public static final String ELM_NAME_USER_EMP_ID = "user_emp_id";

    /** form element name user root org id */
    public static final String ELM_NAME_USER_ROOT_ORG_ID = "user_rootOrg_id";

    /** form element name is need visa */
    public static final String ELM_NAME_IS_NEED_VISA = "isNeedVisa";
    
    /** form element name log type */
    public static final String ELM_NAME_LOG_TYPE = "logType";
    
    /** form element name log type */
    public static final String ELM_NAME_LOG_DETAIL = "logDetail";

    /** form element name log status */
    public static final String ELM_NAME_LOG_STATUS = "logStatus";
    
    /** form element name is recent */
    public static final String ELM_NAME_IS_RECENT = "is_recent";

    /** form element name is recent */
    public static final String ELM_NAME_RECENT_TAKELEAVE_ID = "recent_takeLeave_id";

    /** form element name ref take leave id */
    public static final String ELM_NAME_REF_TAKE_LEAVE_ID = "ref_takeLeave_id";

    /** array list all form element */
    protected ArrayList elementNameList = new ArrayList();
    
    /** form name lut */
    public ArrayList formTypeIdList = new ArrayList();
    /** form name lut */
    private Hashtable formName = new Hashtable();
    /** leave category id lut */
    private Hashtable leaveCategoryId = new Hashtable();
    /** send purpose lut */
    private Hashtable sendPurpose = new Hashtable();

    /** database sequence name */
    private String DB_SEQ_NAME = "HR_LEAVE_TAKELEAVEFORM_SEQ";
    
    /** Creates a new empty instance of FrmInCountryLeaveTypeSickness */
    public FrmLeaveReq() {
        createElementNameList();
        getFormComp();
    }

    /** Creates a new instance of FrmInCountryLeaveTypeSickness using http request object
     * para request http request object
     */
    public FrmLeaveReq(HttpServletRequest request, User user) {
        gitex.utility.Date date = new gitex.utility.Date();
        String budgetYear = String.valueOf(date.getCurrentBudgetYear());
        //Set default value
        setValue(ELM_NAME_BUDGET_YEAR, budgetYear);
        setValue(ELM_NAME_FORM_STATE, FORM_STATE_NEW);
        setValue(ELM_NAME_STATUS, FORM_STATUS_WAITING);
        setValue(ELM_NAME_SEND_PURPOSE, "1");
        setValue(ELM_NAME_LOG_TYPE, FORM_LOG_CREATE);
        setValue(ELM_NAME_LOG_STATUS, "1");
        setValue(ELM_NAME_IS_NEED_VISA, "1");
        setValue(ELM_NAME_IS_LEAVE_BEFORE, "0");
        setValue(ELM_NAME_DETAIL_DATE, date.getDate(date.DATE_ENG));
        setValue(ELM_NAME_FORM_START_DATE_PERIOD, "0");
        setValue(ELM_NAME_FORM_END_DATE_PERIOD, "1");
        setValue(ELM_NAME_LEAVE_START_DATE_PERIOD, "0");
        setValue(ELM_NAME_LEAVE_END_DATE_PERIOD, "1");
        setValue(ELM_NAME_EMP_ID, user.employee.empId);
        setValue(ELM_NAME_MAKE_REQ_DATE, date.getDate(date.DATE_ENG));
        setValue(ELM_NAME_MAKE_REQ_ORG, user.employee.parentORGName);
        setValue(ELM_NAME_ORG_HEAD_WORK_TITLE, "");
        setValue(ELM_NAME_USER_EMP_ID, user.employee.empId);
        setValue(ELM_NAME_USER_ROOT_ORG_ID, user.employee.topORGId);
        setValue(ELM_NAME_FROM_EMP_ID, user.employee.empId);
        setValue(ELM_NAME_TO_EMP_ID, user.employee.commanderEmpId);
        setValue(ELM_NAME_IS_RECENT, "0");
        //Get values from request
        createElementNameList();
        getFormComp();
        setValues(request, elementNameList);
        if(this.getValue(this.ELM_NAME_FORM_TYPE_ID).equals("")){
            setValue(this.ELM_NAME_FORM_CAT_ID, this.getCategoryId(this.getValue(this.ELM_NAME_FORM_TYPE_ID)));
        }
        if(this.getValue(this.ELM_NAME_RECENT_TAKELEAVE_ID).equals("")){
            setRecentTakeLeaveId();
        }
    }

    /** Creates a new instance of FrmInCountryLeaveTypeSickness using form id
     * para leaveId leave id
     */
    public FrmLeaveReq(String takeLeaveId) {
        createElementNameList();
        getFormComp();
        /**
         * Process retrieving data from database using formId as a key to get all values
         */
        getDBData(takeLeaveId);
        if(this.getValue(this.ELM_NAME_RECENT_TAKELEAVE_ID).equals("")){
            setRecentTakeLeaveId();
        }
    }
    
    /** Creates an element name list */
    protected void createElementNameList(){
        elementNameList.add(this.ELM_NAME_BUDGET_YEAR);
        elementNameList.add(this.ELM_NAME_CONTACT_DETAIL);
        elementNameList.add(this.ELM_NAME_DETAIL_DATE);
        elementNameList.add(this.ELM_NAME_EMP_ID);
        elementNameList.add(this.ELM_NAME_FORM_CAT_ID);
        elementNameList.add(this.ELM_NAME_FORM_STATE);
        elementNameList.add(this.ELM_NAME_FORM_TYPE_ID);
        elementNameList.add(this.ELM_NAME_SUB_FORM_TYPE_ID);
        elementNameList.add(this.ELM_NAME_SUB_FORM_COUNT);
        elementNameList.add(this.ELM_NAME_SUB_FORM_DELETE);
        elementNameList.add(this.ELM_NAME_FROM_EMP_ID);
        elementNameList.add(this.ELM_NAME_IS_LEAVE_BEFORE);
        elementNameList.add(this.ELM_NAME_LEAVE_DAY_COUNT_CHILD);
        elementNameList.add(this.ELM_NAME_LEAVE_DAY_COUNT_MASTER);
        elementNameList.add(this.ELM_NAME_LEAVE_END_DATE);
        elementNameList.add(this.ELM_NAME_LEAVE_END_DATE_PERIOD);        
        elementNameList.add(this.ELM_NAME_FORM_END_DATE);
        elementNameList.add(this.ELM_NAME_FORM_END_DATE_PERIOD);        
        elementNameList.add(this.ELM_NAME_TAKE_LEAVE_ID);        
        elementNameList.add(this.ELM_NAME_LEAVE_START_DATE);        
        elementNameList.add(this.ELM_NAME_LEAVE_START_DATE_PERIOD);        
        elementNameList.add(this.ELM_NAME_FORM_START_DATE);        
        elementNameList.add(this.ELM_NAME_FORM_START_DATE_PERIOD);        
        elementNameList.add(this.ELM_NAME_MAKE_REQ_DATE);        
        elementNameList.add(this.ELM_NAME_MAKE_REQ_ORG);        
        elementNameList.add(this.ELM_NAME_ORG_HEAD_WORK_TITLE);        
        elementNameList.add(this.ELM_NAME_REMARK);        
        elementNameList.add(this.ELM_NAME_SEND_PURPOSE);        
        elementNameList.add(this.ELM_NAME_STATUS);        
        elementNameList.add(this.ELM_NAME_TEXT_1);        
        elementNameList.add(this.ELM_NAME_TEXT_2);        
        elementNameList.add(this.ELM_NAME_TEXT_3);        
        elementNameList.add(this.ELM_NAME_TEXT_4);        
        elementNameList.add(this.ELM_NAME_TEXT_5);        
        elementNameList.add(this.ELM_NAME_TO_COUNTRY);        
        elementNameList.add(this.ELM_NAME_TO_EMP_ID);        
        elementNameList.add(this.ELM_NAME_USER_EMP_ID);        
        elementNameList.add(this.ELM_NAME_USER_ROOT_ORG_ID);        
        elementNameList.add(this.ELM_NAME_IS_NEED_VISA);        
        elementNameList.add(this.ELM_NAME_LOG_TYPE);        
        elementNameList.add(this.ELM_NAME_LOG_STATUS);        
        elementNameList.add(this.ELM_NAME_LOG_DETAIL);        
        elementNameList.add(this.ELM_NAME_IS_RECENT);        
        elementNameList.add(this.ELM_NAME_RECENT_TAKELEAVE_ID);        
        elementNameList.add(this.ELM_NAME_REF_TAKE_LEAVE_ID);        
    }

    /**
     * Gets form components from database
     */
    private void getFormComp() {
        /* When initiated, obtain leave type id and leave type name then store in
         * relevant property
         */
        String sql = "SELECT * FROM hr_leave_formtype ";
        sql += " ORDER BY leaveFormType ";
        ArrayList field = new ArrayList();
        field.add("leaveFormType");
        field.add("leaveFormTypeDes");
        field.add("leaveCategory_id");
        Database db = new Database();
        ArrayList data = db.getResultSet(sql, field, null);
        if(data.size() > 0){
            for(int i = 0; i < data.size(); i++){
                String formId = ((Hashtable)data.get(i)).get("leaveFormType").toString();
                formTypeIdList.add(formId);
                formName.put(formId, ((Hashtable)data.get(i)).get("leaveFormTypeDes").toString());
                leaveCategoryId.put(formId, ((Hashtable)data.get(i)).get("leaveCategory_id").toString());
            }
        }
        // Send purpose
        sql = "SELECT * FROM hr_leave_sendpurpose ";
        sql += " ORDER BY sendPurpose_id ";
        field = new ArrayList();
        field.add("sendPurpose_id");
        field.add("sendPurpose_name");
        data = db.getResultSet(sql, field, null);
        if(data.size() > 0){
            for(int i = 0; i < data.size(); i++){
                String sendPurposeId = ((Hashtable)data.get(i)).get("sendPurpose_id").toString();
                sendPurpose.put(sendPurposeId, ((Hashtable)data.get(i)).get("sendPurpose_name").toString());
            }
        }
    }
    /** Sets recent take leave id of this form
     */
    private void setRecentTakeLeaveId(){
        String empId = this.getValue(this.ELM_NAME_EMP_ID);
        String formTypeId = this.getValue(this.ELM_NAME_FORM_TYPE_ID);
        String budgetYear = this.getValue(this.ELM_NAME_BUDGET_YEAR);
        if(!empId.equals("") && !formTypeId.equals("")){
            Database db = new Database();
            String sql = "";
            sql = " SELECT takeLeave_id FROM hr_leave_takeLeaveForm ";
            sql += " WHERE is_recent = 1 ";
            sql += " AND emp_id = " + empId;
            sql += " AND leaveFormType = " + formTypeId;
            sql += " AND budgetYear = " + budgetYear;
            ArrayList field = new ArrayList();
            field.add("takeLeave_id");
            ArrayList data = db.getResultSet(sql, field, null);
            if(data.size() > 0){
                this.setValue(this.ELM_NAME_RECENT_TAKELEAVE_ID, ((Hashtable)data.get(0)).get("takeLeave_id").toString());
            }
        }
    }
    /** Gets form is_leave_before name
     * @param value form is_leave_before value
     * @return name of the is_leave_before value
     */
    public String getIsLeaveBeforeName(String value){
        if(value.equals(this.FORM_NEVER_LEAVED_BEFORE)){
            return "ไม่เคย";
        }else return "เคย";
    }

     /** Gets form is_need_visa name
     * @param value form is_need_visa value
     * @return name of the is_need_visa value
     */
    public String getIsNeedVisaName(String value){
        if(value.equals(this.FORM_NOT_NEED_VISA)){
            return "ไม่ต้องการ";
        }else return "ต้องการ";
    }

    /** Gets form type name
     * @param formTypeId form type id
     * @return name of the form specified by form type id
     */
    public String getFormName(String formTypeId){
        if(formName.containsKey(formTypeId)){
            return formName.get(formTypeId).toString();
        }else return "ไม่ระบุ";
    }

    /** Gets this form type name
     * @return name of the form
     */
    public String getFormName(){
        return getFormName(this.getValue(this.ELM_NAME_FORM_TYPE_ID));
    }
    
    /** Gets form send purpose name
     * @param sendPurposeId send purpose id
     * @return send purpose name of the form specified by form type id
     */
    public String getSendPurpose(String sendPurposeId){
        if(sendPurpose.containsKey(sendPurposeId)){
            return sendPurpose.get(sendPurposeId).toString();
        }else return "ไม่ระบุ";
    }

    /** Gets this form send purpose name
     * @return send purpose name of the form
     */
    public String getSendPurpose(){
        return getSendPurpose(this.getValue(this.ELM_NAME_SEND_PURPOSE));
    }
    
    /** Gets leave category id
     * @param formTypeId form type id
     * @return leave category id
     */
    public String getCategoryId(String formTypeId){
        if(leaveCategoryId.containsKey(formTypeId)){
            return leaveCategoryId.get(formTypeId).toString();
        }else return "NULL";
    }

    /** Gets form status name 
     * @param statusCode form status code
     * @return status name
     */
    public static String getStatusName(String statusCode){
        if(statusCode.equals(FORM_STATUS_ALLOW))
            return "อนุญาต";
        else if(statusCode.equals(FORM_STATUS_CANCEL))
            return "ยกเลิก";
        else if(statusCode.equals(FORM_STATUS_NOT_ALLOW))
            return "ไม่อนุญาต";
        else if(statusCode.equals(FORM_STATUS_PARTIAL_CANCEL))
            return "อนุญาตและมีการยกเลิกวันลา";
        else if(statusCode.equals(FORM_STATUS_WAITING))
            return "รออนุญาต";
        else return "ไม่ระบุ";
    }
    
    /** Checks if leave interval elapses with other leave interval
     * @return true if the leave interval elapses with others, false otherwise
     */
    public boolean isElapse(){
        boolean res = false;
        String startDate = getValue(this.ELM_NAME_FORM_START_DATE);
        String endDate = getValue(this.ELM_NAME_FORM_END_DATE);
        String startDatePeriod= getValue(this.ELM_NAME_FORM_START_DATE_PERIOD);
        String endDatePeriod = getValue(this.ELM_NAME_FORM_END_DATE_PERIOD);
        if(!startDate.equals("") && !endDate.equals("")){
            Database db = new Database();
            String sql = "SELECT leave_id FROM hr_leave_takeLeaveRec t1, hr_leave_takeLeaveForm t2 ";
             sql += " WHERE t2.formstatus not in ('4','3') ";
            sql += " and t1.takeLeave_id = t2.takeLeave_id AND t2.emp_id = " + getValue(this.ELM_NAME_EMP_ID);
            sql += " AND ((TO_CHAR(t1.startDate, 'YYYYMMDD') || startDatePeriod >= '" + startDate + startDatePeriod + "'";
            sql += " AND TO_CHAR(t1.startDate, 'YYYYMMDD') || startDatePeriod <= '" + endDate + endDatePeriod + "')";
            sql += " OR( TO_CHAR(t1.endDate, 'YYYYMMDD') || endDatePeriod >= '" + startDate + startDatePeriod + "'";
            sql += " AND TO_CHAR(t1.endDate, 'YYYYMMDD') || endDatePeriod <= '" + endDate + endDatePeriod + "')";
            sql += " OR ( '"+ startDate + startDatePeriod +"' between   (TO_CHAR(t1.startDate, 'YYYYMMDD')) || startDatePeriod and   ( TO_CHAR(t1.endDate, 'YYYYMMDD')) || endDatePeriod  ";
            sql += " AND '"+ endDate + endDatePeriod +"' between   (TO_CHAR(t1.startDate, 'YYYYMMDD')) || startDatePeriod and   ( TO_CHAR(t1.endDate, 'YYYYMMDD')) || endDatePeriod )) ";
            //log.debug(sql);
            ArrayList field = new ArrayList();
            field.add("leave_id");
            ArrayList data = db.getResultSet(sql, field, null);
            if(data.size() > 0) res = true;
        }
        return res;
    }

    /** Gets leave req which leave interval elapses with other leave interval
     * @return array list of take leave id of leave req which leave interval elapses with others, false otherwise
     */
    public ArrayList getElapseReq(){
        ArrayList takeLeaveId = new ArrayList();
        String startDate = getValue(this.ELM_NAME_FORM_START_DATE);
        String endDate = getValue(this.ELM_NAME_FORM_END_DATE);
        String startDatePeriod= getValue(this.ELM_NAME_FORM_START_DATE_PERIOD);
        String endDatePeriod = getValue(this.ELM_NAME_FORM_END_DATE_PERIOD);
        if(!startDate.equals("") && !endDate.equals("")){
            Database db = new Database();
            String sql = "SELECT t1.takeLeave_id FROM hr_leave_takeLeaveRec t1, hr_leave_takeLeaveForm t2 ";
            sql += " WHERE t2.formstatus not in ('4','3') ";
            sql += " and  t1.takeLeave_id = t2.takeLeave_id AND t2.emp_id = " + getValue(this.ELM_NAME_EMP_ID);
            sql += " AND ((TO_CHAR(t1.startDate, 'YYYYMMDD') || startDatePeriod >= '" + startDate + startDatePeriod + "'";
            sql += " AND TO_CHAR(t1.startDate, 'YYYYMMDD') || startDatePeriod <= '" + endDate + endDatePeriod + "')";
            sql += " OR( TO_CHAR(t1.endDate, 'YYYYMMDD') || endDatePeriod >= '" + startDate + startDatePeriod + "'";
            sql += " AND TO_CHAR(t1.endDate, 'YYYYMMDD') || endDatePeriod <= '" + endDate + endDatePeriod + "')";
            sql += " OR ( '"+ startDate + startDatePeriod +"' between   (TO_CHAR(t1.startDate, 'YYYYMMDD')) || startDatePeriod and   ( TO_CHAR(t1.endDate, 'YYYYMMDD')) || endDatePeriod  ";
            sql += " AND '"+ endDate + endDatePeriod +"' between   (TO_CHAR(t1.startDate, 'YYYYMMDD')) || startDatePeriod and   ( TO_CHAR(t1.endDate, 'YYYYMMDD')) || endDatePeriod ) ) ";
            
            
            //log.debug(sql);
            ArrayList field = new ArrayList();
            field.add("takeLeave_id");
            ArrayList data = db.getResultSet(sql, field, null);
            for(int i = 0; i < data.size(); i++){
                takeLeaveId.add(((Hashtable)data.get(i)).get("takeLeave_id").toString());
            }
        }
        return takeLeaveId;
    }
    
    /** Performs database task depending on form state 
     * @return true if the action successfully done, false otherwise
     */
    public boolean doDBTask(){
        boolean isDone = false;
        String formState = getValue(this.ELM_NAME_FORM_STATE);
        if(formState.equals(this.FORM_STATE_NEW)){
            isDone = doDBInsert();
        } if(formState.equals(this.FORM_STATE_UPDATE_STATUS)){
            isDone = doDBUpdateStatus();
        } if(formState.equals(this.FORM_STATE_DELETE)){
            isDone = doDBDelete();
        }
        return isDone;
    }
    
    /**
     * Gets form properties from database
     */
    private void getDBData(String takeLeaveId) {
        String sql = " SELECT ";
        sql += " t1.takeLeave_id, t1.emp_id, TO_CHAR(t1.formIssueDate, 'YYYYMMDD') AS formIssueDate, t1.issueLocation, t1.leaveFormType";
        sql += ",  TO_CHAR(t1.formStartDate, 'YYYYMMDD') AS formStartDate, TO_CHAR(t1.formEndDate, 'YYYYMMDD') AS formEndDate , t1.formLeaveDays, t1.contactAddress, t1.remark";
        sql += ", t1.isNeedVisa, t1.formStatus, t1.to_country, t1.formStartDatePeriod, t1.formEndDatePeriod ";
        sql += ", t1.is_recent, t1.ref_takeLeave_id, t1.org_head_work_title";
        sql += ", t1.user_emp_id, t1.user_rootOrg_id, t1.recent_takeleave_id, t1.budgetYear";
        sql += ", TO_CHAR(t2.startDate, 'YYYYMMDD') AS startDate, TO_CHAR(t2.endDate, 'YYYYMMDD') AS endDate ";
        sql += ", t2.startDatePeriod, t2.endDatePeriod";
        sql += ", t2.takeLeaveDays, t2.leaveCategory_id";
        sql += ", t2.fldText1, t2.fldText2, t2.fldText3, t2.fldText4, t2.fldText5,  TO_CHAR(NVL(t2.assignDate, SYSDATE), 'YYYYMMDD') AS assignDate";
        sql += ", t2.is_leave_before, t2.status";
        sql += ", t3.from_emp_id, t3.to_emp_id, t3.sendPurpose_id";
        sql += ", 'update' AS formState, '0' AS logType, '1' AS logStatus, 'Read from database' AS logDetail" ;
        sql += ", '0' AS subLeaveFormType, '0' AS subFormCount, '-1' AS subFormDelete" ;
        sql += " FROM hr_leave_takeLeaveForm t1, hr_leave_takeleaveRec t2, hr_leave_token t3";
        sql += " WHERE t2.takeLeave_id(+) = t1.takeLeave_id ";
        sql += " AND t3.takeLeave_id(+) = t1.takeLeave_id ";
        sql += " AND t1.takeLeave_id = " + takeLeaveId;
        //log.debug(sql);
        Database db = new Database();
        ArrayList data = db.getResultSet(sql, elementNameList, null);
        if(data.size() > 0){
            for(int i = 0; i < elementNameList.size(); i++){
                String name = elementNameList.get(i).toString();
                String value = ((Hashtable)data.get(0)).get(name).toString();
                //log.debug("name=" + name + ", value=" + value);
                setValue(name, value);
            }
        }
    }
    
    /** Does DB task INSERT */
    protected boolean doDBInsert(){
        boolean isSuccess = true;
        Database db = new Database();
        String takeLeave_id = db.getNextVal(this.DB_SEQ_NAME);
        this.setValue(this.ELM_NAME_TAKE_LEAVE_ID, takeLeave_id);
        String emp_id = getValue(this.ELM_NAME_EMP_ID);
        String formIssueDate = getValue(this.ELM_NAME_MAKE_REQ_DATE);
        String issueLocation = getValue(this.ELM_NAME_MAKE_REQ_ORG);
        String leaveFormType = getValue(this.ELM_NAME_FORM_TYPE_ID);
        String formStartDate = getValue(this.ELM_NAME_FORM_START_DATE);
        String formEndDate = getValue(this.ELM_NAME_FORM_END_DATE);
        String formStartDatePeriod = getValue(this.ELM_NAME_FORM_START_DATE_PERIOD);
        String formEndDatePeriod = getValue(this.ELM_NAME_FORM_END_DATE_PERIOD);
        String formLeaveDays = getValue(this.ELM_NAME_LEAVE_DAY_COUNT_MASTER);
        String contactAddress = getValue(this.ELM_NAME_CONTACT_DETAIL);
        String isNeedVisa = getValue(this.ELM_NAME_IS_NEED_VISA);
        String formStatus = getValue(this.ELM_NAME_STATUS);
        String user_emp_id = getValue(this.ELM_NAME_USER_EMP_ID);
        String user_rootOrg_id = getValue(this.ELM_NAME_USER_ROOT_ORG_ID);
        String updateDate = "SYSDATE";
        String isRecent = getValue(this.ELM_NAME_IS_RECENT);
        String refTakeLeaveId = getValue(this.ELM_NAME_REF_TAKE_LEAVE_ID);
        String orgHeadWorkTitle = getValue(this.ELM_NAME_ORG_HEAD_WORK_TITLE);
        String toCountry = getValue(this.ELM_NAME_TO_COUNTRY);
        String budgetYear = getValue(this.ELM_NAME_BUDGET_YEAR);
        String remark = getValue(this.ELM_NAME_REMARK);
        
        String sql = "";
        sql = "INSERT INTO hr_leave_takeLeaveForm(";
        sql += "takeLeave_id, emp_id, formIssueDate, issueLocation, leaveFormType";
        sql += ", formStartDate, formEndDate, formLeaveDays, contactAddress";
        sql += ", formStartDatePeriod, formEndDatePeriod ";
        sql += ", isNeedVisa, formStatus, user_emp_id, user_rootOrg_id, updateDate";
        sql += ", is_recent, ref_takeLeave_id, org_head_work_title, to_country, remark, budgetYear ";
        sql += ")values(";
        sql += "'" + takeLeave_id + "'," + emp_id + ", TO_DATE('" + formIssueDate + "', 'YYYYMMDD'), '" + issueLocation + "', " +  leaveFormType;
        sql += ", TO_DATE('" + formStartDate + "', 'YYYYMMDD'), TO_DATE('" + formEndDate + "', 'YYYYMMDD'), " + formLeaveDays + ", '" + contactAddress + "' ";
        sql += "," + formStartDatePeriod + "," + formEndDatePeriod;
        sql += "," + isNeedVisa + "," + formStatus + "," + user_emp_id + "," + user_rootOrg_id + "," + updateDate;
        sql += "," + isRecent + ", '"  + refTakeLeaveId + "', '" + orgHeadWorkTitle + "', '" + toCountry + "', '" + remark + "', " + budgetYear;
        sql += ")";
        //log.debug(sql);
        isSuccess = db.executeUpdate(sql);
        
         String startDate = formStartDate;
         String endDate = formEndDate;
         String startDatePeriod = formStartDatePeriod;
         String endDatePeriod = formEndDatePeriod;
         String takeLeaveDays = formLeaveDays;
         String leaveCategory_id = getValue(this.ELM_NAME_FORM_CAT_ID);
         String fldText1 = getValue(this.ELM_NAME_TEXT_1);
         String fldText2 = getValue(this.ELM_NAME_TEXT_2);
         String fldText3 = getValue(this.ELM_NAME_TEXT_3);
         String fldText4 = getValue(this.ELM_NAME_TEXT_4);
         String fldText5 = getValue(this.ELM_NAME_TEXT_5);
         String assignDate = getValue(this.ELM_NAME_DETAIL_DATE);
         String is_leave_before = getValue(this.ELM_NAME_IS_LEAVE_BEFORE);
         String status = "1";
        
         sql = "INSERT INTO hr_leave_takeLeaveRec(";
         sql += "takeLeave_id, startDate, endDate, startDatePeriod, endDatePeriod";
         sql += ", takeLeaveDays, leaveCategory_id, budgetYear, contactAddress, remark";
         sql += ", fldText1, fldText2, fldText3, fldText4, fldText5, assignDate";
         sql += ", is_leave_before, status, user_emp_id, user_rootOrg_id, updateDate";
         sql += ")values(";
         sql += " '" + takeLeave_id + "', TO_DATE('" + startDate + "', 'YYYYMMDD'), TO_DATE('" + endDate + "', 'YYYYMMDD'), " + startDatePeriod + ", " + endDatePeriod + " ";
         sql += "," + takeLeaveDays + ", " + leaveCategory_id + ", " + budgetYear + ", '" + contactAddress + "', '" + remark + "' " ;
         sql += ",'" + fldText1 + "', '" + fldText2 + "', '" + fldText3 + "', '" + fldText4 + "', '" + fldText5 + "', TO_DATE('" + assignDate + "', 'YYYYMMDD') ";
         sql += ", " + is_leave_before + ", " + status + ", " + user_emp_id + ", " + user_rootOrg_id + ", " + updateDate + " ";
         sql += ")";
        //log.debug(sql);
         if(!leaveFormType.equals(this.FORM_TYPE_CANCEL) 
            && !leaveFormType.equals(this.FORM_TYPE_OUT_COUNTRY_WITHOUT_LEAVE)
            && !leaveFormType.equals(this.FORM_TYPE_OUT_COUNTRY_WITH_LEAVE)
            && !leaveFormType.equals(this.FORM_TYPE_NO_SIGN_IN_OUT)
            ){
            if(isSuccess) isSuccess = db.executeUpdate(sql);       
         }
        
        String tokenDate = "SYSDATE";
        String from_emp_id = getValue(this.ELM_NAME_FROM_EMP_ID);
        String to_emp_id = getValue(this.ELM_NAME_TO_EMP_ID);
        String sendPurpose_id = getValue(this.ELM_NAME_SEND_PURPOSE);
        String tokenStatus = "1";
        sql = "INSERT INTO hr_leave_token(";
        sql += "takeLeave_id, tokenDate, from_emp_id, to_emp_id, sendPurpose_id";
        sql += ", tokenStatus, user_emp_id, updateDate";
        sql += ")values(";
        sql += "'" + takeLeave_id + "', " + tokenDate + ", " + from_emp_id + ", " + to_emp_id + ", " + sendPurpose_id + " ";
        sql += ", " + tokenStatus + ", " + user_emp_id + ", " + updateDate;
        sql += ")";
        //log.debug(sql);
         if(isSuccess) isSuccess = db.executeUpdate(sql);

        String logDate = "SYSDATE";
        String logType = getValue(this.ELM_NAME_LOG_TYPE);
        String logSequence = "1";
        String logStatus = getValue(this.ELM_NAME_LOG_STATUS);
        String logDetail = getValue(this.ELM_NAME_LOG_DETAIL);
        if(logDetail.equals("")) logDetail = "เน�เธ�เธ�เน�เธ�เธ�เน�เธ�เธ�เน�เธ�เธ�เน�เธ�เธ�เน�เธ�เธ�เธญเธ�";
        sql = "INSERT INTO hr_leave_log(";
        sql += "takeLeave_id, logDate, logType, logSequence, logStatus";
        sql += ", from_emp_id, to_emp_id, logDetail";
        sql += ", user_emp_id, updateDate";
        sql += ")values(";
        sql += "'" + takeLeave_id + "', " + logDate + ", " + logType + ", " + logSequence + ", " + logStatus;
        sql += ", " + from_emp_id + ", " + to_emp_id + ", '" + logDetail + "' ";
        sql += ", " + user_emp_id + ", " + updateDate;
        sql += ")";
        //log.debug(sql);
         if(isSuccess) isSuccess = db.executeUpdate(sql);
         return isSuccess;
    }
    /** Does DB task UPDATE */
    protected boolean doDBUpdateStatus(){
        String takeLeave_id = getValue(this.ELM_NAME_TAKE_LEAVE_ID);
        String emp_id = getValue(this.ELM_NAME_EMP_ID);
        String formTypeId = getValue(this.ELM_NAME_FORM_TYPE_ID);
        String status = getValue(this.ELM_NAME_STATUS);
        String logDate = "SYSDATE";
        String logType = getValue(this.ELM_NAME_LOG_TYPE);
        String logSequence = "1";
        String logStatus = "1";
        String logDetail = getValue(this.ELM_NAME_LOG_DETAIL);
        String from_emp_id = getValue(this.ELM_NAME_FROM_EMP_ID);
        String to_emp_id = getValue(this.ELM_NAME_TO_EMP_ID);
        String user_emp_id = getValue(this.ELM_NAME_USER_EMP_ID);
        String updateDate = "SYSDATE";
        boolean isSuccess = true;
        String sql = "";
        
        Database db = new Database();
        if(status.equals(this.FORM_STATUS_ALLOW) && !formTypeId.equals(this.FORM_TYPE_CANCEL)){
            sql = " UPDATE hr_leave_takeLeaveForm ";
            sql += " SET formStatus = " + status;
            sql += ", is_recent = 1";
            sql += ", recent_takeleave_id = (SELECT takeleave_id FROM hr_leave_takeLeaveForm WHERE is_recent = 1 AND emp_id = " + emp_id + " AND leaveFormType = " + formTypeId + " )";
            sql += " WHERE takeleave_id = " + takeLeave_id;
            //log.debug(sql);
            if(isSuccess) isSuccess = db.executeUpdate(sql);
            sql = " UPDATE hr_leave_takeLeaveForm SET ";
            sql += " is_recent = 0 ";
            sql += " WHERE ";
            sql += " emp_id = " + emp_id;
            sql += " AND leaveFormType = " + formTypeId;
            sql += " AND takeLeave_id <> " + takeLeave_id;
            if(isSuccess) isSuccess = db.executeUpdate(sql);
        }else if(status.equals(this.FORM_STATUS_ALLOW) && formTypeId.equals(this.FORM_TYPE_CANCEL)){
            String formStartDate = getValue(this.ELM_NAME_FORM_START_DATE);
            String formEndDate = getValue(this.ELM_NAME_FORM_END_DATE);
            String formStartDatePeriod = getValue(this.ELM_NAME_FORM_START_DATE_PERIOD);
            String formEndDatePeriod = getValue(this.ELM_NAME_FORM_END_DATE_PERIOD);
            String formLeaveDays = getValue(this.ELM_NAME_LEAVE_DAY_COUNT_MASTER);
            String refTakeLeaveId = getValue(this.ELM_NAME_REF_TAKE_LEAVE_ID);
            FrmLeaveReq tempForm = new FrmLeaveReq(refTakeLeaveId);
            boolean changeAtStartDate = true;
            String currentStartDate = tempForm.getValue(tempForm.ELM_NAME_LEAVE_START_DATE) + tempForm.getValue(tempForm.ELM_NAME_LEAVE_START_DATE_PERIOD);
            if(currentStartDate.equals(formStartDate + formStartDatePeriod)) changeAtStartDate = false;
            sql = " UPDATE hr_leave_takeLeaveRec SET ";
            Calendar cal = Calendar.getInstance();
            gitex.utility.Date date = new gitex.utility.Date();
            if(changeAtStartDate){
                if(formStartDatePeriod.equals(this.FORM_PERIOD_MORNING)){
                    formStartDatePeriod = this.FORM_PERIOD_AFTERNOON;
                    cal.set(Integer.parseInt(formStartDate.substring(0, 4)), Integer.parseInt(formStartDate.substring(4, 6)) - 1, Integer.parseInt(formStartDate.substring(6, 8)));
                    cal.set(cal.DAY_OF_MONTH, cal.get(cal.DAY_OF_MONTH) - 1);
                    formStartDate = date.getDate(date.DATE_ENG, cal);
                }else{
                    formStartDatePeriod = this.FORM_PERIOD_MORNING;
                }
                sql += " endDate = TO_DATE('" + formStartDate + "', 'YYYYMMDD')";
                sql += ", endDatePeriod = " + formStartDatePeriod;                
            }else{
                if(formEndDatePeriod.equals(this.FORM_PERIOD_AFTERNOON)){
                    formStartDatePeriod = this.FORM_PERIOD_MORNING;
                    cal.set(Integer.parseInt(formEndDate.substring(0, 4)), Integer.parseInt(formEndDate.substring(4, 6)) - 1, Integer.parseInt(formEndDate.substring(6, 8)));
                    cal.set(cal.DAY_OF_MONTH, cal.get(cal.DAY_OF_MONTH) + 1);
                    formStartDate = date.getDate(date.DATE_ENG, cal);
                }else{
                    formEndDatePeriod = this.FORM_PERIOD_AFTERNOON;
                }
                sql += " startDate = TO_DATE('" + formEndDate + "', 'YYYYMMDD')";
                sql += ", startDatePeriod = " + formEndDatePeriod;
            }
            sql += ", takeLeaveDays = takeLeaveDays - " + formLeaveDays;
            sql += " WHERE takeleave_id = " + refTakeLeaveId;
            //log.debug(sql);
            if(isSuccess) isSuccess = db.executeUpdate(sql);

            sql = " UPDATE hr_leave_takeLeaveForm ";
            sql += " SET formStatus = " + this.FORM_STATUS_PARTIAL_CANCEL;
            sql += " WHERE takeleave_id = " + refTakeLeaveId;
            //log.debug(sql);
            if(isSuccess) isSuccess = db.executeUpdate(sql);

            sql = " UPDATE hr_leave_takeLeaveForm ";
            sql += " SET formStatus = " + status;
            sql += " WHERE takeleave_id = " + takeLeave_id;
            //log.debug(sql);
            if(isSuccess) isSuccess = db.executeUpdate(sql);
        }else{
            sql = "UPDATE hr_leave_takeLeaveForm ";
            sql += " SET formStatus = " + status;
            sql += " WHERE takeleave_id = " + takeLeave_id;
            //log.debug(sql);
             if(isSuccess) isSuccess = db.executeUpdate(sql);
        }
        
        String tokenDate = "SYSDATE";
        String sendPurpose_id = getValue(this.ELM_NAME_SEND_PURPOSE);
        String tokenStatus = "1";
        sql = " UPDATE hr_leave_token SET";
        sql += " tokenDate = " + tokenDate;
        sql += ", from_emp_id = " + from_emp_id;
        sql += ", to_emp_id = " + to_emp_id;
        sql += ", sendPurpose_id = " + sendPurpose_id;
        sql += ", tokenStatus = " + tokenStatus;
        sql += ", user_emp_id = " + user_emp_id;
        sql += ", updateDate = " + updateDate;
        sql += " WHERE takeLeave_id = " + takeLeave_id;
        //log.debug(sql);
         if(isSuccess) isSuccess = db.executeUpdate(sql);

        sql = "INSERT INTO hr_leave_log(";
        sql += "takeLeave_id, logDate, logType, logSequence, logStatus";
        sql += ", from_emp_id, to_emp_id, logDetail";
        sql += ", user_emp_id, updateDate";
        sql += ")values(";
        sql += "'" + takeLeave_id + "', " + logDate + ", " + logType + ", " + logSequence + ", " + logStatus;
        sql += ", " + from_emp_id + ", " + to_emp_id + ", '" + logDetail + "' ";
        sql += ", " + user_emp_id + ", " + updateDate;
        sql += ")";
         if(isSuccess) isSuccess = db.executeUpdate(sql);

        return isSuccess;
    }

    /** Does DB task UPDATE */
    protected boolean doDBDelete(){
        String takeLeave_id = getValue(this.ELM_NAME_TAKE_LEAVE_ID);  
        Database db = new Database();
        boolean isSuccess = true;
        String sql = "";
        sql = " UPDATE hr_leave_log ";
        sql += "SET logtype =4";
        sql += " WHERE takeleave_id = " + takeLeave_id;
        //log.debug(sql);
         if(isSuccess) isSuccess = db.executeUpdate(sql);
        sql = " UPDATE hr_leave_token ";
        sql += "SET tokenstatus =2";
        sql += " WHERE takeleave_id = " + takeLeave_id;
        //log.debug(sql);
         if(isSuccess) isSuccess = db.executeUpdate(sql);
        sql = " UPDATE hr_leave_takeLeaveRec ";
        sql += "SET status =3";
        sql += " WHERE takeleave_id = " + takeLeave_id;
        //log.debug(sql);
         if(isSuccess) isSuccess = db.executeUpdate(sql);
        sql = " UPDATE hr_leave_takeLeaveForm ";
        sql += "SET formstatus =3";
        sql += " WHERE takeleave_id = " + takeLeave_id;
        //log.debug(sql);
         if(isSuccess) isSuccess = db.executeUpdate(sql);
        return isSuccess;
    }
    
     
    
    /** Gets take leave id of a form having ref_takeleave_id refers to this form
     */
    public ArrayList getSubFormId(){
        String refId = this.getValue(this.ELM_NAME_TAKE_LEAVE_ID);
        ArrayList list = new ArrayList();
        if(!refId.equals("")){
            Database db = new Database();
            String sql = "";
            sql = " SELECT takeLeave_id FROM hr_leave_takeLeaveForm ";
            sql += " WHERE ref_takeleave_id = '" + refId + "'";
            ArrayList field = new ArrayList();
            field.add("takeLeave_id");
            ArrayList data = db.getResultSet(sql, field, null);
            if(data.size() > 0){
                for(int i = 0; i < data.size(); i++){
                    list.add(((Hashtable)data.get(i)).get("takeLeave_id").toString());
                }
            }
        }
        return list;
    }

    /** Gets string of time in the form of YYYYMMDDHHMMSS
     * @return string contains a current time in the form of YYYYMMDDHHMMSS
     */
    private String getYYYYMMDDhhmmss(){
        Calendar cal = Calendar.getInstance();
        String YYYY = String.valueOf(cal.get(cal.YEAR));
        String MM = String.valueOf(cal.get(cal.MONTH));
        if(Integer.parseInt(MM) < 10) MM = "0" + MM;
        
        String DD = String.valueOf(cal.get(cal.DATE));
        if(Integer.parseInt(DD) < 10) DD = "0" + DD;
        
        String hh = String.valueOf(cal.get(cal.HOUR_OF_DAY));
        if(Integer.parseInt(hh) < 10) hh = "0" + hh;
        
        String mm = String.valueOf(cal.get(cal.MINUTE));
        if(Integer.parseInt(mm) < 10) mm = "0" + mm;
        
        String ss = String.valueOf(cal.get(cal.SECOND));
        ss = String.valueOf(Integer.parseInt(ss) + 1000).substring(1, 4);
        
        return YYYY + MM + DD + hh + mm + ss;
    }
    
    /** Gets name of the period
     * @param periodCode a code of the period
     * @return name of the specified period
     */
    public String getPeriodName(String periodCode){
        if(periodCode.equals(this.FORM_PERIOD_MORNING)) return "เช้า";
        else if(periodCode.equals(this.FORM_PERIOD_AFTERNOON)) return "บ่าย";
        else return "ไม่ระบุ";
    }
    
    /** Get No Sign In text value
     * @param round round of NSI
     * @param time time of NSI
     * @return text value of NSI
     */
    public String getNSIText(String round, String time){
        String textValue = "";
        if(round.equals(this.FORM_NSI_0730)) textValue = "รอบ 07.30 น.";
        else if(round.equals(this.FORM_NSI_0830)) textValue = "รอบ 08.30 น.";
        else if (round.equals(this.FORM_NSI_0930)) textValue = "รอบ 09.30 น. ";
        
        if(time.equals(this.FORM_NSI_IN)) textValue += " เวลามาปฏิบัติงาน";
        else if(time.equals(this.FORM_NSI_OUT)) textValue += " เวลาเลิกงาน";
        else if(time.equals(this.FORM_NSI_IN_OUT)) textValue += " เวลามาปฏิบัติงานและเวลาเลิกงาน";
        
        return textValue;
    }
}
