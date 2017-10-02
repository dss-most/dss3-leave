<%@page contentType="text/html"%>
<%@page pageEncoding="TIS-620"%>
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
FrmLeaveHistory thisForm = new FrmLeaveHistory(session, request);
if(thisForm.getValue(thisForm.ELM_NAME_BUDGET_YEAR).equals("")){
    thisForm.setLeaveHistory(employee.empId, budgetYear);
}else{
    budgetYear = Integer.parseInt(thisForm.getValue(thisForm.ELM_NAME_BUDGET_YEAR));
}
if(session.getAttribute(LutGlobalSessionName.FORM) != null){
    session.removeAttribute(LutGlobalSessionName.FORM);
}
%>
<h3>รายการคำร้องในปีงบประมาณ <%=budgetYear + 543%> </h3>
<%
if(thisForm.formList.size() > 0){
%>
<p>
<table width="100%" class="leaveStatusTable">
<tr>
<td class="tblHeader" width="20%" >วันที่ส่งใบลา<br/>ประเภทคำร้อง</td>
<td class="tblHeader" width="25%">วันที่ลา</td>
<td class="tblHeader center" width="15%">จำนวนวัน</td>
<td class="tblHeader" width="15%">สถานะ</td>
<td class="tblHeader" width="25%">หมายเหตุ</td>
</tr>
<%for(int i = 0; i < thisForm.formList.size(); i++){
    String takeLeaveId = ((Hashtable)thisForm.formList.get(i)).get(thisForm.TAKE_LEAVE_ID).toString();
    FrmLeaveReq reqForm = new FrmLeaveReq(takeLeaveId);
    String formTypeId = ((Hashtable)thisForm.formList.get(i)).get(thisForm.LEAVE_FORM_TYPE).toString();
    String formTypeName = reqForm.getFormName(((Hashtable)thisForm.formList.get(i)).get(thisForm.LEAVE_FORM_TYPE).toString());
    String issueDate = date.getDate(((Hashtable)thisForm.formList.get(i)).get(thisForm.FORM_ISSUE_DATE).toString(), date.MONTH_NAME_SHORT).get(date.DATE_THAI).toString();
    String startDate = date.getDate(((Hashtable)thisForm.formList.get(i)).get(thisForm.FORM_START_DATE).toString(), date.MONTH_NAME_SHORT).get(date.DATE_THAI).toString();
    String endDate = date.getDate(((Hashtable)thisForm.formList.get(i)).get(thisForm.FORM_END_DATE).toString(), date.MONTH_NAME_SHORT).get(date.DATE_THAI).toString();
    String status = reqForm.getStatusName(((Hashtable)thisForm.formList.get(i)).get(thisForm.FORM_STATUS).toString());
    String numOfLeaveDay = ((Hashtable)thisForm.formList.get(i)).get(thisForm.NUM_OF_LEAVE_DAY).toString();
    String refTakeLeaveId = ((Hashtable)thisForm.formList.get(i)).get(thisForm.REF_TAKELEAVE_ID).toString();
    String remark = "";
    if(!refTakeLeaveId.equals("")){
        if(formTypeId.equals(reqForm.FORM_TYPE_VACATION) || formTypeId.equals(reqForm.FORM_TYPE_PRIVATE)){
            remark = "(ไปต่างประเทศ)";
        }
    }
    String remark2 = reqForm.getValue(reqForm.ELM_NAME_TO_COUNTRY).toString();
%>
<tr>
<td class="tblRow<%=i%2%>"><a href="index.jsp?<%=LutGlobalRequestName.TASK_CODE%>=<%=LutLeaveReqTaskCode.CHECK_REQ_STATUS_2%>&<%=FrmLeaveStatusDtl.ELM_NAME_TAKE_LEAVE_ID%>=<%=takeLeaveId%>"><%=issueDate%><br/><%=formTypeName + remark%></a></td>
<td class="tblRow<%=i%2%> "><%=startDate%> - <%=endDate%></td>
<td class="tblRow<%=i%2%> center"><%=numOfLeaveDay%></td>
<td class="tblRow<%=i%2%>"><%=status%></td>
<td class="tblRow<%=i%2%>"><%=remark2%></td>
</tr>
<%}%>
</table>





<p class="block">
<strong>คำแนะนำ : </strong>คลิกที่ประเภทคำร้องเพื่อดูรายละเอียด และ ดำเนินการอื่นๆ ต่อไป
<br>
<strong>หมายเหตุ : </strong>* หมายถึง ลาเกินสิทธิ์ ต้องดำเนินการหักเงินเดือน หรือขออนุมัติการจ่ายเงินเดือน
</p>
<%}else{%>
<p class="block center">ไม่พบการลา</p>
<%}%>
</p>
<form name="searchFrm" action="index.jsp" method="post">
    แสดงคำร้องในปีงบประมาณ
    <input type="text" name="input1" style="width:30px;" value="<%=budgetYear + 543%>"/>
    <input type="hidden" name="<%=thisForm.ELM_NAME_BUDGET_YEAR%>" value=""/>
    <input type="hidden" name="<%=thisForm.ELM_NAME_EMP_ID%>" value="<%=employee.empId%>"/>
    <input type="submit" name="btnSubmit" value="ตกลง" onclick="return isValidInput();"/>
</form>    
<%@include  file="/WEB-INF/jspf/yearInput.jspf"%>   