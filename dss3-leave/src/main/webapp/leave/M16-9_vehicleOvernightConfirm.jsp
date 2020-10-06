<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>
<%@page import="gitex.html.*"%>
<%@page import="gitex.tu.*"%>
<%@page import="gitex.tu.htmlForm.*"%>
<%@page import="gitex.utility.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
LutLeaveReqTaskCode taskCode = new LutLeaveReqTaskCode();
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
ตรวจสอบข้อมูลการขออนุญาตจอดรถค้างคืน
</h3>

หมายเลขในระบบ: ${FORM_ID} <br/>
วันที่ทำรายการ: ${FORMISSUEDATE} <br/>

<p>เรียน ลสล.  ผ่าน   ${ORG_HEAD_WORK_TITLE}</p>
  
<p style="text-indent: 40px;">ข้าพเจ้าขออนุญาตนำรถยนต์ทะเบียน ${LICENSE_NUMBER} ${LICENSE_PROVINCE} มาจอดค้างคืนในกรมวิทยาศาสตร์บริการ
ในระหว่างวันที่ี่ ${START_OVERNIGHT} ถึงวันที่ ${START_OVERNIGHT} เนื่องจาก ${REASON}


<br/>
<input type="button" name="btnPrint" value="พิมพ์แบบขอใช้รถยนต์" onclick="window.open('<c:url value='/spring/pdfFrmHrVehicleOvernightReqForm'/>?id=${FORM_ID}', '_blank')"/>
<input type="button" name="btnBack" value="ย้อนกลับ" onclick="document.location='index.jsp?<%=LutGlobalRequestName.TASK_CODE%>=<%=taskCode.VIEW_MISC_FORM%>';"/>



