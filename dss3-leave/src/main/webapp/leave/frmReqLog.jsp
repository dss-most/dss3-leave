<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>
<%@page import="java.util.*"%>
<%@page import="gitex.html.*"%>
<%@page import="gitex.tu.*"%>
<%@page import="gitex.tu.htmlForm.*"%>
<%
LeaveReqLog reqLog = new LeaveReqLog(request.getParameter("takeLeaveId"));
%>
<h3>ประวัติคำร้อง</h3>
<%if(reqLog.logList.size() > 0){%>
    <table width="100%">
    <tr>
    <td class="tblHeader left" width="20%">วันที่</td>
    <td class="tblHeader left" width="55%">การดำเนินการ</td>
    <td class="tblHeader left" width="25%">ผู้ดำเนินการ</td>
    <!--td class="tblHeader left" width="20%">ผู้ส่งคำร้อง</td-->
    <!--td class="tblHeader left" width="25%">ผู้พิจารณาคำร้อง</td-->
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
    <p class="block">ไม่มี</p>
<%}%>
