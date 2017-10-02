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
*���ػ�����ҡ�͹ : <input type="radio" name="<%=thisForm.ELM_NAME_IS_LEAVE_BEFORE%>" value="<%=thisForm.FORM_HAS_LEAVED_BEFORE%>" <%if(thisForm.getValue(thisForm.ELM_NAME_IS_LEAVE_BEFORE).equals(thisForm.FORM_HAS_LEAVED_BEFORE)){%>checked<%}%>/> ��  <input type="radio" name="<%=thisForm.ELM_NAME_IS_LEAVE_BEFORE%>" value="<%=thisForm.FORM_NEVER_LEAVED_BEFORE%>" <%if(thisForm.getValue(thisForm.ELM_NAME_IS_LEAVE_BEFORE).equals(thisForm.FORM_NEVER_LEAVED_BEFORE)){%>checked<%}%>/> �����
<img src="images/spacer.gif" width="95" height="1"><br/>
*�ѹ����ػ���� : <input type="text" name="txtActivityDate" style="position:relative;" value="" onKeyDown="click();return false;" onClick="window.event.cancelBubble=true;setCalendarCaller(this, '<%=thisForm.ELM_NAME_DETAIL_DATE%>', this.offsetTop, this.offsetLeft);"/>
<img src="images/spacer.gif" width="97" height="1"><br/>
<input type="hidden" name="<%=thisForm.ELM_NAME_DETAIL_DATE%>" value="<%=thisForm.getValue(thisForm.ELM_NAME_DETAIL_DATE)%>"/>
*�Ѵ����ػ����  : <input type="text" name="<%=thisForm.ELM_NAME_TEXT_1%>" style="width:241px;" value="<%=thisForm.getValue(thisForm.ELM_NAME_TEXT_1)%>"/><br />
*ʶҹ�����  : <input type="text" name="<%=thisForm.ELM_NAME_TEXT_2%>" style="width:241px;" value="<%=thisForm.getValue(thisForm.ELM_NAME_TEXT_2)%>"/><br />
*�Ѵ���Ӿ����  : <input type="text" name="<%=thisForm.ELM_NAME_TEXT_3%>" style="width:241px;" value="<%=thisForm.getValue(thisForm.ELM_NAME_TEXT_3)%>"/><br />
*ʶҹ�����  : <input type="text" name="<%=thisForm.ELM_NAME_TEXT_4%>" style="width:241px;" value="<%=thisForm.getValue(thisForm.ELM_NAME_TEXT_4)%>"/><br />
<input type="submit" name="btnSubmit" value="��Ǩ�ͺ��������´" style="width:130px;"> 
<input type="reset" name="btnReset" value="���������"> 
<input type="button" name="btnBack" value="��͹��Ѻ" onclick="document.location='index.jsp?<%=LutGlobalRequestName.TASK_CODE%>=<%=taskCode.REQ_IN_COUNTRY_LEAVE_1%>';">
</p>
</form>
</p>
<p class="block">
<strong>���й� : </strong> * ���¶֧ ��ͧ�����ŷ���ͧ��͡
</p>
<jsp:include page="includes/calendar.jsp"></jsp:include>
<script language="JavaScript">
    var frmLoginValidator  = new Validator("FrmLeaveReq");
    frmLoginValidator.addValidation("txtLeaveSD","req","��س�����ѹ������鹡����");
    frmLoginValidator.addValidation("txtLeaveED","req","��س�����ѹ����ش�����");
    frmLoginValidator.addValidation("<%=thisForm.ELM_NAME_TEXT_1%>","req","��س�����Ѵ����ػ����");
    frmLoginValidator.addValidation("txtActivityDate","req","��س�����ѹ����ػ����");
    frmLoginValidator.addValidation("<%=thisForm.ELM_NAME_TEXT_2%>","req","��س�������駢ͧ�Ѵ����ػ����");
    frmLoginValidator.addValidation("<%=thisForm.ELM_NAME_TEXT_3%>","req","��س�����Ѵ���Ӿ����");
    frmLoginValidator.addValidation("<%=thisForm.ELM_NAME_TEXT_4%>","req","��س�������駢ͧ�Ѵ���Ӿ����");

    setDateDisplayText(document.all['txtLeaveSD'], document.all['<%=thisForm.ELM_NAME_FORM_START_DATE%>'].value);
    setDateDisplayText(document.all['txtActivityDate'], document.all['<%=thisForm.ELM_NAME_DETAIL_DATE%>'].value);
    setDateDisplayText(document.all['txtLeaveED'], document.all['<%=thisForm.ELM_NAME_FORM_END_DATE%>'].value);
    validateDate(null, null);
</script>
