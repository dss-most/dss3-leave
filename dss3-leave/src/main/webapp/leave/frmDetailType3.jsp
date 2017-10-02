<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>
<%@page import="gitex.html.*"%>
<%@page import="gitex.tu.*"%>
<%@page import="gitex.tu.htmlForm.*"%>
<%@page import="gitex.utility.*"%>
<%//@page import ="com.*"%>
<%  
LeaveReqHtmlPage thisPage = new LeaveReqHtmlPage(session, request);
LutLeaveReqTaskCode taskCode = new LutLeaveReqTaskCode();   
gitex.utility.Date date = new gitex.utility.Date();
FrmLeaveReq thisForm = (FrmLeaveReq) session.getAttribute(LutGlobalSessionName.FORM);
Employee employee = new Employee(thisForm.getValue(thisForm.ELM_NAME_EMP_ID));
int budgetYear = Integer.parseInt(thisForm.getValue(thisForm.ELM_NAME_BUDGET_YEAR));
employee.getLeaveStat(budgetYear);
String leaveCatId = thisForm.getValue(thisForm.ELM_NAME_FORM_CAT_ID);
double maxLeaveDay = employee.getMaxLeaveDay(leaveCatId);
double usedLeaveDay = employee.getNumOfLeaveDay(leaveCatId);
double carryForward = employee.getAmountCarryForward(budgetYear, leaveCatId);
double leaveDayLeft = 10;//maxLeaveDay - usedLeaveDay;
double netLeaveDayLeft = leaveDayLeft + carryForward;
String carryForwardText = String.valueOf((double)carryForward);
String leaveDayLeftText = String.valueOf((double)leaveDayLeft);
String netLeaveDayLeftText = String.valueOf((double)netLeaveDayLeft);
if(carryForward % 2.0 > 0) carryForwardText = String.valueOf(carryForward);
FrmLeaveReq recentForm = new FrmLeaveReq();
String recentStartDate = "-";
String recentEndDate = "-";
String recentLeaveCount = "-";
if(!thisForm.getValue(thisForm.ELM_NAME_RECENT_TAKELEAVE_ID).equals("")){
    recentForm = new FrmLeaveReq(thisForm.getValue(thisForm.ELM_NAME_RECENT_TAKELEAVE_ID));
    recentStartDate = date.getDate(recentForm.getValue(thisForm.ELM_NAME_LEAVE_START_DATE), date.MONTH_NAME_SHORT).get(date.DATE_THAI).toString();
    recentEndDate = date.getDate(recentForm.getValue(thisForm.ELM_NAME_LEAVE_END_DATE), date.MONTH_NAME_SHORT).get(date.DATE_THAI).toString();
    recentLeaveCount = recentForm.getValue(recentForm.ELM_NAME_LEAVE_DAY_COUNT_CHILD);
}
%>
<div id="doc">
<h3 class="center">แบบใบลาพักผ่อน</h3>
<span class="docHeader">
<p class="left">
 เขียนที่ <%=thisForm.getValue(thisForm.ELM_NAME_MAKE_REQ_ORG)%> <br>
 วันที่ <%=date.getDate(thisForm.getValue(thisForm.ELM_NAME_MAKE_REQ_DATE), date.MONTH_NAME_FULL).get(date.DATE_THAI).toString()%>
</p>
</span>
<p class="docSubject">
เรื่อง ขออนุญาต<%=thisForm.getFormName()%> <br>
เรียน <%=thisForm.getValue(thisForm.ELM_NAME_ORG_HEAD_WORK_TITLE)%> <%//=thisForm.ELM_NAME_FORM_CAT_ID%>
</p>
<p class="docBody">
ข้าพเจ้า <%=employee.fullName%>  
<%//=date.getCurrentBudgetYear()%>
ตำแหน่ง <%=employee.workTitle%>
สังกัด <%=employee.topORGName%>
<% if (employee.empType.equals("A") ) { %>
	มีสิทธิ์ลาพักผ่อนในปีงบประมาณนี้ 10 วันทำการ 
	ลาไปแล้ว  <%=usedLeaveDay %> วันทำการ 
	คงเหลือ  <%=10-usedLeaveDay %> วันทำการ 
<% } else { %>
	มีวันพักผ่อนสะสม <%=carryForwardText%> วันทำการ
	มีสิทธิ์ลาพักผ่อนประจำปีนี้อีก  <%=leaveDayLeftText%> วันทำการ
	รวมเป็น <%=netLeaveDayLeftText%> วันทำการ
<% } %>

ขอ<%=thisForm.getFormName()%>
ตั้งแต่วันที่ <%=date.getDate(thisForm.getValue(thisForm.ELM_NAME_FORM_START_DATE), date.MONTH_NAME_SHORT).get(date.DATE_THAI).toString()%> 
ถึงวันที่ <%=date.getDate(thisForm.getValue(thisForm.ELM_NAME_FORM_END_DATE), date.MONTH_NAME_SHORT).get(date.DATE_THAI).toString()%>
มีกำหนด <%=thisForm.getValue(thisForm.ELM_NAME_LEAVE_DAY_COUNT_MASTER)%> วัน
</p>
<p class="docBody">
ในระหว่างลาจะติดต่อข้าพเจ้าได้ที่ <%=thisForm.getValue(thisForm.ELM_NAME_TEXT_2)%>
</p>
<span class="docEnd">
<p class="center">
ขอแสดงความนับถือ<br>
ลงชื่อ <img src="images/spacer.gif" width="100" height="1"><br>
(<%=employee.fullName%>)
</p>
</span>
<span style="clear:both;"></span>
</div> 

