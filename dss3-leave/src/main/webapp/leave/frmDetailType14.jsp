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
String nsi = thisForm.getValue(thisForm.ELM_NAME_REMARK);
String nsiRound = "1";
String nsiTime = "";
if(!nsi.equals("")){
    nsiRound = nsi.split(",")[0];
    nsiTime = nsi.split(",")[1];
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
 เรื่อง <%=thisForm.getFormName()%><br>
 เรียน <%=thisForm.getValue(thisForm.ELM_NAME_ORG_HEAD_WORK_TITLE)%>
</p>
<p class="docBody">
ข้าพเจ้า <%=employee.fullName%>
ตำแหน่ง <%=employee.workTitle%>
สังกัด <%=employee.topORGName%>
ขออนุญาตไม่ลงเวลาปฏิบัติราชการ <%=thisForm.getNSIText(nsiRound, nsiTime)%>
ในวันที่ <%=date.getDate(thisForm.getValue(thisForm.ELM_NAME_FORM_START_DATE), date.MONTH_NAME_SHORT).get(date.DATE_THAI).toString()%> 
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