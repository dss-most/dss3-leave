<%@page contentType="text/html"%>
<%@page pageEncoding="TIS-620"%>
<%@page import="java.util.*"%>
<%@page import="gitex.tu.htmlForm.*"%>
<%@page import="gitex.tu.*"%>
<%@page import="gitex.html.*"%>
<%
FrmSubmitReq thisForm = new FrmSubmitReq(session, request);   
FrmLeaveReq reqForm = (FrmLeaveReq) session.getAttribute(LutGlobalSessionName.FORM);
%>   
<h3>
����������� : <span class="lblLeaveName"><%=reqForm.getFormName()%></span> 
</h3>
<p class="block center">
    <%if(thisForm.isSuccess){%>
        ����ͧ��١����ѧ���Ԩ�ó����º��������
        <p class="center"><input type="button" value="�ʴ���������´���;�������ͧ" onclick="document.location='index.jsp?<%=LutGlobalRequestName.MENU_CODE%>=<%=LutLeaveReqMenuCode.CHECK_REQ_STATUS%>&<%=LutGlobalRequestName.TASK_CODE%>=<%=LutLeaveReqTaskCode.CHECK_REQ_STATUS_2%>&<%=FrmLeaveStatusDtl.ELM_NAME_TAKE_LEAVE_ID%>=<%=reqForm.getValue(reqForm.ELM_NAME_TAKE_LEAVE_ID)%>';"/></p>
    <%}else{%>
        <span style="color:red;">�բ�ͼԴ��Ҵ㹤���ͧ ��سҵ�Ǩ�ͺ�ա����</span>
        <p class="center"><input type="button" value="   OK   " onclick="document.location='index.jsp?<%=LutGlobalRequestName.TASK_CODE%>=<%=thisForm.getValue(thisForm.ELM_NAME_CALLBACK_TASKCODE_ON_FAIL)%>';"/></p>
    <%}%>
</p>
