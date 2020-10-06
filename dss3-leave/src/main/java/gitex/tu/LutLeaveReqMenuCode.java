/*
 * LutLeaveReqMenuCode.java
 *
 * Created on 3 �չҤ� 2550, 0:15 �.
 *
 * To change this template, choose Tools | Template Manager
 * and open the template in the editor.
 */

package gitex.tu;

import javax.servlet.http.*;
import java.util.*;

/**
 *
 * @author pantape
 */
public class LutLeaveReqMenuCode {
    /** menu name mapper */
    private Hashtable mapper;
    
    /** initail task code mapper */
    private Hashtable iniTaskCodeMapper;
    
    /** welcome page */
    public static String WELCOME = "1";
    
    /** check leave request */
    public static String CHECK_REQ_STATUS = "2";
    
    /** domestic leave request */
    public static String IN_COUNTRY_LEAVE_REQ = "3";
    
    /** out country leave request */
    public static String OUT_COUNTRY_LEAVE_REQ = "4";
    
    /** leave history */
    public static String LEAVE_HISTORY = "5";
    
    /** wating attention req */
    public static String WAITING_APPROVE_REQ = "6";

    /** wating attention req */
    public static String LEAVE_REPORT = "7";

    /** wating attention req */
    public static String LEAVE_MGR = "110";
    
    /** command tree */
    public static String COMMAND_TREE = "120";

    /** command tree */
    public static String SYS_ADMIN = "130";

    /** visa doc */
    public static String VISA_DOC_MGR = "140";

    /** leave spacial mgr */
    public static String EXTRA_LEAVE_MGR = "150";

    /** holidays mgr */
    public static String HOLIDAYS_MGR = "160";

    /** period */
    //ยกเลิกเมนูเนื่องจากไม่มีการมาสายแล้ว
    //public static String PERIOD="14";
    
    /** check worktime **/
    public static String WORKTIME="15";
    
    /** Form **/
    public static String FORM="16";
    
    /** log out */
    public static String LOGOUT = "9999";
    
    /** Creates a new instance of LutLeaveReqMenuCode */
    public LutLeaveReqMenuCode() {
        /* mapping menu code to menu name */
        mapper = new Hashtable();
        mapper.put(WELCOME, "ยินดีต้อนรับ");
        mapper.put(CHECK_REQ_STATUS, "ตรวจสอบคำร้อง");
        mapper.put(IN_COUNTRY_LEAVE_REQ, "ยื่นคำร้องการลา/ขออนุญาต");
        mapper.put(OUT_COUNTRY_LEAVE_REQ, "ลาไปต่างประเทศ");
        mapper.put(LEAVE_HISTORY, "ประวัติการลา");
        mapper.put(WAITING_APPROVE_REQ, "คำร้องรอพิจารณา");
        mapper.put(LEAVE_REPORT, "รายงานการลา");
        mapper.put(LEAVE_MGR, "จัดการคำร้อง");
        mapper.put(COMMAND_TREE, "โครงสร้างบุคลากร");
        mapper.put(SYS_ADMIN, "จัดการผู้ดูแลระบบ");
        mapper.put(VISA_DOC_MGR, "รายชื่อผู้ขอหนังสือรับรองเพื่อขอวีซ่า");
        mapper.put(EXTRA_LEAVE_MGR, "จัดการคำร้องแบบพิเศษ");
        mapper.put(HOLIDAYS_MGR, "จัดการวันหยุดราชการ");
        mapper.put(LOGOUT, "ล็อคเอ้าท์");
        //ยกเลิกเมนูเนื่องจากไม่มีการมาสายแล้ว
        //mapper.put(PERIOD,"สถิติการมาสาย");
        mapper.put(FORM, "แบบฟอร์มอื่นๆ");
        mapper.put(WORKTIME, "เวลาปฏิบัติงาน");
        
        /* mapping menu code to initial task code */
        iniTaskCodeMapper = new Hashtable();
        iniTaskCodeMapper.put(WELCOME, LutLeaveReqTaskCode.VIEW_LEAVE_STAT);
        iniTaskCodeMapper.put(CHECK_REQ_STATUS, LutLeaveReqTaskCode.CHECK_REQ_STATUS_1);
        iniTaskCodeMapper.put(IN_COUNTRY_LEAVE_REQ, LutLeaveReqTaskCode.REQ_IN_COUNTRY_LEAVE_1);
        iniTaskCodeMapper.put(OUT_COUNTRY_LEAVE_REQ, LutLeaveReqTaskCode.REQ_OUT_COUNTRY_LEAVE_1);
        iniTaskCodeMapper.put(LEAVE_HISTORY, LutLeaveReqTaskCode.VIEW_LEAVE_HISTORY_1);
        iniTaskCodeMapper.put(WAITING_APPROVE_REQ, LutLeaveReqTaskCode.VIEW_WAITING_APPROVE_REQ_1);
        iniTaskCodeMapper.put(LEAVE_REPORT, LutLeaveReqTaskCode.VIEW_LEAVE_REPORT_1);
        iniTaskCodeMapper.put(LEAVE_MGR, LutLeaveReqTaskCode.MANAGE_LEAVE_1);
        iniTaskCodeMapper.put(COMMAND_TREE, LutLeaveReqTaskCode.MANAGE_COMMAND_TREE_1);
        iniTaskCodeMapper.put(SYS_ADMIN, LutLeaveReqTaskCode.MANAGE_ADMIN_1);
        iniTaskCodeMapper.put(VISA_DOC_MGR, LutLeaveReqTaskCode.MANAGE_VISA_DOC_1);
        iniTaskCodeMapper.put(EXTRA_LEAVE_MGR, LutLeaveReqTaskCode.MANAGE_LEAVE_EXTRA_1);
        iniTaskCodeMapper.put(HOLIDAYS_MGR, LutLeaveReqTaskCode.MANAGE_HOLIDAYS_1);
        iniTaskCodeMapper.put(LOGOUT, LutLeaveReqTaskCode.LOGOUT_USER);
        //ยกเลิกเมนูเนื่องจากไม่มีการมาสายแล้ว
        //iniTaskCodeMapper.put(PERIOD, LutLeaveReqTaskCode.PERIOD);
        iniTaskCodeMapper.put(WORKTIME, LutLeaveReqTaskCode.WORKTIME);
        iniTaskCodeMapper.put(FORM, LutLeaveReqTaskCode.VIEW_MISC_FORM);
    }
    
    /** Gets menu name corresponding to the provided menu code
     * @param menuCode menu code
     * @return menu name, if the menu code does not exist the blank string is returned.
     */
    public String getMenuName(String menuCode){
        if(mapper.containsKey(menuCode)){
            return mapper.get(menuCode).toString();
        }else
            return "";        
    }
    
    /** Gets initial task code for this menu
     * @param menuCode menu code
     * @return task code, if the menu code does not exist the blank string is returned.
     */
    public String getInitialTaskCode(String menuCode){
        if(mapper.containsKey(menuCode)){
            return iniTaskCodeMapper.get(menuCode).toString();
        }else
            return "";        
    }
}
