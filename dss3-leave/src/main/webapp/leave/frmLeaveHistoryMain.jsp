<%@page contentType="text/html"%>
<%@page pageEncoding="TIS-620"%>
<%@page import="java.util.*"%>
<%@page import="gitex.html.*"%>
<%@page import="gitex.tu.*"%>
<%@page import="gitex.tu.htmlForm.*"%>
<%@page import="gitex.utility.*"%>
<%
LeaveReqHtmlPage thisPage = new LeaveReqHtmlPage(session, request);
Employee employee = thisPage.getUser().employee;
gitex.utility.Date date = new gitex.utility.Date();
int budgetYear = date.getCurrentBudgetYear();
FrmLeaveHistory thisForm = new FrmLeaveHistory(session, request);
if(thisForm.getValue(thisForm.ELM_NAME_BUDGET_YEAR).equals("")) thisForm.setLeaveHistory(employee.empId, budgetYear);
FrmLeaveReq reqForm = new FrmLeaveReq();
%>
<h3>����ѵԡ����㹻է�����ҳ <%=Integer.parseInt(thisForm.getValue(thisForm.ELM_NAME_BUDGET_YEAR)) + 543%></h3>
<%if(thisForm.formList.size() > 0){%>
<p>
<table width="100%">
<tr>
<td class="tblHeader" width="50%">�����������/����ͧ</td>
<td class="tblHeader" width="30%">�����ҧ�ѹ���</td>
<td class="tblHeader" width="20%">���(�ѹ)</td>
</tr>
<%for(int i = 0; i < thisForm.formList.size(); i++){
    String takeLeaveId = ((Hashtable)thisForm.formList.get(i)).get(thisForm.TAKE_LEAVE_ID).toString();
    String formTypeId = ((Hashtable)thisForm.formList.get(i)).get(thisForm.LEAVE_FORM_TYPE).toString();
    String formTypeName = reqForm.getFormName(((Hashtable)thisForm.formList.get(i)).get(thisForm.LEAVE_FORM_TYPE).toString());
    String startDate = date.getDate(((Hashtable)thisForm.formList.get(i)).get(thisForm.FORM_START_DATE).toString(), date.MONTH_NAME_SHORT).get(date.DATE_THAI).toString();
    String endDate = date.getDate(((Hashtable)thisForm.formList.get(i)).get(thisForm.FORM_END_DATE).toString(), date.MONTH_NAME_SHORT).get(date.DATE_THAI).toString();
    String numOfLeaveDay = ((Hashtable)thisForm.formList.get(i)).get(thisForm.NUM_OF_LEAVE_DAY).toString();
    String refTakeLeaveId = ((Hashtable)thisForm.formList.get(i)).get(thisForm.REF_TAKELEAVE_ID).toString();
    String remark = "";
    if(!refTakeLeaveId.equals("")){
        if(formTypeId.equals(reqForm.FORM_TYPE_VACATION) || formTypeId.equals(reqForm.FORM_TYPE_PRIVATE)){
            remark = "(仵�ҧ�����)";
        }
    } else if(refTakeLeaveId.equals("15")) {
    	remark = reqForm.getValue(reqForm.ELM_NAME_CONTACT_DETAIL).toString();
    }
%>
<tr>
<td class="tblRow<%=i%2%>"><a href="index.jsp?<%=LutGlobalRequestName.TASK_CODE%>=<%=LutLeaveReqTaskCode.CHECK_REQ_STATUS_2%>&<%=FrmLeaveStatusDtl.ELM_NAME_TAKE_LEAVE_ID%>=<%=takeLeaveId%>"><%=formTypeName + remark%></a></td>
<td class="tblRow<%=i%2%>"><%=startDate%> - <%=endDate%></td>
<td class="tblRow<%=i%2%>"><%=numOfLeaveDay%></td>
</tr>
<%}%>
</table>
<p class="block">
<strong>���й� : </strong>��ԡ������������ͧ���ʹ���������´ ��� ���Թ������� ����
<br>
<strong>�����˵� : </strong>* ���¶֧ ���Թ�Է��� ��ͧ���Թ����ѡ�Թ��͹ ���͢�͹��ѵԡ�è����Թ��͹
</p>
<%}else{%>
<p class="block center">��辺�����</p>
<%}%>
</p>
<form name="searchFrm" action="index.jsp" method="post">
    �ʴ�����ѵԡ��㹻է�����ҳ
    <input type="text" name="input1" style="width:50px;" value="<%=Integer.parseInt(thisForm.getValue(thisForm.ELM_NAME_BUDGET_YEAR)) + 543%>"/>
    <input type="hidden" name="<%=thisForm.ELM_NAME_BUDGET_YEAR%>" value=""/>
    <input type="hidden" name="<%=thisForm.ELM_NAME_EMP_ID%>" value="<%=employee.empId%>"/>
    <input type="submit" name="btnSubmit" value="��ŧ" onclick="return isValidInput();"/>
</form>    
<script>
    function isValidInput(){
        var input = document.searchFrm.input1.value;
        if(isNaN(input) || input == ""){
            alert("��س����է�����ҳ���١��ͧ");
            document.searchFrm.input1.value = "";
            document.searchFrm.input1.focus();
            return false;
        }else{
            document.searchFrm.<%=thisForm.ELM_NAME_BUDGET_YEAR%>.value = parseFloat(input) - 543;
            return true;
        }
    }
</script>    