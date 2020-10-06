<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>
<%@page import="java.util.*"%>
<%@page import="gitex.html.*"%>
<%@page import="gitex.tu.*"%>
<%@page import="gitex.tu.htmlForm.*"%>
<%
LeaveReqHtmlPage thisPage = new LeaveReqHtmlPage(session, request);
LutLeaveReqTaskCode taskCode = new LutLeaveReqTaskCode();   
FrmApprover apvrForm = new FrmApprover(request, thisPage.getUser().employee.empId);   
FrmForwardReqDtl thisForm = new FrmForwardReqDtl(request);
FrmLeaveReq reqForm = new FrmLeaveReq(thisForm.getValue(thisForm.ELM_NAME_TAKE_LEAVE_ID));
String reqStatus = reqForm.getValue(reqForm.ELM_NAME_STATUS);
LeaveReqLog reqLog = new LeaveReqLog(reqForm.getValue(reqForm.ELM_NAME_TAKE_LEAVE_ID));
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
คำร้อง : <span class="lblLeaveName"><%=reqForm.getFormName()%></span><br/>
สถานะ : <span class="lblLeaveName"><%=reqForm.getStatusName(reqStatus)%></span>
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
        <strong>หมายเหตุ : </strong>การลานี้เป็นการลาที่ใช้วันลาเกินสิทธิ์
        </p>
        <%
    }
}%>
<p></p>
<jsp:include page="frmReqLog.jsp">
    <jsp:param name="takeLeaveId" value="<%=thisForm.getValue(thisForm.ELM_NAME_TAKE_LEAVE_ID)%>"/>
</jsp:include>
<%if(reqStatus.equals(reqForm.FORM_STATUS_WAITING)){%>
    <p></p>
    <%if(reqForm.getValue(reqForm.ELM_NAME_FORM_TYPE_ID).equals(reqForm.FORM_TYPE_OUT_COUNTRY_WITH_LEAVE) && !isAllSubAllowed){%>
        <p class="block">
        <strong>หมายเหตุ : </strong> ยังไม่สามารถดำเนินการใดๆ ต่อได้ เนื่องจากการลาย่อย ยังไม่ได้รับอนุญาตทั้งหมด
        <br/><br/>
        <input type="button" name="btnBack" value="ย้อนกลับ" onclick="window.history.back();"/>            
        </p>
    <%}else{%>
        <h3>เปลี่ยนผู้พิจารณาคำร้อง</h3>
        <form name="frmSearch" class="left" action="index.jsp" method="post">
        <input type="hidden" name="<%=LutGlobalRequestName.TASK_CODE%>" value="<%=thisPage.getTaskCode()%>"/>
        <input type="hidden" name="<%=thisForm.ELM_NAME_TAKE_LEAVE_ID%>" value="<%=thisForm.getValue(thisForm.ELM_NAME_TAKE_LEAVE_ID)%>"/>
        ค้นหาจากชื่อ <input type="text" name="<%=apvrForm.ELM_NAME_SEARCH_FNAME%>" value="<%=apvrForm.getValue(apvrForm.ELM_NAME_SEARCH_FNAME)%>"> <input type="submit" name="btnSubmit" value="ค้นหา"/>
        </form>
        <%if(apvrForm.searchResult.size() > 0){%>
            <form class="center" action="index.jsp" method="post">
            <input type="hidden" name="<%=LutGlobalRequestName.TASK_CODE%>" value="<%=taskCode.SUBMIT_FORWARD%>"/>
            <input type="hidden" name="<%=FrmSubmitForward.ELM_NAME_TAKE_LEAVE_ID%>" value="<%=thisForm.getValue(thisForm .ELM_NAME_TAKE_LEAVE_ID)%>"/>
            <table width="100%">
            <tr>
            <td class="tblHeader center" width="10%">เลือก</td>
            <td class="tblHeader left" width="30%">ชื่อ-นามสกุล</td>
            <td class="tblHeader left" width="25%">ตำแหน่ง</td>
            <td class="tblHeader left" width="35%">หน่วยงาน</td>
            </tr>
            <%for(int i = 0; i < apvrForm.searchResult.size(); i++){
                Employee commander = (Employee)apvrForm.searchResult.get(i);
                %>
                <tr>
                <td class="tblRow0 center"><input type="radio" name="<%=FrmSubmitForward.ELM_NAME_TO_EMP_ID%>" <%if(i == 0){%>checked<%}%> value="<%=commander.empId%>"></td>
                <td class="tblRow0 left"><%=commander.fullName%></td>
                <td class="tblRow0 left"><%=commander.workTitle%></td>
                <td class="tblRow0 left"><%=commander.topORGName%></td>
                </tr>
            <%}%>
            </table>
            <input type="submit" name="btnSubmit" value="ส่งใบขออนุญาตลา" onclick="if(confirm('กรุณายืนยันการส่งใบขออนุญาตลา')) return true; else return false;"> 
            <input type="button" name="btnBack" value="ย้อนกลับ" onclick="document.location='index.jsp?<%=LutGlobalRequestName.TASK_CODE%>=<%=LutLeaveReqTaskCode.MANAGE_LEAVE_1%>';">
            </form>
        <%}else{%>
            <p class="block center">
                ไม่พบผู้มีอำนาจในการพิจารณาคำร้อง<br/>
                <input type="button" name="btnBack" value="ย้อนกลับ" onclick="document.location='index.jsp?<%=LutGlobalRequestName.TASK_CODE%>=<%=LutLeaveReqTaskCode.VIEW_WAITING_FORWARD_REQ_1%>';">
            </p>
        <%}%>
        <p class="block">
            <strong>คำแนะนำ :</strong> ถ้าต้องการค้นหาทั้งหมด ให้ค้นหาโดยไม่ต้องระบุชื่อ
        </p>
    <%}%>
<%}else{%>
    <p class="center">
        <input type="button" name="btnBack" value="ย้อนกลับ" onclick="document.location='index.jsp?<%=LutGlobalRequestName.TASK_CODE%>=<%=LutLeaveReqTaskCode.MANAGE_LEAVE_1%>';">
    </p>
<%}%>