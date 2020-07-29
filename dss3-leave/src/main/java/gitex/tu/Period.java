/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package gitex.tu;

/**
 *
 * @author Administrator
 */
import java.sql.*;
import java.util.*;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;



import gitex.utility.*;
import gitex.tu.htmlForm.*;

public class Period {
	public Logger logger = LoggerFactory.getLogger(this.getClass());
	
    public Period(){
    ;
    }
    
    
        public void setPeriod(int emp_id,int year){
              Database db = new Database();
        ArrayList field = new ArrayList();
        field.add("per1");
        
        sql = "";
        sql+= "select  count(emp_id) per1  ";
  	sql+=" from hr_leave_late_period a";
	sql+="  where  late_period=1 	";								 						 
	sql+=" and budgetyear="+year+" ";
	sql+=" and emp_id="+emp_id+"  ";
	sql += " and not exists ( select *  ";
    sql += " from hr_leave_takeleaveform ";
    sql += " where user_emp_id= "+emp_id+"  ";
    sql += " and budgetyear="+year+" ";
    sql += " and trunc(a.work_date) between formstartdate and formenddate   ";
    sql += " and ((formstartdateperiod <> 1 and formenddateperiod <> 1)  ";
    sql += "    or(formstartdateperiod = 0 and formenddateperiod = 1)  ";
    sql += "    or(formstartdateperiod = 0 and formenddateperiod = 0))  ";                	
    sql += " and FORMSTATUS='2' )  ";
	
      
       // log.debug(sql);
        ArrayList data = db.getResultSet(sql, field, null);
        if(data.size() > 0){
            this.per1 = ((Hashtable)data.get(0)).get("per1").toString();
        }
        sql= "select  count(emp_id) per2  ";
  	sql+=" from hr_leave_late_period a";
	sql+="  where  late_period=2 	";								 						 
	sql+=" and budgetyear="+year+" ";
	sql+=" and emp_id="+emp_id+"  ";
	sql += " and not exists ( select *  ";
    sql += " from hr_leave_takeleaveform ";
    sql += " where user_emp_id= "+emp_id+"  ";
    sql += " and budgetyear="+year+" ";
    sql += " and trunc(a.work_date) between formstartdate and formenddate   ";
    sql += " and ((formstartdateperiod <> 1 and formenddateperiod <> 1)  ";
    sql += "    or(formstartdateperiod = 0 and formenddateperiod = 1)  ";
    sql += "    or(formstartdateperiod = 0 and formenddateperiod = 0))  ";               	
    sql += " and FORMSTATUS='2' )  ";
    sql += " and work_date <= to_date('30 JUN 2020') ";
    
        field.clear();
        field.add("per2");
        data.clear();
        data = db.getResultSet(sql, field, null);
        if(data.size() > 0){
            this.per2 = ((Hashtable)data.get(0)).get("per2").toString();
       
        }
    }
    

    
    public String sql="";
    public String per1="";
    public String per2="";
}
