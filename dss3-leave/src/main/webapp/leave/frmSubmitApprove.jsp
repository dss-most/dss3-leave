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
����ͧ : <span class="lblLeaveName"><%=reqForm.getFormName()%></span><br/>
���� : <span class="lblLeaveName"><%=reqForm.getSendPurpose()%></span><br/>
��繤�� : <span class="lblLeaveName"><%=thisForm.getApproveName(thisForm.getValue(thisForm.ELM_NAME_APPROVE_VALUE))%></span><br/>
</h3>
<p class="block center">
    <%if(thisForm.isSuccess){%>
        �������١���Թ������º��������
        <p class="center"><input type="button" value="   OK   " onclick="document.location='index.jsp?<%=LutGlobalRequestName.TASK_CODE%>=<%=taskCode.VIEW_WAITING_APPROVE_REQ_1%>';"/></p>
    <%}else{%>
        <span style="color:red;">�բ�ͼԴ��Ҵ㹡�÷ӧҹ ��س�����ա����</span>
        <p class="center"><input type="button" value="   OK   " onclick="document.location='index.jsp?<%=LutGlobalRequestName.TASK_CODE%>=<%=taskCode.VIEW_WAITING_APPROVE_REQ_1%>';"/></p>
    <%}%>
</p>
