/*
 * LeaveHolidays.java
 *
 * Created on 14 ÁÔ¶Ø¹ÒÂ¹ 2550, 13:43 ¹.
 *
 * To change this template, choose Tools | Template Manager
 * and open the template in the editor.
 */

package gitex.tu;

import gitex.utility.Database;
import java.util.*;
import gitex.html.*;
import gitex.tu.htmlForm.*;

/**
 *
 * @author pantape
 */
public class LeaveHolidays {
    /**field name */
    public final String ID = "hID";
    public final String DATE = "hDate";
    public final String NAME = "hName";
    /** holiday list */
    public ArrayList list = new ArrayList();
    
    /** Creates a new instance of LeaveHolidays */
    public LeaveHolidays() {
    }

    /** Creates a new instance of LeaveHolidays 
     * which holiday list is in the specified budget year
     */
    public LeaveHolidays(int budgetYear) {
        setBudgetYear(budgetYear);
    }
    
    /** Sets holiday list according to the specified budget year
     * @param budgetYear budget year
     */
    public void setBudgetYear(int budgetYear){
        while(budgetYear > 2250){
            budgetYear -= 543;
        }
        Database db = new Database();
        String sql = "";
        sql = " SELECT holiday_id AS " + this.ID;
        sql += ", TO_CHAR(holiday_date, 'YYYYMMDD') AS " + this.DATE;
        sql += ", holidayCall AS " + this.NAME;
        sql += " FROM hr_leave_holiday ";
        sql += " WHERE year_setHoliday = " + budgetYear;
        sql += " ORDER BY holiday_date ";
        ArrayList field = new ArrayList();
        field.add(this.ID);
        field.add(this.DATE);
        field.add(this.NAME);
        Hashtable dataType = new Hashtable();
        this.list = db.getResultSet(sql, field, null);
    }
    
    /** Add new holidays
     * @param hDate string contains holiday date in the form YYYYMMDD
     * @param hName name of the holiday
     * @param budgetYear budget year of the holiday
     * @param user user who adds the holiday
     * @return true if the operation is done successfully, false otherwise
     */
    public boolean add(String hDate, String hName, int budgetYear, User user){
        Database db = new Database();
        String sql = "";
        sql = " INSERT INTO hr_leave_holiday(";
        sql += " holiday_date, holidayCall, year_setHoliday, user_emp_id, updateDate ";
        sql += " )VALUES(";
        sql += " TO_DATE('" + hDate + "', 'YYYYMMDD')";
        sql += ", '" + hName + "'";
        sql += ", " + budgetYear;
        sql += ", " + user.employee.empId;
        sql += ", SYSDATE ";
        sql += " )";
        return db.executeUpdate(sql);
    }
    
    /** Delete holidays
     * @param hId String contains holiday ids seperated by comma if there are more than one
     * @return true if the operation is done successfully, false otherwise
     */
    public boolean delete(String hId){
        Database db = new Database();
        String sql = "";
        sql = " DELETE FROM hr_leave_holiday";
        sql += " WHERE holiday_id IN(" + hId + ")";
        return db.executeUpdate(sql);
    }

    /** Coppies holidays from one year to another year
     * @param fromYear budget year to coppy from
     * @param toYear budget year to coppy to
     * @param user user who coppies the holidays
     * @return true if the operation is done successfully, false otherwise
     */
    public boolean coppy(int fromYear, int toYear, User user){
        boolean res = true;
        Database db = new Database();
        String sql = "";
        sql = " SELECT ";
        sql += " TO_CHAR(holiday_date, 'YYYYMMDD') AS holiday_date, holidayCall ";
        sql += " FROM hr_leave_holiday ";
        sql += " WHERE year_setHoliday = " + fromYear;
        ArrayList field = new ArrayList();
        field.add("holiday_date");
        field.add("holidayCall");
        ArrayList data = db.getResultSet(sql, field, null);
        for(int i = 0; i < data.size(); i++){
            String hDate = ((Hashtable)data.get(i)).get("holiday_date").toString();
            String hName = ((Hashtable)data.get(i)).get("holidayCall").toString();
            int hYear = Integer.parseInt(hDate.substring(0, 4));
            int hYYYY = toYear + hYear - fromYear;
            String hMMDD = hDate.substring(4, 8);
            sql = " INSERT INTO hr_leave_holiday(";
            sql += " holiday_date, holidayCall, year_setHoliday, user_emp_id, updateDate ";
            sql += ")VALUES(";
            sql += "TO_DATE('" + String.valueOf(hYYYY) + hMMDD + "', 'YYYYMMDD') ";
            sql += ", '" + hName + "' ";
            sql += ", " + toYear;
            sql += ", " + user.employee.empId;
            sql += ", SYSDATE";
            sql += ")";
            res = db.executeUpdate(sql);
            if(!res) break;
        }
        return res;
    }
}
