package gitex.tu.htmlForm;

import gitex.html.HtmlForm;

public class FrmVehicleOvernightReq extends HtmlForm {

	public static final String ELM_NAME_ID = "id";
	
	 /** form element name fiscalyear **/
	/**
 create table hr_vehicle_overnight_reqform (
    id  number(15) not null,
    formrunningnum number(10) not null,
    fiscalyear number(4) not null,
    emp_id number(15) not null,
    emp_title varchar2(100) not null,
    emp_org varchar2(100) not null,
    formissuedate date not null,
    ORG_HEAD_WORK_TITLE varchar2(100),
    start_overnight date not null,
    end_overnight date not null,
    license_number varchar2(30) not null,
    license_province_id number(15) not null,
    reason VARCHAR2(4000) not null,
    status varchar2(30) not null,
    CONSTRAINT overnight_reqform_pk PRIMARY KEY (id),
    CONSTRAINT overnight_reqform_fk_province FOREIGN KEY (license_province_id) REFERENCES glb_province(province_id)
);
	 */
    public static final String ELM_NAME_FISCALYEAR = "fiscalyear";
    public static final String ELM_NAME_FORM_RUNNING_NUM = "formrunningnum";
    public static final String ELM_NAME_ORG_HEAD_WORK_TITLE = "org_head_work_title";
    public static final String ELM_NAME_REQ_NAME = "emp_name";
    public static final String ELM_NAME_REQ_TITLE = "emp_title";
    public static final String ELM_NAME_FORM_ISSUE_DATE = "formissuedate";
    
    public static final String ELM_NAME_START_OVERNIGHT = "start_overnight";
    public static final String ELM_NAME_END_OVERNIGHT = "end_overnight";
    public static final String ELM_NAME_LICENSE_NUMBER = "license_number";
    public static final String ELM_NAME_LICENSE_PROVINCE = "license_province";
    public static final String ELM_NAME_REASON = "reason";
    
    public static final String ELM_NAME_STATUS = "status";

	
}