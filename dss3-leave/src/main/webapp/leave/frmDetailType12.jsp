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
FrmLeaveReq reqForm = new FrmLeaveReq(thisForm.getValue(thisForm.ELM_NAME_REF_TAKE_LEAVE_ID));
Employee employee = new Employee(reqForm.getValue(reqForm.ELM_NAME_EMP_ID));
%>
<div id="doc">
<h3 class="center">แบบใบขอยกเลิกการลา</h3>
<span class="docHeader">
<p class="left">
 เขียนที่ <%=thisForm.getValue(thisForm.ELM_NAME_MAKE_REQ_ORG)%> <br>
 วันที่ <%=date.getDate(thisForm.getValue(thisForm.ELM_NAME_MAKE_REQ_DATE), date.MONTH_NAME_FULL).get(date.DATE_THAI).toString()%>
</p>
</span>
<p class="docSubject">
 เรื่อง ขอยกเลิกวันลา<br>
 เรียน <%=thisForm.getValue(thisForm.ELM_NAME_ORG_HEAD_WORK_TITLE)%>
</p>
<p class="docBody">
ข้าพเจ้า <%=employee.fullName%> ตำแหน่ง <%=employee.workTitle%> สังกัด <%=employee.topORGName%> ได้รับอนุญาตให้ <%=reqForm.getFormName()%>
ตั้งแต่วันที่ <%=date.getDate(reqForm.getValue(reqForm.ELM_NAME_LEAVE_START_DATE), date.MONTH_NAME_SHORT).get(date.DATE_THAI).toString()%> 
ถึงวันที่ <%=date.getDate(reqForm.getValue(reqForm.ELM_NAME_LEAVE_END_DATE), date.MONTH_NAME_SHORT).get(date.DATE_THAI).toString()%>
รวม <%=reqForm.getValue(reqForm.ELM_NAME_LEAVE_DAY_COUNT_MASTER)%> วันนั้น
</p>
<p class="docBody">
เนื่องจาก <%=thisForm.getValue(thisForm.ELM_NAME_REMARK)%> 
จึงขอยกเลิกวัน <%=reqForm.getFormName()%>
ตั้งแต่วันที่ <%=date.getDate(thisForm.getValue(thisForm.ELM_NAME_FORM_START_DATE), date.MONTH_NAME_SHORT).get(date.DATE_THAI).toString()%> 
ถึงวันที่ <%=date.getDate(thisForm.getValue(thisForm.ELM_NAME_FORM_END_DATE), date.MONTH_NAME_SHORT).get(date.DATE_THAI).toString()%>
จำนวน <%=thisForm.getValue(thisForm.ELM_NAME_LEAVE_DAY_COUNT_MASTER)%> วัน
</p>
<span class="docEnd">
<p class="center">
ขอแสดงความนับถือ<br>
ลงชื่อ <img src="images/spacer.gif" width="150" height="1"><br>
(<%=employee.fullName%>)
</p>
</span>
<span style="clear:both;"></span>
</div>