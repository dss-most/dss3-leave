/*
 * GeneralUtility.java
 *
 * Created on 26 �չҤ� 2549, 0:36 �.
 *
 * To change this template, choose Tools | Template Manager
 * and open the template in the editor.
 */

package gitex.utility;

import java.util.*;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;


/**
 * Provides frequent used method
 * @author pantape
 */
public class GeneralUtility {
	public Logger logger = LoggerFactory.getLogger(this.getClass());      
    /**
     * Creates a new instance of GeneralUtility
     */
    protected GeneralUtility() { }
    

    public static boolean isNumber(String inNumber){
	/*
	This method will check if the input string is a number.
	If so it returns true, false otherwise.
	*/
	try{
		Double.parseDouble(inNumber);
		return true;
	}catch(Exception e){
		//log.debug("isNumber() : " + e.toString());
		return false;
	}
    }
    public static String toThaiString(String text){
	String thaiStr = "";
	try{
		thaiStr = new String(text.getBytes("ISO_8859-1"), "TIS-620");
	}catch(Exception e){thaiStr = text + "*";}
	return thaiStr;
    }
    public static String toSelectedLang(String lang, String txtThai, String txtEng){
        if(lang.equals("eng"))
                return txtEng;
        else
                return txtThai;
    }
    public static String getImgHTMLTag(String imgFileName, String width, String height, String align){
	String imgTag = "";
	String fileExt = "";
	fileExt = imgFileName.substring(imgFileName.lastIndexOf(".") + 1).trim();
	if(fileExt.toLowerCase().equals("swf")){
		imgTag += "<object classid=\"clsid:D27CDB6E-AE6D-11cf-96B8-444553540000\"";
		imgTag += "codebase=\"http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=6,0,0,0\"";
		imgTag += " width=\"" + width + "\" height=\"" + height + "\"id=\"Untitled-1\" align=\"\">";
		imgTag += "<param name=movie value=\"" + imgFileName + "\"> <param name=quality value=high><param name=wmode value=transparent> ";
		imgTag += "<embed src=\"" + imgFileName + "\" quality=high bgcolor=#FFFFFF  width=\"100%\" height=\"100%\" name=\"Untitled-1\" align=\"\"";
		imgTag += " type=\"application/x-shockwave-flash\" pluginspage=\"http://www.macromedia.com/go/getflashplayer\"></embed>";
		imgTag += "</object>";
	}else{
		imgTag += "<img src=\"" + imgFileName + "\" align=\"" + align + "\" width=\"" + width + "\" height=\"" + height + "\" border=\"0\">";
	}
	return imgTag;
    }
}
