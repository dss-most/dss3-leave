/*
 * LeaveReqLog.java
 *
 * Created on 13 ÁÔ¶Ø¹ÒÂ¹ 2550, 9:46 ¹.
 *
 * To change this template, choose Tools | Template Manager
 * and open the template in the editor.
 */

package gitex.tu;

import gitex.utility.Database;
import java.util.*;

/**
 *
 * @author pantape
 */
public class LeaveReqLog {
    /** Key name for retreiving value */
    public final String DATE = "logDate";
    public final String DETAIL = "logDetail";
    public final String FROM = "fromEmp";
    public final String TO = "toEmp";
    public final String BY = "byEmp";
    /** Data object */
    public ArrayList logList = new ArrayList();
    /** Creates a new instance of LeaveReqLog */
    public LeaveReqLog(String takeLeaveId) {
        gitex.utility.Date date = new gitex.utility.Date();
        Database db = new Database();
        String sql = "";
        sql = " SELECT TO_CHAR(t1.logDate, 'YYYYMMDDHH24MI') AS logDate, t1.logDetail ";
        sql += ", t2.emp_name AS fromEmp, t3.emp_name AS toEmp, t4.emp_name AS byEmp ";
        sql += " FROM hr_leave_log t1, hr_v_employee t2, hr_v_employee t3, hr_v_employee t4 ";
        sql += " WHERE t1.takeLeave_id = '" + takeLeaveId + "'";
        sql += " AND t1.from_emp_id = t2.emp_id(+) ";
        sql += " AND t1.to_emp_id = t3.emp_id(+) ";
        sql += " AND t1.user_emp_id = t4.emp_id(+) ";
        sql += " ORDER BY t1.logDate ";
        ArrayList field = new ArrayList();
        field.add(DATE);
        field.add(FROM);
        field.add(TO);
        field.add(DETAIL);
        field.add(BY);
        Hashtable dataType = new Hashtable();
        logList = db.getResultSet(sql, field, dataType);
        for(int i = 0; i < logList.size(); i++){
            Hashtable elm = new Hashtable();
            elm = (Hashtable)logList.get(i);
            String yyyymmdd = elm.get(DATE).toString();
            Hashtable textDate = date.getDate(yyyymmdd, date.MONTH_NAME_SHORT_WITH_TIME);
            String thaiDate = textDate.get(date.DATE_THAI).toString();
            elm.put(DATE, thaiDate);
            logList.remove(i);
            logList.add(i, elm);
        }
    }
}
