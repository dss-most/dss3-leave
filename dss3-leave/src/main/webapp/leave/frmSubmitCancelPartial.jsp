<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>
<%@page import="java.util.*"%>
<%@page import="gitex.html.*"%>
<%@page import="gitex.tu.*"%>
<%@page import="gitex.tu.htmlForm.*"%>
<%
gitex.utility.Date date = new gitex.utility.Date();   
LeaveReqHtmlPage thisPage = new LeaveReqHtmlPage(session, request);
LutLeaveReqTaskCode taskCode = new LutLeaveReqTaskCode();   
FrmLeaveReq reqForm = (FrmLeaveReq) session.getAttribute(LutGlobalSessionName.FORM);
FrmLeaveReq tempForm = new FrmLeaveReq(reqForm.getValue(reqForm.ELM_NAME_REF_TAKE_LEAVE_ID));   
FrmSubmitCancelPartial thisForm = new FrmSubmitCancelPartial(reqForm);
%>
<h3>
ประเภทคำร้อง : <span class="lblLeaveName"><%=tempForm.getFormName()%></span><br/>
สถานะ : <span class="lblLeaveName"><%=tempForm.getStatusName(tempForm.getValue(tempForm.ELM_NAME_STATUS))%></span><br/>
</h3>
<p class="block blue">
วันที่เริ่มต้นการลา <%=((Hashtable)date.getDate(tempForm.getValue(tempForm.ELM_NAME_LEAVE_START_DATE), date.MONTH_NAME_FULL)).get(date.DATE_THAI).toString()%> <%=tempForm.getPeriodName(tempForm.getValue(tempForm.ELM_NAME_LEAVE_START_DATE_PERIOD))%><br>
วันที่สิ้นสุดการลา <%=((Hashtable)date.getDate(tempForm.getValue(tempForm.ELM_NAME_LEAVE_END_DATE), date.MONTH_NAME_FULL)).get(date.DATE_THAI).toString()%> <%=tempForm.getPeriodName(tempForm.getValue(tempForm.ELM_NAME_LEAVE_END_DATE_PERIOD))%><br>
รวมระยะเวลาทั้งสิ้น <%=tempForm.getValue(tempForm.ELM_NAME_LEAVE_DAY_COUNT_MASTER)%> วัน<br>
</p>
<p class="block center">
    <%if(thisForm.isSuccess){%>
        ใบขอยกเลิกวันลาได้ถูกส่งไปยังผู้พิจาณาคำร้องเรียบร้อยแล้ว
        <p class="center"><input type="button" value="แสดงรายละเอียดเพื่อพิมพ์คำร้อง" onclick="document.location='index.jsp?<%=LutGlobalRequestName.MENU_CODE%>=<%=LutLeaveReqMenuCode.CHECK_REQ_STATUS%>&<%=LutGlobalRequestName.TASK_CODE%>=<%=LutLeaveReqTaskCode.CHECK_REQ_STATUS_2%>&<%=FrmLeaveStatusDtl.ELM_NAME_TAKE_LEAVE_ID%>=<%=reqForm.getValue(reqForm.ELM_NAME_TAKE_LEAVE_ID)%>';"/></p>
    <%}else{%>
        <span style="color:red;">มีข้อผิดพลาดในการทำงาน กรุณาลองอีกครั้ง</span>
        <p class="center"><input type="button" value="   OK   " onclick="document.location='index.jsp?<%=LutGlobalRequestName.TASK_CODE%>=<%=taskCode.CHECK_REQ_STATUS_1%>';"/></p>
    <%}%>
</p>
