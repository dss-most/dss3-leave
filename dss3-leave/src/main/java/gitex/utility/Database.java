/*
 * Database.java
 *
 * Created on 10 �չҤ� 2550, 21:01 �.
 *
 * To change this template, choose Tools | Template Manager
 * and open the template in the editor.
 */

package gitex.utility;

import java.sql.*;
import java.util.*;
import javax.servlet.http.*;


import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * Provides database connection and query execution
 * @author pantape
 */
public class Database {
	public Logger logger = LoggerFactory.getLogger(this.getClass());
	
    /** connection string */
    //private final String connString = "jdbc:oracle:thin:tu/tu@localhost:1521:XE";
    
    /** string data type */
    public static String STRING_DATA_TYPE = "STRING";
    
    /** date data type*/
    public static String DATE_DATA_TYPE = "DATE";
    
    /** double data type */
    public static String DOUBLE_DATA_TYPE = "DOUBLE";
    /** Creates a new instance of Database */
    public Database() {
    }
    
    /** Gets database connection
     * @return connection object
     */
    public Connection getDBConnection(){
        Connection dbConn = null;
        try{
            //dbConn = DriverManager.getConnection(connString);
        	
            Class.forName("oracle.jdbc.driver.OracleDriver");
            Class.forName("org.apache.commons.dbcp.PoolingDriver");
            dbConn = DriverManager.getConnection("jdbc:apache:commons:dbcp:/dbPool");
        }catch(Exception e){
            logger.error("gitex.tu.Database.getDBConniction() : " + e.toString());
        }
        return dbConn;
    }
    
    /** Get resultset from executing sql query
     * @param sql SQL statement to be executed
     * @param requiredField field name to be extracted from the query
     * @param dataType data type of each field name if not specify, string will be return
     * @return arraylist of hashtable contain key value pair of each field and its value
     */
    public ArrayList getResultSet(String sql, ArrayList requiredField, Hashtable dataType) {
		int i = 0;
		ArrayList content = new ArrayList();
		Connection dbConn = getDBConnection();
		Statement stmtObj = null;
		ResultSet rs = null;
		if (!sql.equals("")) {
			try {
				if (dbConn != null) {
					stmtObj = dbConn.createStatement(
							ResultSet.TYPE_SCROLL_INSENSITIVE,
							ResultSet.CONCUR_READ_ONLY);
					rs = stmtObj.executeQuery(sql);
					while (rs.next()) {
						Hashtable field = new Hashtable();
						for (i = 0; i < requiredField.size(); i++) {
							String fieldName = requiredField.get(i).toString();
							String fieldDataType = STRING_DATA_TYPE;
							if (dataType != null) {
								if (!dataType.isEmpty() && dataType.containsKey(fieldName))
									fieldDataType = dataType.get(fieldName).toString();
							}
							if (rs.getString(fieldName) != null) {
								if (fieldDataType.equals(DATE_DATA_TYPE)) {
									field.put(fieldName, rs.getDate(fieldName));
								} else if(fieldDataType.equals(DOUBLE_DATA_TYPE)){
									field.put(fieldName, rs.getDouble(fieldName));
								} else {
									field.put(fieldName, rs.getString(fieldName));
								}
							} else {
								field.put(fieldName, "");
							}
						}
						content.add(field);
					}
				}
			} catch (SQLException e) {
				logger.error("gitex.tu.Database.getResultSet() : "	+ e.toString());
				logger.error("requiredField : " + requiredField.get(i));
				logger.error(sql);
			} finally {
	            try { rs.close(); } catch(Exception e) { }
	            try { stmtObj.close(); } catch(Exception e) { }
	            try { dbConn.close(); } catch(Exception e) { }
	        }

		}
		
		
		return content;
	}
    
    /** Executes update type sql statement
     * @param sql sql statement
     * @return true if no error, false otherwise
     */
    public boolean executeUpdate(String sql){
        boolean isSuccess = true;
        Connection dbConn = getDBConnection();
        Statement stmt = null;
        try{
        	stmt = dbConn.createStatement();
            stmt.executeUpdate(sql);
            stmt.close();
        }catch(Exception e){
        	logger.error("gitex.tu.Database.executeUpdate() : " + e.toString());
        	logger.error(sql);
            isSuccess = false;
        } finally {
            try { stmt.close(); } catch(Exception e) { }
            try { dbConn.close(); } catch(Exception e) { }
        }

        
        return isSuccess;
    }
    
    /** Get next value from the specified sequence name
     * @param seqName sequence name
     * @return string represent the next value of the sequence
     */
    public String getNextVal(String seqName){
        String nextVal = "";
        if(!seqName.equals("")){
            String sql = " SELECT " + seqName + ".NEXTVAL AS value FROM dual";
            Database db = new Database();
            ArrayList field = new ArrayList();
            field.add("value");
            ArrayList data = new ArrayList();
            data = db.getResultSet(sql, field, null);
            if(data.size() > 0){
                nextVal = ((Hashtable)data.get(0)).get("value").toString();
            }
        }
        return nextVal;
    }
    
  
    
}
