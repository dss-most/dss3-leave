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
FrmLeaveReq thisForm = new FrmLeaveReq(request, thisPage.getUser());   
gitex.utility.Date date = new gitex.utility.Date();
if(!thisForm.getValue(thisForm.ELM_NAME_FORM_TYPE_ID).equals("")){
    session.setAttribute(LutGlobalSessionName.FORM, thisForm);
}
%>
<h3>ประเภทการลา : <span class="lblLeaveName"><%=thisForm.getFormName()%></span></h3>
<%if(!thisForm.isElapse()){%>
    <jsp:include page='<%="frmDetailType" + thisForm.getValue(thisForm.ELM_NAME_FORM_TYPE_ID) + ".jsp"%>'/>
    <br>
    <%
    if(!thisForm.getValue(thisForm.ELM_NAME_FORM_CAT_ID).equals("")){   
        Employee employee = thisPage.getUser().employee;
        employee.getLeaveStat(date.getCurrentBudgetYear());
        String leaveCatId = thisForm.getValue(thisForm.ELM_NAME_FORM_CAT_ID);
        double maxLeaveDay = employee.getMaxLeaveDay(leaveCatId);
        double currentLeaveDay = employee.getNumOfLeaveDay(leaveCatId);
        double thisLeaveDay = Double.parseDouble(thisForm.getValue(thisForm.ELM_NAME_LEAVE_DAY_COUNT_MASTER));
        if(!leaveCatId.equals(thisForm.FORM_TYPE_PRIVATE) && !leaveCatId.equals(thisForm.FORM_TYPE_SICKNESS)){
            if(maxLeaveDay - currentLeaveDay - thisLeaveDay < 0){
            %>
          <!--  <p class="block blue">
                <strong>หมายเหตุ : </strong>การลานี้เป็นการลาเกินสิทธิ์(จำนวนวันลารวมมากกว่า <%//=maxLeaveDay%>) ท่านจะถูกหักเงินเดือนในวันที่ลาเกิน
            </p> -->
            <%}
        }else{
            currentLeaveDay = employee.getNumOfLeaveDay(leaveCatId) + employee.getNumOfLeaveDay(leaveCatId);
            if(currentLeaveDay + thisLeaveDay > 60){
            %>
           <!-- <p class="block blue">
                <strong>หมายเหตุ : </strong>การลานี้เป็นการลาเกินสิทธิ์(ลากิจรวมลาป่วยเกิน 60 วัน) ท่านจะถูกหักเงินเดือนในวันที่ลาเกิน
            </p> -->
            <%
            }
        }
    }%>
    <jsp:include page="frmLeaveStatDtl.jsp"/>
    <form class="center" action="index.jsp" method="post">
    <input type="hidden" name="<%=LutGlobalRequestName.TASK_CODE%>" value="<%=LutLeaveReqTaskCode.SUBMIT_REQ%>">
    <input type="hidden" name="<%=FrmApprover.ELM_NAME_CALLER_TASK_CODE%>" value="<%=thisPage.getTaskCode()%>">
    <input type="submit" name="btnSubmit" value="ส่งใบลา" onclick="return confirm('กรุณายืนยันการส่งใบลาอีกครั้ง');"> 
    <input type="button" name="btnBack" value="ย้อนกลับ" onclick="document.location='index.jsp?<%=LutGlobalRequestName.TASK_CODE%>=<%=taskCode.REQ_IN_COUNTRY_LEAVE_2%>';">
    </form>
<%}else{
    ArrayList takeLeaveId = thisForm.getElapseReq();
    %>
    <p class="block center">
        ช่วงเวลาการลาทับซ้อนกับการลาที่มีอยู่แล้ว<br/>
        <input type="button" name="btnBack" value="   OK   " onclick="document.location='index.jsp?<%=LutGlobalRequestName.TASK_CODE%>=<%=taskCode.REQ_IN_COUNTRY_LEAVE_2%>';">
    </p>
    <table width="100%">
    <tr>
    <td class="tblHeader" width="25%">ประเภทคำร้องที่ทับซ้อน</td>
    <td class="tblHeader" width="25%">วันที่</td>
    <td class="tblHeader center" width="10%">จำนวนวัน</td>
    <td class="tblHeader" width="15%">สถานะ</td>
    <td class="tblHeader" width="20%">หมายเหตุ</td>
    </tr>
    <%
    for(int i = 0; i < takeLeaveId.size(); i++){
        FrmLeaveReq reqForm = new FrmLeaveReq(takeLeaveId.get(i).toString());
        String formTypeId = reqForm.getValue(reqForm.ELM_NAME_FORM_TYPE_ID);
        String formTypeName = reqForm.getFormName();
        String startDate = date.getDate(reqForm.getValue(reqForm.ELM_NAME_FORM_START_DATE), date.MONTH_NAME_SHORT).get(date.DATE_THAI).toString();
        String endDate = date.getDate(reqForm.getValue(reqForm.ELM_NAME_FORM_END_DATE), date.MONTH_NAME_SHORT).get(date.DATE_THAI).toString();
        String status = reqForm.getStatusName(reqForm.getValue(reqForm.ELM_NAME_STATUS));
        String numOfLeaveDay = reqForm.getValue(reqForm.ELM_NAME_LEAVE_DAY_COUNT_MASTER);
        String refTakeLeaveId = reqForm.getValue(reqForm.ELM_NAME_REF_TAKE_LEAVE_ID);
        String remark = "";
        if(!refTakeLeaveId.equals("")){
            if(formTypeId.equals(reqForm.FORM_TYPE_VACATION) || formTypeId.equals(reqForm.FORM_TYPE_PRIVATE)){
                remark = "(ไปต่างประเทศ)";
            }
        }
        String remark2 = reqForm.getValue(reqForm.ELM_NAME_TO_COUNTRY).toString();
    %>
    <tr>
    <td class="tblRow<%=i%2%>"><%=formTypeName + remark%></td>
    <td class="tblRow<%=i%2%> "><%=startDate%> - <%=endDate%></td>
    <td class="tblRow<%=i%2%> center"><%=numOfLeaveDay%></td>
    <td class="tblRow<%=i%2%>"><%=status%></td>
    <td class="tblRow<%=i%2%>"><%=remark2%></td>
    </tr>
    <%}%>
    </table>
    <br>
<%}%>
