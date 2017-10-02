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
แบบฟอร์มขอใช้รถยนตร์ไปราชการในเขตกรุงเทพและปริมณฑล
</h3>
<jsp:include page='<%="frmInputType_vehicle.jsp"%>'></jsp:include>

