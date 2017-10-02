<%@page contentType="text/html"%>
<%@page pageEncoding="TIS-620"%>
<%@page import="java.util.*"%>
<%@page import="gitex.html.*"%>
<%@page import="gitex.tu.*"%>
<%@page import="gitex.tu.htmlForm.*"%>
<%
LeaveReqHtmlPage thisPage = new LeaveReqHtmlPage(session, request);
LutLeaveReqTaskCode taskCode = new LutLeaveReqTaskCode();   
FrmLeaveReq reqForm = (FrmLeaveReq) session.getAttribute(LutGlobalSessionName.FORM);
FrmSubmitApprove thisForm = new FrmSubmitApprove(request, reqForm, thisPage.getUser());
%>
<h3>
คำร้อง : <span class="lblLeaveName"><%=reqForm.getFormName()%></span><br/>
เพื่อ : <span class="lblLeaveName"><%=reqForm.getSendPurpose()%></span><br/>
เห็นควร : <span class="lblLeaveName"><%=thisForm.getApproveName(thisForm.getValue(thisForm.ELM_NAME_APPROVE_VALUE))%></span><br/>
</h3>
<p class="block center">
    <%if(thisForm.isSuccess){%>
        คำสั่งได้ถูกดำเนินการเรียบร้อยแล้ว
        <p class="center"><input type="button" value="   OK   " onclick="document.location='index.jsp?<%=LutGlobalRequestName.TASK_CODE%>=<%=taskCode.VIEW_WAITING_APPROVE_REQ_1%>';"/></p>
    <%}else{%>
        <span style="color:red;">มีข้อผิดพลาดในการทำงาน กรุณาสั่งอีกครั้ง</span>
        <p class="center"><input type="button" value="   OK   " onclick="document.location='index.jsp?<%=LutGlobalRequestName.TASK_CODE%>=<%=taskCode.VIEW_WAITING_APPROVE_REQ_1%>';"/></p>
    <%}%>
</p>
