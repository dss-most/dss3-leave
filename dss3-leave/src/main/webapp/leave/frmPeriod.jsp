<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>
<%@page import="java.util.*"%>
<%@page import="gitex.tu.*"%>
<%@page import="gitex.tu.htmlForm.*"%>
<%@page import="gitex.html.*"%>
<%
LeaveReqHtmlPage thisPage = new LeaveReqHtmlPage(session, request);
Employee employee = thisPage.getUser().employee;
LutLeaveReqTaskCode taskCode = new LutLeaveReqTaskCode();   
gitex.utility.Date date = new gitex.utility.Date();
int budgetYear = date.getCurrentBudgetYear();
FrmLeaveHistory2 thisForm = new FrmLeaveHistory2(session, request);
if(thisForm.getValue(thisForm.ELM_NAME_BUDGET_YEAR).equals("")){
    thisForm.setLeaveHistory(employee.empId, budgetYear);
}else{
    budgetYear = Integer.parseInt(thisForm.getValue(thisForm.ELM_NAME_BUDGET_YEAR));
}
if(session.getAttribute(LutGlobalSessionName.FORM) != null){
    session.removeAttribute(LutGlobalSessionName.FORM);
}
%>
<h3>สถิติการมาสายปีงบประมาณ <%=budgetYear + 543%> </h3>

<h3> ข้อมูลสิ้นสุด ณ วันที่ 30 มิถุนายน 2563 </h3>

<%
FrmLeaveHistory2 hisForm = new FrmLeaveHistory2(employee.empId, budgetYear);
//out.println(hisForm.labsList.size());
if(hisForm.labsList.size() > 0){
    FrmLateAbsent labsForm = new FrmLateAbsent();
    %>
    <p>

    <table width="100%">
    <tr>
 <!--    <td class="tblHeader" width="45%">รายการ</td> -->
    <td class="tblHeader center" width="35%">วันที่</td>
    <td class="tblHeader center" width="20%">เวลา</td>
    </tr>
    <%for(int i = 0; i < hisForm.labsList.size(); i++){
        String labsId = ((Hashtable)hisForm.labsList.get(i)).get(hisForm.LABS_ID).toString();
        String labsType = ((Hashtable)hisForm.labsList.get(i)).get(hisForm.LABS_TYPE).toString();
        String labsName = labsForm.getTypeName(labsType);
        String labsDate = date.getDate(((Hashtable)hisForm.labsList.get(i)).get(hisForm.LABS_DATE).toString(), date.MONTH_NAME_SHORT).get(date.DATE_THAI).toString();
       // String labsDateEnd = date.getDate(((Hashtable)hisForm.labsList.get(i)).get(hisForm.LABS_DATE_END).toString(), date.MONTH_NAME_SHORT).get(date.DATE_THAI).toString();
        String labsPeriod = ((Hashtable)hisForm.labsList.get(i)).get(hisForm.LABS_PERIOD).toString();
        String labsPeriodName = labsForm.getPeriodName(labsPeriod);
        String labsCount = ((Hashtable)hisForm.labsList.get(i)).get(hisForm.LABS_COUNT).toString();
		String InTime_Time=((Hashtable)hisForm.labsList.get(i)).get(hisForm.InTime_Time).toString();
        %>
        <tr>
<!--         <td class="tblRow<%//=i%2%>"><%//=labsName%></td> -->
        <td class="tblRow<%=i%2%> center">
            <%=labsDate%>
            <%if(labsType.equals(labsForm.TYPE_NO_CLASS)){%>
                - <%//=labsDateEnd%>
            <%}else{%>
                <%=labsPeriodName%>
            <%}%>
        </td>
        <td class="tblRow<%=i%2%> center"><%=InTime_Time%> </td>
        </tr>
    <%}%>
    </table>


<%}else{%>
<p class="block center">ไม่พบสถิติการมาสาย</p>
<%}%>


<!-- <p class="block">
<strong>คำแนะนำ : </strong>คลิกที่ประเภทคำร้องเพื่อดูรายละเอียด และ ดำเนินการอื่นๆ ต่อไป
<br>
<strong>หมายเหตุ : </strong>* หมายถึง ลาเกินสิทธิ์ ต้องดำเนินการหักเงินเดือน หรือขออนุมัติการจ่ายเงินเดือน
</p> -->

<!-- <form name="searchFrm" action="index.jsp" method="post">
    แสดงคำร้องในปีงบประมาณ
    <input type="text" name="input1" style="width:30px;" value="<%//=budgetYear + 543%>"/>
    <input type="hidden" name="<%//=thisForm.ELM_NAME_BUDGET_YEAR%>" value=""/>
    <input type="hidden" name="<%//=thisForm.ELM_NAME_EMP_ID%>" value="<%//=employee.empId%>"/>
    <input type="submit" name="btnSubmit" value="ตกลง" onclick="return isValidInput();"/>
</form>   -->  

<%@include  file="/WEB-INF/jspf/yearInput.jspf"%>   