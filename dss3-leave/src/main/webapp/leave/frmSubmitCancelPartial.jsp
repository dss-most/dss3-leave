<%@page contentType="text/html"%>
<%@page pageEncoding="TIS-620"%>
<%@page import="java.util.*"%>
<%@page import="gitex.html.*"%>
<%@page import="gitex.tu.*"%>
<%@page import="gitex.tu.htmlForm.*"%>
<%
gitex.utility.Date date = new gitex.utility.Date();   
LeaveReqHtmlPage thisPage = new LeaveReqHtmlPage(session, request);
LutLeaveReqTaskCode taskCode = new LutLeaveReqTaskCode();   
FrmLeaveReq reqForm = (FrmLeaveReq) session.getAttribute(LutGlobalSessionName.FORM);
FrmLeaveReq tempForm = new FrmLeaveReq(reqForm.getValue(reqForm.ELM_NAME_REF_TAKE_LEAVE_ID));   
FrmSubmitCancelPartial thisForm = new FrmSubmitCancelPartial(reqForm);
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
<p class="block center">
    <%if(thisForm.isSuccess){%>
        㺢�¡��ԡ�ѹ����١����ѧ���ԨҳҤ���ͧ���º��������
        <p class="center"><input type="button" value="�ʴ���������´���;�������ͧ" onclick="document.location='index.jsp?<%=LutGlobalRequestName.MENU_CODE%>=<%=LutLeaveReqMenuCode.CHECK_REQ_STATUS%>&<%=LutGlobalRequestName.TASK_CODE%>=<%=LutLeaveReqTaskCode.CHECK_REQ_STATUS_2%>&<%=FrmLeaveStatusDtl.ELM_NAME_TAKE_LEAVE_ID%>=<%=reqForm.getValue(reqForm.ELM_NAME_TAKE_LEAVE_ID)%>';"/></p>
    <%}else{%>
        <span style="color:red;">�բ�ͼԴ��Ҵ㹡�÷ӧҹ ��س��ͧ�ա����</span>
        <p class="center"><input type="button" value="   OK   " onclick="document.location='index.jsp?<%=LutGlobalRequestName.TASK_CODE%>=<%=taskCode.CHECK_REQ_STATUS_1%>';"/></p>
    <%}%>
</p>
