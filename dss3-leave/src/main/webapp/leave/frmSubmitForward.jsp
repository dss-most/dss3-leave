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
FrmSubmitForward thisForm = new FrmSubmitForward(request, thisPage.getUser());
%>
<h3>
เปลี่ยนผู้พิจารณาคำร้อง : <span class="lblLeaveName"><%=reqForm.getFormName()%></span><br/>
</h3>
<p class="block center">
    <%if(thisForm.isSuccess){%>
        คำสั่งได้ถูกดำเนินการเรียบร้อยแล้ว
    <%}else{%>
        <span style="color:red;">มีข้อผิดพลาดในการทำงาน กรุณาสั่งอีกครั้ง</span>
    <%}%>
    <p class="center"><input type="button" value="   OK   " onclick="document.location='index.jsp?<%=LutGlobalRequestName.TASK_CODE%>=<%=taskCode.MANAGE_LEAVE_1%>';"/></p>
</p>
