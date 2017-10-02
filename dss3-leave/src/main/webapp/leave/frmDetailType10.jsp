<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>
<%@page import="java.util.*"%>
<%@page import="gitex.html.*"%>
<%@page import="gitex.tu.*"%>
<%@page import="gitex.tu.htmlForm.*"%>
<%@page import="gitex.utility.*"%>
<%
LeaveReqHtmlPage thisPage = new LeaveReqHtmlPage(session, request);
LutLeaveReqTaskCode taskCode = new LutLeaveReqTaskCode();   
gitex.utility.Date date = new gitex.utility.Date();
FrmLeaveReq thisForm = (FrmLeaveReq) session.getAttribute(LutGlobalSessionName.FORM);
Employee employee = new Employee(thisForm.getValue(thisForm.ELM_NAME_EMP_ID));
ArrayList listSubForm = new ArrayList();
if(session.getAttribute(LutGlobalSessionName.SUB_FORM) != null){
    listSubForm = (ArrayList)session.getAttribute(LutGlobalSessionName.SUB_FORM);
}
%>
<div id="doc">
<h3 class="center">บันทึกข้อความ การขออนุญาตไปต่างประเทศ</h3>
<p class="docSubject">
 ส่วนราชการ <%=thisForm.getValue(thisForm.ELM_NAME_MAKE_REQ_ORG)%> <br>
 ที่ <img src="images/spacer.gif" width="150" height="1"/> วันที่ <%=date.getDate(thisForm.getValue(thisForm.ELM_NAME_MAKE_REQ_DATE), date.MONTH_NAME_FULL).get(date.DATE_THAI).toString()%><br/>
 เรื่อง ขออนุญาตไปต่างประเทศ
 <br/><br/>
 เรียน รองอธิการบดีฝ่ายบริหารบุคคล
</p>
<p class="docBody">
เนื่องด้วย <%=employee.fullName%>
ข้าราชการพลเรือนในสถาบันอุดมศึกษา ตำแหน่ง <%=employee.workTitle%>
ระดับ XX
สังกัด <%=employee.topORGName%>
ได้รับอนุญาตให้
<%
double totalLeaveDayCount = 0; 
if(listSubForm.size() > 0){%>
    <table width="75%" align="center">
    <%
    int rowCount = 0;
    for(int i = 0; i < listSubForm.size(); i++){
       FrmLeaveReq tempForm = (FrmLeaveReq)listSubForm.get(i);
       String formTypeName = tempForm.getFormName();
       String startDate = date.getDate(tempForm.getValue(tempForm.ELM_NAME_FORM_START_DATE), date.MONTH_NAME_SHORT).get(date.DATE_THAI).toString();
       String endDate = date.getDate(tempForm.getValue(tempForm.ELM_NAME_FORM_END_DATE), date.MONTH_NAME_SHORT).get(date.DATE_THAI).toString();
       String startDatePeriod = tempForm.getPeriodName(tempForm.getValue(tempForm.ELM_NAME_FORM_START_DATE_PERIOD));
       String endDatePeriod = tempForm.getPeriodName(tempForm.getValue(tempForm.ELM_NAME_FORM_END_DATE_PERIOD));
       String leaveDayCount = tempForm.getValue(tempForm.ELM_NAME_LEAVE_DAY_COUNT_MASTER);
       totalLeaveDayCount += Double.parseDouble(leaveDayCount);
    %>
    <tr>
    <td class="left" width="25%"><%=formTypeName%></td>
    <td class="left" width="75%">ตั้งแต่วันที่ <%=startDate%> ถึง <%=endDate%></td>
    </tr>
    <%
       rowCount++;
    }%>
    <tr>
    <td colspan="2" class="left">รวม <%=totalLeaveDayCount%> วันทำการ</td>
    </tr>
    </table>
<%}%>
ในการนี้มีความประสงค์ที่จะเดินทางไปประเทศ<%=thisForm.getValue(thisForm.ELM_NAME_TO_COUNTRY)%>
ตั้งแต่วันที่ <%=date.getDate(thisForm.getValue(thisForm.ELM_NAME_FORM_START_DATE), date.MONTH_NAME_SHORT).get(date.DATE_THAI).toString()%> 
ถึงวันที่ <%=date.getDate(thisForm.getValue(thisForm.ELM_NAME_FORM_END_DATE), date.MONTH_NAME_SHORT).get(date.DATE_THAI).toString()%>
รวม <%=thisForm.getValue(thisForm.ELM_NAME_LEAVE_DAY_COUNT_MASTER)%> วัน
</p>
<p class="docBody">
จึงเรียนมาเพื่อโปรดพิจารณาอนุญาตการเดินทางไปต่างประเทศในครั้งนี้ด้วย จักเป็นพระคุณยิ่ง
</p>
<span class="docEnd">
</span>
<br/>    
<p class="block center blue">
<%=thisForm.getIsNeedVisaName(thisForm.getValue(thisForm.ELM_NAME_IS_NEED_VISA))%> หนังสือรับรองเพื่อไปขอวีซ่า
</p>
<span style="clear:both;"></span>
</div>