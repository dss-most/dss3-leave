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
<p>
<form name="frmLeaveReq" action="index.jsp" method="post">
<input type="hidden" name="<%=LutGlobalRequestName.TASK_CODE%>" value="<%=taskCode.REQ_IN_COUNTRY_LEAVE_3%>"/>
<input type="hidden" name="<%=thisForm.ELM_NAME_FORM_TYPE_ID%>" value="<%=thisForm.getValue(thisForm.ELM_NAME_FORM_TYPE_ID)%>"/>
<input type="hidden" name="<%=thisForm.ELM_NAME_FORM_CAT_ID%>" value="<%=thisForm.getValue(thisForm.ELM_NAME_FORM_CAT_ID)%>"/>
<input type="hidden" name="<%=thisForm.ELM_NAME_BUDGET_YEAR%>" value="<%=thisForm.getValue(thisForm.ELM_NAME_BUDGET_YEAR)%>"/>
<p class="right" style="width:350px;">
<input type="hidden" name="<%=thisForm.ELM_NAME_FORM_START_DATE%>" value="<%=thisForm.getValue(thisForm.ELM_NAME_FORM_START_DATE)%>"/>
<input type="hidden" name="<%=thisForm.ELM_NAME_FORM_END_DATE%>" value="<%=thisForm.getValue(thisForm.ELM_NAME_FORM_END_DATE)%>"/>
<input type="hidden" name="<%=thisForm.ELM_NAME_REMARK%>" value=""/>
<input type="hidden" name="<%=thisForm.ELM_NAME_LEAVE_DAY_COUNT_MASTER%>" value="1"/>
เรียน : <input type="text" name="<%=thisForm.ELM_NAME_ORG_HEAD_WORK_TITLE%>" value="<%=thisForm.getValue(thisForm.ELM_NAME_ORG_HEAD_WORK_TITLE)%>"/><img src="images/spacer.gif" width="21" height="1" /><img src="images/spacer.gif" width="81" height="1" /><br />
*วันที่ : <input type="text" name="txtNSIDate" style="position:relative;" value="" onKeyDown="click();return false;" onClick="window.event.cancelBubble=true;setCalendarCaller(this, '<%=thisForm.ELM_NAME_FORM_START_DATE%>', this.offsetTop, this.offsetLeft);"/>
<img src="images/spacer.gif" width="98" height="1"/><br/>
<input type="hidden" name="nsiRound" value="<%=nsiRound%>">
*รอบ : <input type="radio" name="radio1" value="<%=thisForm.FORM_NSI_0730%>" <%if(nsiRound.equals(thisForm.FORM_NSI_0730)){%>checked<%}%> onclick="setNSIRound(this);"><%=thisForm.getNSIText(thisForm.FORM_NSI_0730, "")%>
<input type="radio" name="radio1" value="<%=thisForm.FORM_NSI_0830%>" <%if(nsiRound.equals(thisForm.FORM_NSI_0830)){%>checked<%}%> onclick="setNSIRound(this);"><%=thisForm.getNSIText(thisForm.FORM_NSI_0830, "")%>
<img src="images/spacer.gif" width="40" height="1"/><br/>
*เวลา : <select name="nsiTime" style="margin:0 0 1px 0;">
    <option value="<%=thisForm.FORM_NSI_IN%>" <%if(nsiTime.equals(thisForm.FORM_NSI_IN)){%>selected<%}%>><%=thisForm.getNSIText("", thisForm.FORM_NSI_IN)%></option>
    <option value="<%=thisForm.FORM_NSI_OUT%>" <%if(nsiTime.equals(thisForm.FORM_NSI_OUT)){%>selected<%}%>><%=thisForm.getNSIText("", thisForm.FORM_NSI_OUT)%></option>
    <option value="<%=thisForm.FORM_NSI_IN_OUT%>" <%if(nsiTime.equals(thisForm.FORM_NSI_IN_OUT)){%>selected<%}%>><%=thisForm.getNSIText("", thisForm.FORM_NSI_IN_OUT)%></option>
</select>
<img src="images/spacer.gif" width="67" height="1"/><br/>
<span style="vertical-align:top;">*เนื่องจาก  : </span><textarea name="<%=thisForm.ELM_NAME_CONTACT_DETAIL%>" style="width:241px;height:85px;"><%=thisForm.getValue(thisForm.ELM_NAME_CONTACT_DETAIL)%></textarea><br />
<input type="submit" name="btnSubmit" onclick="return setFormValue();" value="ตรวจสอบรายละเอียด" style="width:130px;"> 
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
</script>
