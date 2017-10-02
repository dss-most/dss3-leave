<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>
<%@page import="gitex.html.*"%>
<%@page import="gitex.tu.*"%>
<%@page import="gitex.tu.htmlForm.*"%>
<%@page import="gitex.utility.*"%>
<%
LeaveReqHtmlPage thisPage = new LeaveReqHtmlPage(session, request);
LutLeaveReqTaskCode taskCode = new LutLeaveReqTaskCode();   
gitex.utility.Date date = new gitex.utility.Date();
FrmLeaveReq thisForm = (FrmLeaveReq) session.getAttribute(LutGlobalSessionName.FORM);
Employee employee = new Employee(thisForm.getValue(thisForm.ELM_NAME_EMP_ID));
FrmLeaveReq recentForm = new FrmLeaveReq();
String recentStartDate = "-";
String recentEndDate = "-";
String recentLeaveCount = "-";
if(!thisForm.getValue(thisForm.ELM_NAME_RECENT_TAKELEAVE_ID).equals("")){
    recentForm = new FrmLeaveReq(thisForm.getValue(thisForm.ELM_NAME_RECENT_TAKELEAVE_ID));
    recentStartDate = date.getDate(recentForm.getValue(thisForm.ELM_NAME_LEAVE_START_DATE), date.MONTH_NAME_SHORT).get(date.DATE_THAI).toString();
    recentEndDate = date.getDate(recentForm.getValue(thisForm.ELM_NAME_LEAVE_END_DATE), date.MONTH_NAME_SHORT).get(date.DATE_THAI).toString();
    recentLeaveCount = recentForm.getValue(recentForm.ELM_NAME_LEAVE_DAY_COUNT_CHILD);
}
%>
<div id="doc">
<h3 class="center">แบบการขออนุญาตไม่ลงเวลาปฏิบัติราชการ</h3>
<span class="docHeader">
<p class="left">
 เขียนที่ <%=thisForm.getValue(thisForm.ELM_NAME_MAKE_REQ_ORG)%> <br>
 วันที่ <%=date.getDate(thisForm.getValue(thisForm.ELM_NAME_MAKE_REQ_DATE), date.MONTH_NAME_FULL).get(date.DATE_THAI).toString()%>
</p>
</span>
<p class="docSubject">
 เรื่อง การขออนุญาตไม่ลงเวลาปฏิบัติราชการ<br>
 เรียน <%=thisForm.getValue(thisForm.ELM_NAME_ORG_HEAD_WORK_TITLE)%>
</p>
<p class="docBody">
ข้าพเจ้า <%=employee.fullName%>
ตำแหน่ง <%=employee.workTitle%>
สังกัด <%=employee.topORGName%>
ขออนุญาตไม่ลงเวลาปฏิบัติราชการ ตั้งแต่วันที่ <%=date.getDate(thisForm.getValue(thisForm.ELM_NAME_FORM_START_DATE), date.MONTH_NAME_SHORT).get(date.DATE_THAI).toString()%> 
ถึงวันที่ <%=date.getDate(thisForm.getValue(thisForm.ELM_NAME_FORM_END_DATE), date.MONTH_NAME_SHORT).get(date.DATE_THAI).toString()%>
รวม <%=thisForm.getValue(thisForm.ELM_NAME_LEAVE_DAY_COUNT_MASTER)%> วัน
เนื่องจาก <%=thisForm.getValue(thisForm.ELM_NAME_CONTACT_DETAIL)%>
</p>
<span class="docEnd">
<p class="center">
ขอแสดงความนับถือ<br>
ลงชื่อ <img src="images/spacer.gif" width="100" height="1"><br>
(<%=employee.fullName%>)
</p>
</span>
<span style="clear:both;"></span>
</div>