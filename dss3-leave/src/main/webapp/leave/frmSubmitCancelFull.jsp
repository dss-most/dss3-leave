<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>
<%@page import="java.util.*"%>
<%@page import="gitex.html.*"%>
<%@page import="gitex.tu.*"%>
<%@page import="gitex.tu.htmlForm.*"%>
<%
LeaveReqHtmlPage thisPage = new LeaveReqHtmlPage(session, request);
LutLeaveReqTaskCode taskCode = new LutLeaveReqTaskCode();   
FrmLeaveReq reqForm = (FrmLeaveReq) session.getAttribute(LutGlobalSessionName.FORM);
FrmSubmitCancelFull thisForm = new FrmSubmitCancelFull(request);
%>
<h3>
ประเภทการลาที่ต้องการยกเลิก : <span class="lblLeaveName"><%=reqForm.getFormName()%></span><br/>
สถานะการลา : <span class="lblLeaveName"><%=reqForm.getStatusName(reqForm.getValue(reqForm.ELM_NAME_STATUS))%></span><br/>
</h3>
<p class="block center">
    <%if(thisForm.isSuccess){%>
        การยกเลิกการลาได้ถูกดำเนินการเรียบร้อยแล้ว
        <p class="center"><input type="button" value="   OK   " onclick="document.location='index.jsp?<%=LutGlobalRequestName.TASK_CODE%>=<%=taskCode.CHECK_REQ_STATUS_1%>';"/></p>
    <%}else{%>
        <span style="color:red;">มีข้อผิดพลาดในการทำงาน กรุณาลองอีกครั้ง</span>
        <p class="center"><input type="button" value="   OK   " onclick="document.location='index.jsp?<%=LutGlobalRequestName.TASK_CODE%>=<%=taskCode.CHECK_REQ_STATUS_1%>';"/></p>
    <%}%>
</p>
