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
<form name="FrmLeaveReq" action="index.jsp" method="post">
<input type="hidden" name="<%=LutGlobalRequestName.TASK_CODE%>" value="<%=taskCode.REQ_IN_COUNTRY_LEAVE_3%>"/>
<input type="hidden" name="<%=thisForm.ELM_NAME_FORM_TYPE_ID%>" value="<%=thisForm.getValue(thisForm.ELM_NAME_FORM_TYPE_ID)%>"/>
<input type="hidden" name="<%=thisForm.ELM_NAME_FORM_CAT_ID%>" value="<%=thisForm.getValue(thisForm.ELM_NAME_FORM_CAT_ID)%>"/>
<input type="hidden" name="<%=thisForm.ELM_NAME_BUDGET_YEAR%>" value="<%=thisForm.getValue(thisForm.ELM_NAME_BUDGET_YEAR)%>"/>


<%@include file="/WEB-INF/jspf/dateInput.jspf" %>

<div class="input-block">
	<label>*เคยอุปสมบทมาก่อน :</label>
	<input type="radio" name="<%=thisForm.ELM_NAME_IS_LEAVE_BEFORE%>" value="<%=thisForm.FORM_HAS_LEAVED_BEFORE%>" <%if(thisForm.getValue(thisForm.ELM_NAME_IS_LEAVE_BEFORE).equals(thisForm.FORM_HAS_LEAVED_BEFORE)){%>checked<%}%>/> เคย  
	<input type="radio" name="<%=thisForm.ELM_NAME_IS_LEAVE_BEFORE%>" value="<%=thisForm.FORM_NEVER_LEAVED_BEFORE%>" <%if(thisForm.getValue(thisForm.ELM_NAME_IS_LEAVE_BEFORE).equals(thisForm.FORM_NEVER_LEAVED_BEFORE)){%>checked<%}%>/> ไม่เคย
</div>

<div class="input-block">
	<label>*วันที่อุปสมบท :</label>
	<input type="text" id="txtActivityDate" name="txtActivityDate" style="position:relative;" value=""/>
	<input type="hidden" id="<%=thisForm.ELM_NAME_DETAIL_DATE%>" name="<%=thisForm.ELM_NAME_DETAIL_DATE%>" value="<%=thisForm.getValue(thisForm.ELM_NAME_DETAIL_DATE)%>"/>
</div>

<div class="input-block">
	<label>*วัดที่อุปสมบท  :</label>
	<input type="text" name="<%=thisForm.ELM_NAME_TEXT_1%>" style="width:241px;" value="<%=thisForm.getValue(thisForm.ELM_NAME_TEXT_1)%>"/>
</div>

<div class="input-block">
	<label>*สถานที่ตั้ง  :</label>
	<input type="text" name="<%=thisForm.ELM_NAME_TEXT_2%>" style="width:241px;" value="<%=thisForm.getValue(thisForm.ELM_NAME_TEXT_2)%>"/>
</div>

<div class="input-block">
	<label>*วัดที่จำพรรษา  :</label>
	<input type="text" name="<%=thisForm.ELM_NAME_TEXT_3%>" style="width:241px;" value="<%=thisForm.getValue(thisForm.ELM_NAME_TEXT_3)%>"/>
</div>

<div class="input-block">
	<label>*สถานที่ตั้ง  :</label>
	<input type="text" name="<%=thisForm.ELM_NAME_TEXT_4%>" style="width:241px;" value="<%=thisForm.getValue(thisForm.ELM_NAME_TEXT_4)%>"/>
</div>

<div class="input-block">
	<label></label>
	<input type="submit" name="btnSubmit" value="ตรวจสอบรายละเอียด" style="width:130px;"> 
	<input type="reset" name="btnReset" value="เริ่มใหม่"> 
	<input type="button" name="btnBack" value="ย้อนกลับ" onclick="document.location='index.jsp?<%=LutGlobalRequestName.TASK_CODE%>=<%=taskCode.REQ_IN_COUNTRY_LEAVE_1%>';">
	
</div>
 
 
<img src="images/spacer.gif" width="97" height="1"><br/>

</form>
<p class="block">
<strong>คำแนะนำ : </strong> * หมายถึง ช่องข้อมูลที่ต้องกรอก
</p>
<jsp:include page="includes/calendar.jsp"></jsp:include>
<script language="JavaScript">

$('#txtActivityDate').datepicker({
	isBE: true,
    autoConversionField: false,
    showButtonPanel: true,
    dateFormat: "dd MM yy",
    changeMonth: true,
    changeYear: true,
    altField: "#<%=thisForm.ELM_NAME_DETAIL_DATE%>",
    altFormat: "yymmdd",
    onSelect: function(dateText, inst) { return updateCE(this, '<%=thisForm.ELM_NAME_DETAIL_DATE%>', true); }
});

function updateCE(objTextDate, nameDateValue, updateCE){
	var selectedDate =  $('#'+nameDateValue).val();
	
	if(updateCE != null) {
	
    	 var yearCE = parseInt(selectedDate.substr(0,4)) - 543;
         selectedDate = yearCE + selectedDate.substr(4,4);
         $('#'+nameDateValue).val(selectedDate);
	} else {
		selectedDate="";
	}
}


    var frmLoginValidator  = new Validator("FrmLeaveReq");
    frmLoginValidator.addValidation("txtLeaveSD","req","กรุณาใส่วันเริ่มต้นการลา");
    frmLoginValidator.addValidation("txtLeaveED","req","กรุณาใส่วันสิ้นสุดการลา");
    frmLoginValidator.addValidation("<%=thisForm.ELM_NAME_TEXT_1%>","req","กรุณาใส่วัดที่อุปสมบท");
    frmLoginValidator.addValidation("txtActivityDate","req","กรุณาใส่วันที่อุปสมบท");
    frmLoginValidator.addValidation("<%=thisForm.ELM_NAME_TEXT_2%>","req","กรุณาใส่ที่ตั้งของวัดที่อุปสมบท");
    frmLoginValidator.addValidation("<%=thisForm.ELM_NAME_TEXT_3%>","req","กรุณาใส่วัดที่จำพรรษา");
    frmLoginValidator.addValidation("<%=thisForm.ELM_NAME_TEXT_4%>","req","กรุณาใส่ที่ตั้งของวัดที่จำพรรษา");

    setDateDisplayText(document.all['txtLeaveSD'], document.all['<%=thisForm.ELM_NAME_FORM_START_DATE%>'].value);
    setDateDisplayText(document.all['txtActivityDate'], document.all['<%=thisForm.ELM_NAME_DETAIL_DATE%>'].value);
    setDateDisplayText(document.all['txtLeaveED'], document.all['<%=thisForm.ELM_NAME_FORM_END_DATE%>'].value);
    validateDate(null, null);
</script>
