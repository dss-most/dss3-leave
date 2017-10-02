/*
 * HtmlForm.java
 *
 * Created on 26 กุมภาพันธ์ 2550, 10:52 น.
 *
 * To change this template, choose Tools | Template Manager
 * and open the template in the editor.
 */

package gitex.html;

import javax.servlet.http.*;
import java.util.*;

/**
 * Provides basic function on setting and retrieving data from the html form
 * @author pantape
 */
public class HtmlForm {
    /** form element */
    private Hashtable element = new Hashtable();
    
    /**
     * Creates a new instance of HtmlForm
     */
    public HtmlForm() {
    }

    /**
     * Creates a new instance of HtmlForm and sets value of each 
     * element in the form
     * 
     * @param request http request
     * @param nameList name of each element in a form
     */
    public HtmlForm(HttpServletRequest request, ArrayList nameList) {
        setValues(request, nameList);
    }

    /** Sets value of each element in to form
     * @param request http request
     * @param nameList name of each element in a form
     */
    public void setValues(HttpServletRequest request, ArrayList nameList) {
        for(int i = 0; i < nameList.size(); i++){
            if(request.getParameter(nameList.get(i).toString()) != null){
                String [] value = request.getParameterValues(nameList.get(i).toString());
                element.put(nameList.get(i).toString(), value);
            }
        }
    }

    /** Sets value of element
     * @param elementName name of element in the form
     * @param value value want to be set
     */
    public void setValue(String elementName, String value) {
        String[]arryValue = {value};
        element.put(elementName, arryValue);
    }
    
    /** Retrieves a single value of the form element
     * @param name element name
     * @return value of form element. If the element has more than one value, the first value is returned. 
     * If the element does not existed, a blank string is returned.
     */
    public String getValue(String name){
        if(element.containsKey(name)){
            String value[] = (String[])element.get(name);
            return value[0];
        }else
            return "";
    }    

    /** Retrieves a value of the form element as an array of string
     * @param name element name
     * @return value of form element as array, null if the element does not existed.
     */
    public String[] getValues(String name){
        if(element.containsKey(name)){
            return (String[])element.get(name);
        }else
            return null;
    }    
    
    /** Reports all instance property values in html format
     * @return string contains form element name and its value in html format
     */
    public String getReport(){
        String html = "";
        html = "<style>.formReportHeader{font-weight:bold;color:#FFFFFF;background-color:#000000;}</style>";
        html += "<div><table><tr><td class='formReportHeader'>Field name</td><td class='formReportHeader'>Value</td><tr>";
         for (Enumeration e = element.keys() ; e.hasMoreElements() ;) {
            String name = e.nextElement().toString();
            html += "<tr><td><strong>" + name + "</strong></td><td>";
            html += getValue(name) + "</td></tr>";
         }
        html += "</table></div>";
        return html;
    }
}
