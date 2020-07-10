package th.go.dss;

import java.util.ResourceBundle;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;



public class BuildInfo {
	public static Logger logger = LoggerFactory.getLogger(BuildInfo.class);
	
	private static ResourceBundle buildInfoBundle = null;
	static {
		try {
			buildInfoBundle =  ResourceBundle.getBundle("messages");
        } catch (Exception e) {
            logger.error(e.getMessage());
        } 
	}
	
	public static String revision=getRevision();
	private static String getRevision() {
		//buildInfoBundle = getBuildInfoBundle();
		if(buildInfoBundle == null ) {
			return "null";
		}
		return buildInfoBundle.getString("application.version") +
				buildInfoBundle.getString("application.buildTimestamp");
	}
	
	public static String databaseUrl=getDatabaseUrl();
	private static String getDatabaseUrl() {
		//buildInfoBundle = getBuildInfoBundle();
		if(buildInfoBundle == null ) {
			return "null";
		}
		return buildInfoBundle.getString("application.database");
	}
	
	public static String databaseUsername=getDatabaseUsername();
	private static String getDatabaseUsername() {
		//buildInfoBundle = getBuildInfoBundle();
		if(buildInfoBundle == null ) {
			return "null";
		}
		return buildInfoBundle.getString("application.database.username");
	}
	
	public static String databasePassword=getDatabasePassword();
	private static String getDatabasePassword() {
		//buildInfoBundle = getBuildInfoBundle();
		if(buildInfoBundle == null ) {
			return "null";
		}
		return buildInfoBundle.getString("application.database.password");
	}
	
	public static String reportSid=getReportSid();
	private static String getReportSid(){
		if(buildInfoBundle == null) {
			return "null";
		}
		return buildInfoBundle.getString("report.sid");
	}
	
	public BuildInfo() {
		
	}
}
