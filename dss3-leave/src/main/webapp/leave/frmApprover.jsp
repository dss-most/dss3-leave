<%@page contentType="text/html"%>
<%@page pageEncoding="TIS-620"%>
<%@page import="java.util.*"%>
<%@page import="gitex.tu.htmlForm.*"%>
<%@page import="gitex.tu.*"%>
<%@page import="gitex.html.*"%>
<%
LeaveReqHtmlPage thisPage = new LeaveReqHtmlPage(session, request);
FrmApprover thisForm = new FrmApprover(request, thisPage.getUser().employee.empId);   
LutLeaveReqTaskCode taskCode = new LutLeaveReqTaskCode();
FrmLeaveReq reqForm = (FrmLeaveReq) session.getAttribute(LutGlobalSessionName.FORM);
%>   
<h3>
����������� : <span class="lblLeaveName"><%=reqForm.getFormName()%></span> 
</h3>
<h3>��ª��ͼ������ö�Ԩ�óҤ���ͧ</h3>
<form name="frmSearch" class="center" action="index.jsp" method="post">
<input type="hidden" name="<%=LutGlobalRequestName.TASK_CODE%>" value="<%=thisPage.getTaskCode()%>"/>
<input type="hidden" name="<%=thisForm.ELM_NAME_CALLER_TASK_CODE%>" value="<%=thisForm.getValue(thisForm.ELM_NAME_CALLER_TASK_CODE)%>"/>
���� : <input type="text" name="<%=thisForm.ELM_NAME_SEARCH_FNAME%>" value="<%=thisForm.getValue(thisForm.ELM_NAME_SEARCH_FNAME)%>"> <!--���ʡ�� : <input type="text" name="searchLName">--> <input type="submit" name="btnSubmit" value="����"/>
</form>
<%if(thisForm.searchResult.size() > 0){%>
<form class="center" action="index.jsp" method="post">
<input type="hidden" name="<%=LutGlobalRequestName.TASK_CODE%>" value="<%=taskCode.SUBMIT_REQ%>"/>
<input type="hidden" name="<%=FrmSubmitReq.ELM_NAME_CALLBACK_TASKCODE_ON_FAIL%>" value="<%=thisForm.getValue(thisForm.ELM_NAME_CALLER_TASK_CODE)%>"/>
<input type="hidden" name="<%=thisForm.ELM_NAME_SEARCH_FNAME%>" value="<%=thisForm.getValue(thisForm.ELM_NAME_SEARCH_FNAME)%>"/>
<!--input type="hidden" name="<%=thisForm.ELM_NAME_SEARCH_LNAME%>" value="<%=thisForm.getValue(thisForm.ELM_NAME_SEARCH_LNAME)%>"/-->
<table width="100%">
<tr>
<td class="tblHeader center" width="10%">���͡</td>
<td class="tblHeader left" width="40%">����-���ʡ��</td>
<td class="tblHeader left" width="25%">���˹�</td>
<td class="tblHeader left" width="25%">˹��§ҹ</td>
</tr>
<%for(int i = 0; i < thisForm.searchResult.size(); i++){
    Employee commander = (Employee)thisForm.searchResult.get(i);
    %>
    <tr>
    <td class="tblRow0 center"><input type="radio" name="<%=FrmSubmitReq.ELM_NAME_TO_EMP_ID%>" <%if(i == 0){%>checked<%}%> value="<%=commander.empId%>"></td>
    <td class="tblRow0 left"><%=commander.fullName%></td>
    <td class="tblRow0 left"><%=commander.workTitle%></td>
    <td class="tblRow0 left"><%=commander.topORGName%></td>
    </tr>
<%}%>
</table>
<input type="submit" name="btnSubmit" value="��㺢�͹حҵ��" onclick="if(confirm('��س��׹�ѹ�����㺢�͹حҵ��')) return true; else return false;"> 
<input type="button" name="btnBack" value="��͹��Ѻ" onclick="document.location='index.jsp?<%=LutGlobalRequestName.TASK_CODE%>=<%=thisForm.getValue(thisForm.ELM_NAME_CALLER_TASK_CODE)%>';">
</form>
<%}else{%>
    <p class="center">
        ��辺������ӹҨ㹡�þԨ�óҤ���ͧ
    </p>
<%}%>
<p class="block">
    <strong>���й� :</strong> ��ҵ�ͧ��ä��ҷ����� ������������ͧ�кت���
</p>
