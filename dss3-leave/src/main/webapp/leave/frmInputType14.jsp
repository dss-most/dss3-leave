<!-- แบบฟอร์มขออนุญาตไม่ลงเวลาปฏิบัติราชการ ทำงานร่วมกับ FrmLeaveReq.java-->

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
String nsi = thisForm.getValue(thisForm.ELM_NAME_REMARK);
String nsiRound = "1";
String nsiTime = "";
if(!nsi.equals("")){
    nsiRound = nsi.split(",")[0];
    nsiTime = nsi.split(",")[1];
}
%>

<form name="frmLeaveReq" action="index.jsp" method="post">
<input type="hidden" name="<%=LutGlobalRequestName.TASK_CODE%>" value="<%=taskCode.REQ_IN_COUNTRY_LEAVE_3%>"/>
<input type="hidden" name="<%=thisForm.ELM_NAME_FORM_TYPE_ID%>" value="<%=thisForm.getValue(thisForm.ELM_NAME_FORM_TYPE_ID)%>"/>
<input type="hidden" name="<%=thisForm.ELM_NAME_FORM_CAT_ID%>" value="<%=thisForm.getValue(thisForm.ELM_NAME_FORM_CAT_ID)%>"/>
<input type="hidden" name="<%=thisForm.ELM_NAME_BUDGET_YEAR%>" value="<%=thisForm.getValue(thisForm.ELM_NAME_BUDGET_YEAR)%>"/>

<input type="hidden" id="<%=thisForm.ELM_NAME_FORM_START_DATE%>" name="<%=thisForm.ELM_NAME_FORM_START_DATE%>" value="<%=thisForm.getValue(thisForm.ELM_NAME_FORM_START_DATE)%>"/>
<input type="hidden" name="<%=thisForm.ELM_NAME_FORM_END_DATE%>" value="<%=thisForm.getValue(thisForm.ELM_NAME_FORM_END_DATE)%>"/>
<input type="hidden" name="<%=thisForm.ELM_NAME_REMARK%>" value=""/>
<input type="hidden" name="<%=thisForm.ELM_NAME_LEAVE_DAY_COUNT_MASTER%>" value="1"/>
<input type="hidden" name="nsiRound" value="<%=nsiRound%>">

<div class="input-block">
    <label>เรียน :</label>
    <input type="text" name="<%=thisForm.ELM_NAME_ORG_HEAD_WORK_TITLE%>" value="<%=thisForm.getValue(thisForm.ELM_NAME_ORG_HEAD_WORK_TITLE)%>"/>
</div>

<div class="input-block">
    <label>*วันที่ :</label>
    <input type="text" id="txtNSIDate" name="txtNSIDate" style="position:relative;" value="" />
</div>

<!-- 
<div class="input-block">
    <label>*รอบ : </label>
   	<input type="radio" name="radio1" value="<%=thisForm.FORM_NSI_0730%>" <%if(nsiRound.equals(thisForm.FORM_NSI_0730)){%>checked<%}%> onclick="setNSIRound(this);"><%=thisForm.getNSIText(thisForm.FORM_NSI_0730, "")%>
	<input type="radio" name="radio1" value="<%=thisForm.FORM_NSI_0830%>" <%if(nsiRound.equals(thisForm.FORM_NSI_0830)){%>checked<%}%> onclick="setNSIRound(this);"><%=thisForm.getNSIText(thisForm.FORM_NSI_0830, "")%>
	<input type="radio" name="radio1" value="<%=thisForm.FORM_NSI_0930%>" <%if(nsiRound.equals(thisForm.FORM_NSI_0930)){%>checked<%}%> onclick="setNSIRound(this);"><%=thisForm.getNSIText(thisForm.FORM_NSI_0930, "")%>
