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
FrmSubmitCancelFull thisForm = new FrmSubmitCancelFull(request);
%>
<h3>
����������ҷ���ͧ���¡��ԡ : <span class="lblLeaveName"><%=reqForm.getFormName()%></span><br/>
ʶҹС���� : <span class="lblLeaveName"><%=reqForm.getStatusName(reqForm.getValue(reqForm.ELM_NAME_STATUS))%></span><br/>
</h3>
<p class="block center">
    <%if(thisForm.isSuccess){%>
        ���¡��ԡ�������١���Թ������º��������
        <p class="center"><input type="button" value="   OK   " onclick="document.location='index.jsp?<%=LutGlobalRequestName.TASK_CODE%>=<%=taskCode.CHECK_REQ_STATUS_1%>';"/></p>
    <%}else{%>
        <span style="color:red;">�բ�ͼԴ��Ҵ㹡�÷ӧҹ ��س��ͧ�ա����</span>
        <p class="center"><input type="button" value="   OK   " onclick="document.location='index.jsp?<%=LutGlobalRequestName.TASK_CODE%>=<%=taskCode.CHECK_REQ_STATUS_1%>';"/></p>
    <%}%>
</p>
