/**
 * 
 */
package gitex.utility;


import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import th.go.dss.BuildInfo;

//import java.sql.Connection;

/**
 * @author Administrator
 *
 */
public class DecodeConn extends Database {
	public Logger logger = LoggerFactory.getLogger(this.getClass());	
	private String  Url="";
	
	// need to know userName/password to database connection to use as conn string to Oracle Report 
	// 
	public String userName="";
	
	public String passWord="";
	
	public String sid="";
	
	
	public DecodeConn(){
		setStringURL();
		setUser();
		setPassword();
		setSid();
	}
	
	private void setStringURL(){
		
		this.Url=BuildInfo.databaseUrl;
		
	}
	
	private void setUser(){
		
		this.userName = BuildInfo.databaseUsername;
		
		
		//this.userName=this.Url.substring(this.Url.indexOf("thin:")+5, this.Url.indexOf("/"));
		
	}
	
	private void setPassword(){
		
		this.passWord = BuildInfo.databasePassword;
		//this.passWord=this.Url.substring(this.Url.indexOf("/")+1,this.Url.indexOf("@"));
	}
	
	private void setSid(){
		this.sid=this.Url.substring(this.Url.lastIndexOf(":")+1,this.Url.length());
		
	}
	
	/*public static void main(String args[]){
		
		DecodeConn de = new DecodeConn();
	
		System.out.println(de.Url);
		System.out.println(de.userName);
		System.out.println(de.passWord);
		System.out.println(de.sid);
		//System.out.println(de.getDBConnection());
		//String s=de.getDBConnection().toString();
		//  System.out.println(s);
	}
*/
}
