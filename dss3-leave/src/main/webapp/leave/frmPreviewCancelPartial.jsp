<%@page contentType="text/html"%>
<%@page pageEncoding="TIS-620"%>
<%@page import="java.util.*"%>
<%@page import="gitex.html.*"%>
<%@page import="gitex.tu.*"%>
<%@page import="gitex.tu.htmlForm.*"%>
<%@page import="gitex.utility.*"%>
<%
gitex.utility.Date date = new gitex.utility.Date();   
LeaveReqHtmlPage thisPage = new LeaveReqHtmlPage(session, request);
FrmLeaveReq thisForm = new FrmLeaveReq(request, thisPage.getUser());   
FrmLeaveReq tempForm = new FrmLeaveReq(thisForm.getValue(thisForm.ELM_NAME_REF_TAKE_LEAVE_ID));   
session.setAttribute(LutGlobalSessionName.FORM, thisForm);
%>
<h3>
ประเภทคำร้อง : <span class="lblLeaveName"><%=tempForm.getFormName()%></span><br/>
สถานะ : <span class="lblLeaveName"><%=tempForm.getStatusName(tempForm.getValue(tempForm.ELM_NAME_STATUS))%></span><br/>
</h3>
<p class="block blue">
วันที่เริ่มต้นการลา <%=((Hashtable)date.getDate(tempForm.getValue(tempForm.ELM_NAME_LEAVE_START_DATE), date.MONTH_NAME_FULL)).get(date.DATE_THAI).toString()%> <%=tempForm.getPeriodName(tempForm.getValue(tempForm.ELM_NAME_LEAVE_START_DATE_PERIOD))%><br>
วันที่สิ้นสุดการลา <%=((Hashtable)date.getDate(tempForm.getValue(tempForm.ELM_NAME_LEAVE_END_DATE), date.MONTH_NAME_FULL)).get(date.DATE_THAI).toString()%> <%=tempForm.getPeriodName(tempForm.getValue(tempForm.ELM_NAME_LEAVE_END_DATE_PERIOD))%><br>
รวมระยะเวลาทั้งสิ้น <%=tempForm.getValue(tempForm.ELM_NAME_LEAVE_DAY_COUNT_MASTER)%> วัน<br>
</p>
<jsp:include page="frmDetailType12.jsp"/>
<p>
    <form class="center" action="index.jsp" method="post">
    <input type="hidden" name="<%=LutGlobalRequestName.TASK_CODE%>" value="<%=LutLeaveReqTaskCode.SUBMIT_CANCEL_PARTIAL%>">
    <input type="submit" name="btnSubmit" value="ส่งใบขอยกเลิกวันลา" onclick="return confirm('กรุณายืนยันการยกเลิกวันลา');"> 
    <input type="button" name="btnBack" value="ย้อนกลับ" onclick="document.location='index.jsp?<%=LutGlobalRequestName.TASK_CODE%>=<%=LutLeaveReqTaskCode.INPUT_CANCEL_PARTIAL%>';">
    </form>
</p>
