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
����������ͧ : <span class="lblLeaveName"><%=tempForm.getFormName()%></span><br/>
ʶҹ� : <span class="lblLeaveName"><%=tempForm.getStatusName(tempForm.getValue(tempForm.ELM_NAME_STATUS))%></span><br/>
</h3>
<p class="block blue">
�ѹ���������鹡���� <%=((Hashtable)date.getDate(tempForm.getValue(tempForm.ELM_NAME_LEAVE_START_DATE), date.MONTH_NAME_FULL)).get(date.DATE_THAI).toString()%> <%=tempForm.getPeriodName(tempForm.getValue(tempForm.ELM_NAME_LEAVE_START_DATE_PERIOD))%><br>
�ѹ�������ش����� <%=((Hashtable)date.getDate(tempForm.getValue(tempForm.ELM_NAME_LEAVE_END_DATE), date.MONTH_NAME_FULL)).get(date.DATE_THAI).toString()%> <%=tempForm.getPeriodName(tempForm.getValue(tempForm.ELM_NAME_LEAVE_END_DATE_PERIOD))%><br>
����������ҷ����� <%=tempForm.getValue(tempForm.ELM_NAME_LEAVE_DAY_COUNT_MASTER)%> �ѹ<br>
</p>
<jsp:include page="frmDetailType12.jsp"/>
<p>
    <form class="center" action="index.jsp" method="post">
    <input type="hidden" name="<%=LutGlobalRequestName.TASK_CODE%>" value="<%=LutLeaveReqTaskCode.SUBMIT_CANCEL_PARTIAL%>">
    <input type="submit" name="btnSubmit" value="��㺢�¡��ԡ�ѹ��" onclick="return confirm('��س��׹�ѹ���¡��ԡ�ѹ��');"> 
    <input type="button" name="btnBack" value="��͹��Ѻ" onclick="document.location='index.jsp?<%=LutGlobalRequestName.TASK_CODE%>=<%=LutLeaveReqTaskCode.INPUT_CANCEL_PARTIAL%>';">
    </form>
</p>
