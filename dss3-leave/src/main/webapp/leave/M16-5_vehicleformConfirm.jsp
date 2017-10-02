<%@page contentType="text/html"%>
<%@page pageEncoding="TIS-620"%>
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
ตรวจสอบข้อมูลการขอใช้รถยนต์
</h3>

หมายเลขในระบบ: ${FRM_ID}

<p>เรียน ${ORG_HEAD_WORK_TITLE}</p>
  
<p style="text-indent: 40px;">ข้าพเจ้าขอใช้รถยนต์เพื่อไปราชการในเขตกรุงเทพ/ปริมณฑล ในวันที่ ${VEHICLEREQUESTDATE} ระหว่างเวลา ${VEHICLESTARTTIME}น. 
ถึงเวลา ${VEHICLEENDTIME}น. ตามสถานที่และราชการที่ปฏิบัติดังต่อไปนี้ </p>

<table style="width: 570px" class="border">
	<tr>
		<td style="width: 285px; text-align: center;"><span style="font-weight: bold;">สถานที่ไป</span></td>
		<td style="width: 285px; text-align: center;"><span style="font-weight: bold;">ราชการที่ไปปฏิบัติ</span></td>
	</tr>
	<tr>
		<td>${PLACETOGO}</td>
		<td>${REASONTOGO}</td>
	</tr>
</table>
<br/>
<strong><u>ผู้ไปกับรถยนต์</u></strong>
	<ol>
		<c:forEach items="${PASSENGERNAMES}" var="passenger">
			<li>${passenger}</li>
		</c:forEach>
			
	</ol>

<p>หมายเหตุ : ${REMARK} </p>


<br/>
<input type="button" name="btnPrint" value="พิมพ์แบบขอใช้รถยนต์" onclick="window.open('<c:url value='/spring/pdfFrmHrVehicleReqForm'/>?id=${FRM_ID}', '_blank')"/>
<input type="button" name="btnBack" value="ย้อนกลับ" onclick="document.location='index.jsp?<%=LutGlobalRequestName.TASK_CODE%>=<%=taskCode.VIEW_MISC_FORM%>';"/>