</div>
 -->
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         
<div class="input-block">
    <label>*เวลา : </label>
    <select name="nsiTime" style="margin:0 0 1px 0;">
	    <option value="<%=thisForm.FORM_NSI_IN%>" <%if(nsiTime.equals(thisForm.FORM_NSI_IN)){%>selected<%}%>><%=thisForm.getNSIText("", thisForm.FORM_NSI_IN)%></option>
	    <option value="<%=thisForm.FORM_NSI_OUT%>" <%if(nsiTime.equals(thisForm.FORM_NSI_OUT)){%>selected<%}%>><%=thisForm.getNSIText("", thisForm.FORM_NSI_OUT)%></option>
	    <option value="<%=thisForm.FORM_NSI_IN_OUT%>" <%if(nsiTime.equals(thisForm.FORM_NSI_IN_OUT)){%>selected<%}%>><%=thisForm.getNSIText("", thisForm.FORM_NSI_IN_OUT)%></option>
	</select>
</div>

<div class="input-block">
    <label>*เนื่องจาก  : </label>
    <textarea name="<%=thisForm.ELM_NAME_CONTACT_DETAIL%>" style="width:241px;height:85px;"><%=thisForm.getValue(thisForm.ELM_NAME_CONTACT_DETAIL)%></textarea>
</div>

<div class="input-block">
	<label></label>

	<input type="submit" name="btnSubmit" onclick="return setFormValue();" value="ตรวจสอบรายละเอียด" style="width:130px;"> 
	<input type="reset" name="btnReset" value="เริ่มใหม่"> 
	<input type="button" name="btnBack" value="ย้อนกลับ" onclick="document.location='index.jsp?<%=LutGlobalRequestName.TASK_CODE%>=<%=taskCode.REQ_IN_COUNTRY_LEAVE_1%>';">
</div>
</form>

<p class="block">
<strong>คำแนะนำ : </strong> * หมายถึง ช่องข้อมูลที่ต้องกรอก
</p>
<jsp:include page="includes/calendar.jsp"></jsp:include>
<script language="JavaScript">
$(document).ready(function() {

	$.datepicker.setDefaults($.datepicker.regional['th']);
	
	$('#txtNSIDate').datepicker({
		isBE: true,
        autoConversionField: false,
        showButtonPanel: true,
        dateFormat: "dd MM yy",
        changeMonth: true,
        changeYear: true,
        altField: "#<%=thisForm.ELM_NAME_FORM_START_DATE%>",
        altFormat: "yymmdd",
        onSelect: function(dateText, inst) { return validateDate(this, '<%=thisForm.ELM_NAME_FORM_START_DATE%>', true); }
	});
	
});


    var frmValidator  = new Validator("frmLeaveReq");
    frmValidator.addValidation("txtNSIDate","req","กรุณาใส่วันที่ขออนุญาต");
    frmValidator.addValidation("<%=thisForm.ELM_NAME_CONTACT_DETAIL%>","req","กรุณาใส่สาเหตุการขออนุญาต");

    //Set form value
    setDateDisplayText(document.frmLeaveReq.txtNSIDate, document.frmLeaveReq.<%=thisForm.ELM_NAME_FORM_START_DATE%>.value);
    
    function setNSIRound(radioObj){
        if(radioObj.checked) document.frmLeaveReq.nsiRound.value = radioObj.value;
    }
    
    function setFormValue(){
        var endDate = document.frmLeaveReq.<%=thisForm.ELM_NAME_FORM_START_DATE%>.value;
        document.frmLeaveReq.<%=thisForm.ELM_NAME_FORM_END_DATE%>.value = endDate;
        var nsi = document.frmLeaveReq.nsiRound.value + "," + document.frmLeaveReq.nsiTime.value;
        document.frmLeaveReq.<%=thisForm.ELM_NAME_REMARK%>.value = nsi;
        return true;
    }
    
    function validateDate(objTextDate, nameDateValue, updateCE){
    	var selectedDate =  $('#'+nameDateValue).val();
    	
    	if(updateCE != null) {
    	
	    	 var yearCE = parseInt(selectedDate.substr(0,4)) - 543;
	         selectedDate = yearCE + selectedDate.substr(4,4);
	         $('#'+nameDateValue).val(selectedDate);
    	} else {
    		selectedDate="";
    	}
    }
    
</script>
