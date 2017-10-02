/*
 * FrmLateAbsent.java
 *
 * Created on 9 กรกฎาคม 2550, 7:15 น.
 *
 * To change this template, choose Tools | Template Manager
 * and open the template in the editor.
 */

package gitex.tu.htmlForm;
import javax.servlet.http.*;
import java.util.*;
import gitex.tu.*;
import gitex.html.*;
import gitex.utility.*;

/**
 *
 * @author pantape
 */
public class FrmLateAbsent extends HtmlForm {
    /** element name */
    public static String ELM_NAME_LABS_ID = "fla_labsId";
    /** element name */
    public static String ELM_NAME_EMP_ID = "fla_empId";
    /** element name */
    public static String ELM_NAME_BUDGET_YEAR = "fla_budgetYear";
    /** element name */
    public static String ELM_NAME_TYPE = "fla_type";
    /** element name */
    public static String ELM_NAME_DATE = "fla_date";
    /** element name */
    public static String ELM_NAME_DATE_END = "fla_date_end";
    /** element name */
    public static String ELM_NAME_DATE_COUNT = "fla_count";
    /** element name */
    public static String ELM_NAME_DATE_PERIOD = "fla_datePeriod";
    /** element name */
    public static String ELM_NAME_TASK = "fla_task";

    /** task name */
    public final String TASK_ADD = "1";
    public final String TASK_DELETE = "2";
    
    /** static value */
    public static final String TYPE_LATE = "1";
    public static final String TYPE_ABSENT = "2";
    public static final String TYPE_NO_CLASS = "3";
    public static final String PERIOD_MORNING = "0";
    public static final String PERIOD_AFTERNOON = "1";
    public static final String PERIOD_WHOLE_DAY = "2";
    
    /** task message */
    public String taskMsg = "";
    
    /** Creates a new instance of FrmLateAbsent */
    public FrmLateAbsent() {}
    
    public FrmLateAbsent(HttpServletRequest request, User user) {
        ArrayList elmName = new ArrayList();
        elmName.add(ELM_NAME_LABS_ID);
        elmName.add(ELM_NAME_EMP_ID);
        elmName.add(ELM_NAME_BUDGET_YEAR);
        elmName.add(ELM_NAME_TYPE);
        elmName.add(ELM_NAME_DATE);
        elmName.add(ELM_NAME_DATE_END);
        elmName.add(ELM_NAME_DATE_COUNT);
        elmName.add(ELM_NAME_DATE_PERIOD);
        elmName.add(ELM_NAME_TASK);
        this.setValues(request, elmName);
        
        String empId = this.getValue(ELM_NAME_EMP_ID);
        String task = this.getValue(ELM_NAME_TASK);
        if(!empId.equals("") && !task.equals("")){
            if(task.equals(TASK_ADD)){
                if(!this.addToDB(empId, user.employee.empId)){
                    this.taskMsg = "เกิดข้อผิดพลาดในการบันทึกข้อมูล กรุณาบันทึกใหม่อีกครั้ง หรือติดต่อเจ้าหน้าที่";
                }else{
                    this.taskMsg = "ข้อมูลได้ถูกบันทึกเรียบร้อยแล้ว";
                }
            }else if(task.equals(TASK_DELETE)){
                if(!this.getValue(this.ELM_NAME_LABS_ID).equals("")){
                    if(!this.deleteFromDB(this.getValues(this.ELM_NAME_LABS_ID))){
                        this.taskMsg = "เกิดข้อผิดพลาดในการลบข้อมูล กรุณาลบใหม่อีกครั้ง หรือติดต่อเจ้าหน้าที่";
                    }else{
                        this.taskMsg = "ข้อมูลได้ถูกลบออกเรียบร้อยแล้ว";
                    }
                }else{
                    this.taskMsg = "คุณไม่ได้เลือกข้อมูลที่ต้องการลบ";
                }
            }
        }
    }
    
    /** Gets a name of late-absent type
     * @param typeCode a type code
     * @return a name of the late-absent type, blank string if there is no such a type
     */
    public String getTypeName(String typeCode){
        String typeName = "";
        if(typeCode.equals(this.TYPE_ABSENT)) typeName = "ขาด";
        if(typeCode.equals(this.TYPE_LATE)) typeName = "มาสาย";
        if(typeCode.equals(this.TYPE_NO_CLASS)) typeName = "ปลอดการสอน";
        return typeName;
    }

    /** Gets a name of late-absent period
     * @param periodCode a period code
     * @return a name of the late-absent period, blank string if there is no such a period
     */
    public String getPeriodName(String periodCode){
        String periodName = "";
        if(periodCode.equals(this.PERIOD_AFTERNOON)) periodName = "บ่าย";
        if(periodCode.equals(this.PERIOD_MORNING)) periodName = "เช้า";
        if(periodCode.equals(this.PERIOD_WHOLE_DAY)) periodName = "ทั้งวัน";
        return periodName;
    }
    
    /** Adds data into the database */
    private boolean addToDB(String empId, String userEmpId){
        Database db = new Database();
        String sql = "";
        String budgetYear = this.getValue(ELM_NAME_BUDGET_YEAR);
        String flaType = this.getValue(ELM_NAME_TYPE);
        String flaDate = this.getValue(ELM_NAME_DATE);
        String flaDateEnd = this.getValue(ELM_NAME_DATE_END);
        String flaPeriod = this.getValue(ELM_NAME_DATE_PERIOD);
        String flaCount = this.getValue(ELM_NAME_DATE_COUNT);
        if(!flaType.equals(this.TYPE_NO_CLASS)){
            flaCount = "1"; //Whole day
            if(flaPeriod.equals("0") || flaPeriod.equals("1")) flaCount = "0.5";
            flaDateEnd = flaDate;
        }else{
            flaPeriod = "2";
        }
        sql = "INSERT INTO hr_leave_late_absent(";
        sql += "budgetYear, emp_id, labs_date, labs_date_end, labs_period, labs_type";
        sql += ", labs_count, user_emp_id, updateDate";
        sql += ")VALUES(";
        sql += budgetYear + ", " + empId + ", TO_DATE('" + flaDate + "', 'YYYYMMDD')" + ", TO_DATE('" + flaDateEnd + "', 'YYYYMMDD')" ;
        sql += ", " + flaPeriod + ", " + flaType + ", " + flaCount + ", " + userEmpId + ", SYSDATE";
        sql += ")";
        return db.executeUpdate(sql);
    }
    
    /** Delete data from the database */
    private boolean deleteFromDB(String[] labsId){
        Database db = new Database();
        String sql = "";
        String labsIdList = "";
        for(int i = 0; i < labsId.length; i++){
            if(i > 0) labsIdList += ", ";
            labsIdList += labsId[i];
        }
        sql = "DELETE hr_leave_late_absent WHERE labs_id IN(" + labsIdList + ")";
        return db.executeUpdate(sql);
    }
}
