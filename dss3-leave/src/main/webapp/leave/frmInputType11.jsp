<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>
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

<form name="FrmLeaveReq" action="index.jsp" method="post">
<input type="hidden" name="<%=LutGlobalRequestName.TASK_CODE%>" value="<%=taskCode.REQ_IN_COUNTRY_LEAVE_3%>"/>
<input type="hidden" name="<%=thisForm.ELM_NAME_FORM_TYPE_ID%>" value="<%=thisForm.getValue(thisForm.ELM_NAME_FORM_TYPE_ID)%>"/>
<input type="hidden" name="<%=thisForm.ELM_NAME_FORM_CAT_ID%>" value="<%=thisForm.getValue(thisForm.ELM_NAME_FORM_CAT_ID)%>"/>
<input type="hidden" name="<%=thisForm.ELM_NAME_BUDGET_YEAR%>" value="<%=thisForm.getValue(thisForm.ELM_NAME_BUDGET_YEAR)%>"/>
<%@include file="/WEB-INF/jspf/dateInput.jspf" %>
 <input type="hidden" name="<%=thisForm.ELM_NAME_TO_COUNTRY%>" style="width:241px;" value="-"/>
 
<div class="input-block">
	<label>*เนื่องจาก  :</label> 
	<textarea name="<%=thisForm.ELM_NAME_CONTACT_DETAIL%>" style="width:241px;height:85px;"><%=thisForm.getValue(thisForm.ELM_NAME_CONTACT_DETAIL)%></textarea>	
</div>

 <input type="hidden" name="<%=thisForm.ELM_NAME_REMARK%>" style="width:241px;" value="<%=thisForm.getValue(thisForm.ELM_NAME_REMARK)%>"/>
 <input type="hidden" name="<%=thisForm.ELM_NAME_IS_NEED_VISA%>" value="0"/><br/>

<div class="input-block">
	<label></label>
	<input type="submit" name="btnSubmit" value="ตรวจสอบรายละเอียด" style="width:130px;"> 
	<input type="reset" name="btnReset" value="เริ่มใหม่"> 
	<input type="button" name="btnBack" value="ย้อนกลับ" onclick="document.location='index.jsp?<%=LutGlobalRequestName.TASK_CODE%>=<%=taskCode.REQ_OUT_COUNTRY_LEAVE_1%>';">
	
</div>

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
    frmLoginValidator.addValidation("<%=thisForm.ELM_NAME_TO_COUNTRY%>","req","กรุณาใส่ชื่อประเทศที่จะไป");
    frmLoginValidator.addValidation("<%=thisForm.ELM_NAME_CONTACT_DETAIL%>","req","กรุณาใส่สถานที่ติดต่อ");

    setDateDisplayText(document.all['txtLeaveSD'], document.all['<%=thisForm.ELM_NAME_FORM_START_DATE%>'].value);
    setDateDisplayText(document.all['txtLeaveED'], document.all['<%=thisForm.ELM_NAME_FORM_END_DATE%>'].value);
    validateDate(null, null);
</script>
