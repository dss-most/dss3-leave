<%@page contentType="text/html"%>
<%@page pageEncoding="TIS-620"%>
<%@page import="gitex.html.*"%>
<%@page import="gitex.tu.*"%>
<%@page import="gitex.tu.htmlForm.*"%>
<%@page import="gitex.utility.*"%>
<%
LeaveReqHtmlPage thisPage = new LeaveReqHtmlPage(session, request);
FrmLeaveReq thisForm = new FrmLeaveReq();   
if(session.getAttribute(LutGlobalSessionName.FORM) != null){
    thisForm = (FrmLeaveReq) session.getAttribute(LutGlobalSessionName.FORM);
}else{
    thisForm = new FrmLeaveReq(request, thisPage.getUser());  
}
FrmLeaveStat statForm = new FrmLeaveStat(session, request);
int currentBudgetYear = Date.getCurrentBudgetYear();
int budgetYear = currentBudgetYear;
if(!statForm.getValue(statForm.ELM_NAME_BUDGET_YEAR).equals("")){
    budgetYear = Integer.parseInt(statForm.getValue(statForm.ELM_NAME_BUDGET_YEAR));
}else{
    budgetYear = Integer.parseInt(thisForm.getValue(thisForm.ELM_NAME_BUDGET_YEAR));
}
thisForm.setValue(thisForm.ELM_NAME_BUDGET_YEAR, String.valueOf(budgetYear));
session.setAttribute(LutGlobalSessionName.FORM, thisForm);
%>
<h3>
����������� : <span class="lblLeaveName"><%=thisForm.getFormName()%></span><br>
�է�����ҳ : <span class="lblLeaveName"><%=budgetYear + 543%></span>

</h3>

<jsp:include page='<%="frmInputType" + thisForm.getValue(thisForm.ELM_NAME_FORM_TYPE_ID) + ".jsp"%>'></jsp:include>
<form name="searchFrm" action="#header" method="post" target="">
    ����¹�է�����ҳ��
    <select  name="<%=statForm.ELM_NAME_BUDGET_YEAR%>">
        <option value="<%=currentBudgetYear - 1%>"><%=currentBudgetYear - 1 + 543%></option>
        <option value="<%=currentBudgetYear%>"><%=currentBudgetYear + 543%></option>
        <option value="<%=currentBudgetYear + 1%>"><%=currentBudgetYear + 1 + 543%></option>
    </select>
    <input type="submit" name="btnSubmit" value=" ��ŧ "/>
</form>    
<p class="block">
<strong>���й� : </strong> * ���¶֧ ��ͧ�����ŷ���ͧ��͡
</p>
