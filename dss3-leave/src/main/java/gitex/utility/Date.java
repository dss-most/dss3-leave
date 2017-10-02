/*
 * Date.java
 *
 * Created on 6 มีนาคม 2550, 14:09 น.
 *
 * To change this template, choose Tools | Template Manager
 * and open the template in the editor.
 */

package gitex.utility;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 *  Provides date utility
 * @author pantape
 */
public class Date {
	public static SimpleDateFormat thaiISODate = new SimpleDateFormat("yyyy-MM-dd", new Locale("th","TH"));
	public static SimpleDateFormat thaiShortDate = new SimpleDateFormat("d MMM yyyy", new Locale("th","TH"));
	
	public static String thaiShortDateStr(String s) {
		
		try {
			java.util.Date d = thaiISODate.parse(s);
			return thaiShortDate.format(d);
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}
	
    /** month name type Thai full name */
    public static String MONTH_NAME_FULL = "monthNameFull";
    public static String MONTH_NAME_FULL_WITH_TIME = "monthNameFullWithTime";
    
    /** month name type Thai short name */
    public static String MONTH_NAME_SHORT = "monthNameShort";
    public static String MONTH_NAME_SHORT_WITH_TIME = "monthNameShortWithTime";
    
    /** key name for getting Thai date */
    public static String DATE_THAI = "dateThai";
    
    /** key name for getting English date */
    public static String DATE_ENG = "dateEng";
    
    /** Creates a new instance of Date */
    public Date() {
    }
    
    /** Gets date from calendar
     * @param calendar calendar object
     * @param month_name_type month name type
     * @return hashtable contains Thai and English date use property DATE_THAI to 
     * obtain Thai date and DATE_ENGLISH to obtain English date.
     */
    public static Hashtable getDate(Calendar calendar, String month_name_type){
	String [] monthNameTHFull = {"มกราคม", "กุมภาพันธ์","มีนาคม","เมษายน","พฤษภาคม","มิถุนายน","กรกฎาคม","สิงหาคม","กันยายน","ตุลาคม","พฤศจิกายน","ธันวาคม"};
	String [] monthNameENGFull = {"January", "Febuary","March","April","May","June","July","August","September","October","November","December"};
	String [] monthNameTHShort = {"ม.ค.", "ก.พ.","มี.ค.","เม.ย.","พ.ค.","มิ.ย.","ก.ค.","ส.ค.","ก.ย.","ต.ค.","พ.ย.","ธ.ค."};
	String [] monthNameENGShort = {"Jan", "Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"};
	int day = calendar.get(Calendar.DAY_OF_MONTH);
	int month = calendar.get(Calendar.MONTH) - 1;
	int year = calendar.get(Calendar.YEAR);
	int year_th = year;
	int year_eng = year;
	while(year_eng > 2250){ year_eng -= 543;}
	while(year_th < 2250){ year_th += 543;}
        String date_eng = "";
        String date_th = "";
        date_eng = String.valueOf(day);
        date_th = String.valueOf(day);
        if(month_name_type.equals(MONTH_NAME_FULL) || month_name_type.equals(MONTH_NAME_FULL_WITH_TIME)){
            date_eng += " " + monthNameENGFull[month] + " " + String.valueOf(year_eng);
            date_th += " " + monthNameTHFull[month] + " พ.ศ." + String.valueOf(year_th);
        }else{
            date_eng += " " + monthNameENGShort[month] + " " + String.valueOf(year_eng).substring(2, 4);
            date_th += " " + monthNameTHShort[month] + String.valueOf(year_th).substring(2, 4);
        }
        if(month_name_type.equals(MONTH_NAME_SHORT_WITH_TIME) || month_name_type.equals(MONTH_NAME_FULL_WITH_TIME)){
            String hour = "00";
            String minute = "00";
            if(calendar.get(Calendar.MINUTE) > 9) minute = String.valueOf(calendar.get(Calendar.MINUTE));
            else  minute = "0" + String.valueOf(calendar.get(Calendar.MINUTE));
            if(calendar.get(Calendar.HOUR_OF_DAY) > 9) hour = String.valueOf(calendar.get(Calendar.HOUR_OF_DAY));
            else  hour = "0" + String.valueOf(calendar.get(Calendar.SECOND));
            date_eng += " " + hour + ":" + minute;
            date_th += " " + hour + ":" + minute;
        }
        Hashtable date = new Hashtable();
        date.put(DATE_THAI, date_th);
        date.put(DATE_ENG, date_eng);
	return date;
    }
    /** Gets date from date string format YYYYMMDD
     * @param yyyymmdd date string where yyyy = year, mm = month and dd = day
     * @param month_name_type month name type
     * @return hashtable contains Thai and English date use property DATE_THAI to 
     * obtain Thai date and DATE_ENGLISH to obtain English date.
     */
    public static Hashtable getDate(String yyyymmdd, String month_name_type){
	String [] monthNameTHFull = {"มกราคม", "กุมภาพันธ์","มีนาคม","เมษายน","พฤษภาคม","มิถุนายน","กรกฎาคม","สิงหาคม","กันยายน","ตุลาคม","พฤศจิกายน","ธันวาคม"};
	String [] monthNameENGFull = {"January", "Febuary","March","April","May","June","July","August","September","October","November","December"};
	String [] monthNameTHShort = {"ม.ค.", "ก.พ.","มี.ค.","เม.ย.","พ.ค.","มิ.ย.","ก.ค.","ส.ค.","ก.ย.","ต.ค.","พ.ย.","ธ.ค."};
	String [] monthNameENGShort = {"Jan", "Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"};
        if(yyyymmdd.equals("")) yyyymmdd = getDate(Date.DATE_ENG);
	int day = Integer.parseInt(yyyymmdd.substring(6, 8));
	int month = Integer.parseInt(yyyymmdd.substring(4, 6)) - 1;
	int year = Integer.parseInt(yyyymmdd.substring(0, 4));
	int year_th = year;
	int year_eng = year;
	while(year_eng > 2250){ year_eng -= 543;}
	while(year_th < 2250){ year_th += 543;}
        String date_eng = "";
        String date_th = "";
        date_eng = String.valueOf(day);
        date_th = String.valueOf(day);
        if(month_name_type.equals(MONTH_NAME_FULL) || month_name_type.equals(MONTH_NAME_FULL_WITH_TIME)){
            date_eng += " " + monthNameENGFull[month] + " " + String.valueOf(year_eng);
            date_th += " " + monthNameTHFull[month] + " พ.ศ." + String.valueOf(year_th);
        }else{
            date_eng += " " + monthNameENGShort[month] + " " + String.valueOf(year_eng).substring(2, 4);
            date_th += " " + monthNameTHShort[month] + String.valueOf(year_th).substring(2, 4);
        }
        if(month_name_type.equals(MONTH_NAME_SHORT_WITH_TIME) || month_name_type.equals(MONTH_NAME_FULL_WITH_TIME)){
            int numHour = Integer.parseInt(yyyymmdd.substring(8, 10));
            int numMinute = Integer.parseInt(yyyymmdd.substring(10, 12));
            String hour = "00";
            String minute = "00";
            if(numHour > 9) hour = String.valueOf(numHour);
            else  hour = "0" + String.valueOf(numHour);
            if(numMinute > 9) minute = String.valueOf(numMinute);
            else  minute = "0" + String.valueOf(numMinute);
            date_eng += " " + hour + ":" + minute;
            date_th += " " + hour + ":" + minute;
        }
	Hashtable date = new Hashtable();
        date.put(DATE_THAI, date_th);
        date.put(DATE_ENG, date_eng);
	return date;
    }
    
    /** Gets date string format YYYYMMDD from Calender object
     * @return string of date in a format YYYYMMDD where YYYY = year , MM = month and DD = day
     */
    public static String getDate(String dateType, Calendar calendar){
	String day = String.valueOf(calendar.get(Calendar.DAY_OF_MONTH));
	String month = String.valueOf(calendar.get(Calendar.MONTH) + 1);
	int year = calendar.get(Calendar.YEAR);
	int year_th = year;
	int year_eng = year;
	while(year_eng > 2250){ year_eng -= 543;}
	while(year_th < 2250){ year_th += 543;}
        if(Integer.parseInt(day) < 10) day = "0" + day;
        if(Integer.parseInt(month) < 10) month = "0" + month;
        String finalDate = String.valueOf(year_th) + month + day;
        if(dateType.equals(DATE_ENG)) finalDate = String.valueOf(year_eng) + month + day;
        return finalDate;
    }

    /** Gets current date in a format of YYYYMMDD
     * @return current date in a format of YYYYMMDD where YYYY = year , MM = month and DD = day
     */
    public static String getDate(String dateType){
        Calendar calendar = Calendar.getInstance();
	String day = String.valueOf(calendar.get(Calendar.DAY_OF_MONTH));
	String month = String.valueOf(calendar.get(Calendar.MONTH) + 1);
	int year = calendar.get(Calendar.YEAR);
	int year_th = year;
	int year_eng = year;
	while(year_eng > 2250){ year_eng -= 543;}
	while(year_th < 2250){ year_th += 543;}
        if(Integer.parseInt(day) < 10) day = "0" + day;
        if(Integer.parseInt(month) < 10) month = "0" + month;
        String finalDate = String.valueOf(year_th) + month + day;
        if(dateType.equals(DATE_ENG)) finalDate = String.valueOf(year_eng) + month + day;
        return finalDate;
    }
    
    /** Gets current Thai budget year
     * @return current Thai budget year
     */
    public static int getCurrentBudgetYear(){
        String budgetYear = getDate(DATE_ENG).substring(0, 4);
        String budgetMonth = getDate(DATE_ENG).substring(4, 6);
        if(Integer.parseInt(budgetMonth) > 9)  
            return Integer.parseInt(budgetYear) + 1;
        else
            return Integer.parseInt(budgetYear);
    }

    /** Gets Thai budget year
     * @param YYYYMMDD string of date in the form of YYYYMMDD where YYYY = year, MM = month and DD = day
     * @return Thai budget year
     */
    public static int getBudgetYear(String YYYYMMDD){
        String budgetYear = YYYYMMDD.substring(0, 4);
        String budgetMonth = YYYYMMDD.substring(4, 6);
        if(Integer.parseInt(budgetMonth) > 9)  
            return Integer.parseInt(budgetYear) + 1;
        else
            return Integer.parseInt(budgetYear);
    }

    /** Gets month diff between two date
     * @param startDate start of date
     * @param endDate end of date
     * @return num of months between two dates specified
     */
    public int getNumOfMonth(String startDate, String endDate){
        try{
            int startYear = Integer.parseInt(startDate.substring(0, 4));
            int startMonth = Integer.parseInt(startDate.substring(4, 6));
            int endYear = Integer.parseInt(endDate.substring(0, 4));
            int endMonth = Integer.parseInt(endDate.substring(4, 6));
            int yearDiff = endYear - startYear;
            int monthDiff = endMonth - startMonth;
            if(monthDiff < 0){
                yearDiff--;
                monthDiff += 12;
            }
            return yearDiff * 12 + monthDiff;
        }catch(Exception e){
            return 0;
        }
    }
}
