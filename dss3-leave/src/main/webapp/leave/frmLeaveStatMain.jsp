<%@page contentType="text/html"%>
<%@page pageEncoding="TIS-620"%>
<%@page import="java.util.*"%>
<%@page import="gitex.html.*"%>
<%@page import="gitex.tu.*"%>
<%@page import="gitex.tu.htmlForm.*"%>
<%@page import="gitex.utility.*"%>
<%
LeaveReqHtmlPage thisPage = new LeaveReqHtmlPage(session, request);
Employee employee = thisPage.getUser().employee;
gitex.utility.Date date = new gitex.utility.Date();
FrmLeaveStat thisForm = new FrmLeaveStat(session, request);
int budgetYear = date.getCurrentBudgetYear();
if(!thisForm.getValue(thisForm.ELM_NAME_BUDGET_YEAR).equals("")) budgetYear = Integer.parseInt(thisForm.getValue(thisForm.ELM_NAME_BUDGET_YEAR));
%>
<form name="searchFrm" action="index.jsp" method="post">
	<h3>แสดงสถิติการลาในปีงบประมาณ
    <input type="text" name="input1" style="width:30px;" value="<%=budgetYear + 543%>"/>
    <input type="hidden" name="<%=thisForm.ELM_NAME_BUDGET_YEAR%>" value=""/>
    <input type="submit" name="btnSubmit" value="ตกลง" onclick="return isValidInput();"/>
	</h3>
</form>    
<%@include  file="/WEB-INF/jspf/yearInput.jspf"%>   

<jsp:include page="frmLeaveStatDtl.jsp">
    <jsp:param name="budgetYear" value="<%=budgetYear%>"/>
</jsp:include>   



