<%@page contentType="text/html"%>
<%@page pageEncoding="TIS-620"%>
<%@page import="java.util.*"%>
<%@page import="gitex.html.*"%>
<%@page import="gitex.tu.*"%>
<%@page import="gitex.tu.htmlForm.*"%>
<%
LeaveReqHtmlPage thisPage = new LeaveReqHtmlPage(session, request);
LutLeaveReqTaskCode taskCode = new LutLeaveReqTaskCode();   
FrmApproveReqDtl thisForm = new FrmApproveReqDtl(request);
FrmLeaveReq reqForm = new FrmLeaveReq(thisForm.getValue(thisForm.ELM_NAME_TAKE_LEAVE_ID));
session.setAttribute(LutGlobalSessionName.FORM, reqForm);
ArrayList listSubForm = new ArrayList();
boolean isAllSubAllowed = true;
if(reqForm.getValue(reqForm.ELM_NAME_FORM_TYPE_ID).equals(reqForm.FORM_TYPE_OUT_COUNTRY_WITH_LEAVE)){
    ArrayList listSubFormId = reqForm.getSubFormId();
    for(int i = 0; i < listSubFormId.size(); i++){
        FrmLeaveReq subForm = new FrmLeaveReq(listSubFormId.get(i).toString());
        if(!subForm.getValue(subForm.ELM_NAME_STATUS).equals(subForm.FORM_STATUS_ALLOW)) isAllSubAllowed = false;
        listSubForm.add(subForm);
    }
}
if(listSubForm.size() > 0){
    session.removeAttribute(LutGlobalSessionName.SUB_FORM);
    session.setAttribute(LutGlobalSessionName.SUB_FORM, listSubForm);
}
%>
<h3>
����ͧ : <span class="lblLeaveName"><%=reqForm.getFormName()%></span><br/>
���� : <span class="lblLeaveName"><%=reqForm.getSendPurpose()%></span>
</h3>
<jsp:include page='<%="frmDetailType" + reqForm.getValue(reqForm.ELM_NAME_FORM_TYPE_ID) + ".jsp"%>'></jsp:include>
<%
if(!reqForm.getValue(reqForm.ELM_NAME_FORM_CAT_ID).equals("")){   
    Employee employee = thisPage.getUser().employee;
    gitex.utility.Date date = new gitex.utility.Date();
    employee.getLeaveStat(date.getCurrentBudgetYear());
    double maxLeaveDay = employee.getMaxLeaveDay(reqForm.getValue(reqForm.ELM_NAME_FORM_CAT_ID));
    double currentLeaveDay = employee.getNumOfLeaveDay(reqForm.getValue(reqForm.ELM_NAME_FORM_CAT_ID));
    double thisLeaveDay = Double.parseDouble(reqForm.getValue(reqForm.ELM_NAME_LEAVE_DAY_COUNT_CHILD));
    if(maxLeaveDay - currentLeaveDay - thisLeaveDay < 0){
    %>
    <p class="block blue">
    <strong>�����˵� : </strong>����ҹ���繡���ҷ�����ѹ���Թ�Է���
    </p>
<%}}%>
<p></p>
<p class="block">
    <form action="index.jsp" method="post">
        <%if(reqForm.getValue(reqForm.ELM_NAME_FORM_TYPE_ID).equals(reqForm.FORM_TYPE_OUT_COUNTRY_WITH_LEAVE) && !isAllSubAllowed){%>
            <strong>�����˵� : </strong> �ѧ�������ö���Թ����� ����� ���ͧ�ҡ��������� �ѧ������Ѻ͹حҵ������
            <br/><br/>
        <%}else{%>
            <strong>��繤�� :</strong><br>
            <input type="hidden" name="<%=LutGlobalRequestName.TASK_CODE%>" value="<%=taskCode.SUBMIT_APPROVE%>"/>
            <input type="hidden" name="<%=FrmSubmitApprove.ELM_NAME_TAKE_LEAVE_ID%>" value="<%=thisForm.getValue(thisForm.ELM_NAME_TAKE_LEAVE_ID)%>"/>
            <input type="radio" name="<%=FrmSubmitApprove.ELM_NAME_APPROVE_VALUE%>" value="<%=FrmSubmitApprove.ALLOW%>" checked/> ͹حҵ<br/>
            <input type="radio" name="<%=FrmSubmitApprove.ELM_NAME_APPROVE_VALUE%>" value="<%=FrmSubmitApprove.NOT_ALLOW%>"/> ���͹حҵ <br/>
            <span style="padding-left:25px;">���ͧ�ҡ <input type="text" name="<%=FrmSubmitApprove.ELM_NAME_APPROVE_COMMENT%>" value="" style="width:300px;"/></span><br>
            <input type="radio" name="<%=FrmSubmitApprove.ELM_NAME_APPROVE_VALUE%>" value="<%=FrmSubmitApprove.FORWARD%>"/> �Ѻ��Һ����觵����ѧ������ӹҨ�Ԩ�ó� <br/>
            <br/>
            <input type="submit" name="btnOK" value=" ��ŧ " onclick="return confirm('��س��׹�ѹ������ա����');"/>
        <%}%>
        <input type="button" name="btnBack" value="��͹��Ѻ" onclick="window.history.back();"/>            
    </form>
</p>
<p></p>
<jsp:include page="frmReqLog.jsp">
    <jsp:param name="takeLeaveId" value="<%=thisForm.getValue(thisForm.ELM_NAME_TAKE_LEAVE_ID)%>"/>
</jsp:include>

