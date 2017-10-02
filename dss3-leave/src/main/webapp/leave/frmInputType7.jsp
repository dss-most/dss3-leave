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
<p class="right" style="width:390px;">
<%@include file="/WEB-INF/jspf/dateInput.jspf" %>
<span style="font-size:smaller;">*ได้รับหมายเรียกของ</span>  : <input type="text" name="<%=thisForm.ELM_NAME_TEXT_1%>" style="width:241px;" value="<%=thisForm.getValue(thisForm.ELM_NAME_TEXT_1)%>"/><br />
*ที่  : <input type="text" name="<%=thisForm.ELM_NAME_TEXT_2%>" style="width:241px;" value="<%=thisForm.getValue(thisForm.ELM_NAME_TEXT_2)%>"/><br />
*ลงวันที่ : <input type="text" name="txtActivityDate" style="position:relative;" value="" onKeyDown="click();return false;" onClick="window.event.cancelBubble=true;setCalendarCaller(this, '<%=thisForm.ELM_NAME_DETAIL_DATE%>', this.offsetTop, this.offsetLeft);"/>
<img src="images/spacer.gif" width="97" height="1"><br/>
<input type="hidden" name="<%=thisForm.ELM_NAME_DETAIL_DATE%>" value="<%=thisForm.getValue(thisForm.ELM_NAME_DETAIL_DATE)%>"/>
*ให้เข้ารับการ  : <select name="<%=thisForm.ELM_NAME_TEXT_3%>" style="width:247px;">
<option value="เกณฑ์ทหาร"  <%if(thisForm.getValue(thisForm.ELM_NAME_TEXT_3).equals("เกณฑ์ทหาร")){%>selected<%}%>/>เกณฑ์ทหาร</option>
<option value="เตรียมพล" <%if(thisForm.getValue(thisForm.ELM_NAME_TEXT_3).equals("เตรียมพล")){%>selected<%}%>/>เตรียมพล</option>
</select>
<br />
*สถานที่  : <input type="text" name="<%=thisForm.ELM_NAME_TEXT_4%>" style="width:241px;" value="<%=thisForm.getValue(thisForm.ELM_NAME_TEXT_4)%>"/><br />
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
    frmLoginValidator.addValidation("<%=thisForm.ELM_NAME_TEXT_1%>","req","กรุณาใส่หน่วยที่ออกหมายเรียก");
    frmLoginValidator.addValidation("<%=thisForm.ELM_NAME_TEXT_2%>","req","กรุณาใส่หมายเลขหมายเรียก");
    frmLoginValidator.addValidation("txtActivityDate","req","กรุณาใส่วันที่อุปสมบท");
    frmLoginValidator.addValidation("<%=thisForm.ELM_NAME_TEXT_3%>","req","กรุณาใส่วันที่ออกหมายเรียก");
    frmLoginValidator.addValidation("<%=thisForm.ELM_NAME_TEXT_4%>","req","กรุณาใส่สถานที่ที่ต้องไปรับราชการทหาร");

    setDateDisplayText(document.all['txtLeaveSD'], document.all['<%=thisForm.ELM_NAME_FORM_START_DATE%>'].value);
    setDateDisplayText(document.all['txtLeaveED'], document.all['<%=thisForm.ELM_NAME_FORM_END_DATE%>'].value);
    setDateDisplayText(document.all['txtActivityDate'], document.all['<%=thisForm.ELM_NAME_DETAIL_DATE%>'].value);
    validateDate(null, null);
</script>
