<%@page contentType="text/html"%>
<%@page pageEncoding="TIS-620"%>
<%@page import="gitex.html.*"%>
<%@page import="gitex.tu.*"%>
<%@page import="gitex.tu.htmlForm.*"%>
<%@page import="gitex.utility.*"%>
<%
LeaveReqHtmlPage thisPage = new LeaveReqHtmlPage(session, request);
Employee employee = thisPage.getUser().employee;
LutLeaveReqTaskCode taskCode = new LutLeaveReqTaskCode();   
gitex.utility.Date date = new gitex.utility.Date();
FrmLeaveReq thisForm = (FrmLeaveReq) session.getAttribute(LutGlobalSessionName.FORM);
%>
<p>
<form name="FrmLeaveReq" action="index.jsp" method="post">
<input type="hidden" name="<%=LutGlobalRequestName.TASK_CODE%>" value="<%=taskCode.REQ_IN_COUNTRY_LEAVE_3%>"/>
<input type="hidden" name="<%=thisForm.ELM_NAME_FORM_TYPE_ID%>" value="<%=thisForm.getValue(thisForm.ELM_NAME_FORM_TYPE_ID)%>"/>
<input type="hidden" name="<%=thisForm.ELM_NAME_FORM_CAT_ID%>" value="<%=thisForm.getValue(thisForm.ELM_NAME_FORM_CAT_ID)%>"/>
<input type="hidden" name="<%=thisForm.ELM_NAME_BUDGET_YEAR%>" value="<%=thisForm.getValue(thisForm.ELM_NAME_BUDGET_YEAR)%>"/>
<p class="right" style="width:350px;">
<%@include file="/WEB-INF/jspf/dateInput.jspf" %>
*เคยไปประกอบพิธีฮัจย์มาก่อน : <input type="radio" name="<%=thisForm.ELM_NAME_IS_LEAVE_BEFORE%>" value="<%=thisForm.FORM_HAS_LEAVED_BEFORE%>" <%if(thisForm.getValue(thisForm.ELM_NAME_IS_LEAVE_BEFORE).equals(thisForm.FORM_HAS_LEAVED_BEFORE)){%>checked<%}%>/> เคย  <input type="radio" name="<%=thisForm.ELM_NAME_IS_LEAVE_BEFORE%>" value="<%=thisForm.FORM_NEVER_LEAVED_BEFORE%>" <%if(thisForm.getValue(thisForm.ELM_NAME_IS_LEAVE_BEFORE).equals(thisForm.FORM_NEVER_LEAVED_BEFORE)){%>checked<%}%>/> ไม่เคย
<img src="images/spacer.gif" width="30" height="1">
<br/><br/>
<input type="submit" name="btnSubmit" value="ตรวจสอบรายละเอียด" style="width:130px;"> 
<input type="reset" name="btnReset" value="เริ่มใหม่"> 
<input type="button" name="btnBack" value="ย้อนกลับ" onclick="document.location='index.jsp?<%=LutGlobalRequestName.TASK_CODE%>=<%=taskCode.REQ_IN_COUNTRY_LEAVE_1%>';">
</p>
</form>
</p>
<p class="block">
<strong>คำแนะนำ : </strong> * หมายถึง ช่องข้อมูลที่ต้องกรอก
</p>
<jsp:include page="includes/calendar.jsp"></jsp:include>
<script language="JavaScript">
    var frmLoginValidator  = new Validator("FrmLeaveReq");
    frmLoginValidator.addValidation("txtLeaveSD","req","กรุณาใส่วันเริ่มต้นการลา");
    frmLoginValidator.addValidation("txtLeaveED","req","กรุณาใส่วันสิ้นสุดการลา");

    setDateDisplayText(document.all['txtLeaveSD'], document.all['<%=thisForm.ELM_NAME_FORM_START_DATE%>'].value);
    setDateDisplayText(document.all['txtLeaveED'], document.all['<%=thisForm.ELM_NAME_FORM_END_DATE%>'].value);
    validateDate(null, null);
</script>
