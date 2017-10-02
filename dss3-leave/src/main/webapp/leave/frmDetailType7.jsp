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
<h3 class="center">แบบรายงานเข้ารับการเตรียมพล</h3>
<span class="docHeader">
<p class="left">
 เขียนที่ <%=thisForm.getValue(thisForm.ELM_NAME_MAKE_REQ_ORG)%> <br>
 วันที่ <%=date.getDate(thisForm.getValue(thisForm.ELM_NAME_MAKE_REQ_DATE), date.MONTH_NAME_FULL).get(date.DATE_THAI).toString()%>
</p>
</span>
<p class="docSubject">
 เรื่อง ขออนุญาต<%=thisForm.getFormName()%><br>
 เรียน <%=thisForm.getValue(thisForm.ELM_NAME_ORG_HEAD_WORK_TITLE)%>
</p>
<p class="docBody">
ข้าพเจ้า <%=employee.fullName%>
ตำแหน่ง <%=employee.workTitle%>
สังกัด <%=employee.topORGName%>
ได้รับหมายเรียกของ <%=thisForm.getValue(thisForm.ELM_NAME_TEXT_1)%>
ที่ <%=thisForm.getValue(thisForm.ELM_NAME_TEXT_2)%>
ลงวันที่ <%=date.getDate(thisForm.getValue(thisForm.ELM_NAME_DETAIL_DATE), date.MONTH_NAME_SHORT).get(date.DATE_THAI).toString()%>
ให้เข้ารับการ <%=thisForm.getValue(thisForm.ELM_NAME_TEXT_3)%>
ณ ที่ <%=thisForm.getValue(thisForm.ELM_NAME_TEXT_4)%>
ตั้งแต่วันที่ <%=date.getDate(thisForm.getValue(thisForm.ELM_NAME_FORM_START_DATE), date.MONTH_NAME_SHORT).get(date.DATE_THAI).toString()%> 
มีกำหนด <%=thisForm.getValue(thisForm.ELM_NAME_LEAVE_DAY_COUNT_MASTER)%> วัน
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