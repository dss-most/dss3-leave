<%@page contentType="text/html"%>
<%@page pageEncoding="TIS-620"%>
<%@page import="java.util.*"%>
<%@page import="gitex.html.*"%>
<%@page import="gitex.tu.*"%>
<%@page import="gitex.tu.htmlForm.*"%>
<%
LeaveReqLog reqLog = new LeaveReqLog(request.getParameter("takeLeaveId"));
%>
<h3>����ѵԤ���ͧ</h3>
<%if(reqLog.logList.size() > 0){%>
    <table width="100%">
    <tr>
    <td class="tblHeader left" width="20%">�ѹ���</td>
    <td class="tblHeader left" width="55%">��ô��Թ���</td>
    <td class="tblHeader left" width="25%">�����Թ���</td>
    <!--td class="tblHeader left" width="20%">����觤���ͧ</td-->
    <!--td class="tblHeader left" width="25%">���Ԩ�óҤ���ͧ</td-->
    </tr>
    
    <%
    for(int i = 0; i < reqLog.logList.size(); i++){
        String logDate = ((Hashtable)reqLog.logList.get(i)).get(reqLog.DATE).toString();
        String logDetail = ((Hashtable)reqLog.logList.get(i)).get(reqLog.DETAIL).toString();
        String by = ((Hashtable)reqLog.logList.get(i)).get(reqLog.BY).toString();
        String from = ((Hashtable)reqLog.logList.get(i)).get(reqLog.FROM).toString();
        String to = ((Hashtable)reqLog.logList.get(i)).get(reqLog.TO).toString();
        %>
        <tr>
        <td class="tblRow<%=i % 2%> left"><%=logDate%></td>
        <td class="tblRow<%=i % 2%> left"><%=logDetail%></td>
        <td class="tblRow<%=i % 2%> left"><%=by%></td>
        <!--td class="tblRow<%=i % 2%> left"><%=from%></td-->
        <!--td class="tblRow<%=i % 2%> left"><%=to%></td-->
        </tr>
        <%
    }
    %>
    </table>
<%}else{%>
    <p class="block">�����</p>
<%}%>
