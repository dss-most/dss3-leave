/*
 * ldapAuth.java
 *
 * Created on 7 �չҤ� 2550, 15:31 �.
 *
 * To change this template, choose Tools | Template Manager
 * and open the template in the editor.
 */

package gitex.tu;
import javax.naming.*;
import javax.naming.directory.*;


import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.util.Hashtable;
/**
 *
 * @author aa
 */
public class ldapAuth {
	public Logger logger = LoggerFactory.getLogger(this.getClass());
    
    /** Creates a new instance of ldapAuth */
    public ldapAuth() {
    }
    public boolean auth(String userName, String password) {
	// Set up environment for creating initial context
	Hashtable env = new Hashtable(11);
	env.put(Context.INITIAL_CONTEXT_FACTORY, 
	    "com.sun.jndi.ldap.LdapCtxFactory");
	env.put(Context.PROVIDER_URL, "ldap://202.57.128.163:389");
        String cn="cn="+userName+",dc=gitex,dc=co,dc=th";
	// Authenticate as S. User and password "mysecret"
	env.put(Context.SECURITY_AUTHENTICATION, "simple");
	env.put(Context.SECURITY_PRINCIPAL, cn); 
	env.put(Context.SECURITY_CREDENTIALS, password); 
	boolean status = false;
	try {
	    // Create initial context
	    DirContext ctx = new InitialDirContext(env);
            status=true;
	    ctx.close();
	} catch (NamingException e) {
	   // e.printStackTrace();
	   //log.debug("Invalid username or password");
	   status=false;
	}
	return status;
    }  
}
