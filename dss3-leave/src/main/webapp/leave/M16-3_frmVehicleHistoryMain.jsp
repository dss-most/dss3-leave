<%@page contentType="text/html"%>
<%@page pageEncoding="TIS-620"%>
<%@page import="java.util.*"%>
<%@page import="gitex.html.*"%>
<%@page import="gitex.tu.*"%>
<%@page import="gitex.tu.htmlForm.*"%>
<%@page import="gitex.utility.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
LeaveReqHtmlPage thisPage = new LeaveReqHtmlPage(session, request);
Employee employee = thisPage.getUser().employee;
gitex.utility.Date date = new gitex.utility.Date();
int budgetYear = date.getCurrentBudgetYear();
FrmVehicleHistory thisForm = new FrmVehicleHistory(session, request);
if(thisForm.getValue(thisForm.ELM_NAME_BUDGET_YEAR).equals("")){
    thisForm.setInfo(employee.empId, budgetYear);
}else{
    budgetYear = Integer.parseInt(thisForm.getValue(thisForm.ELM_NAME_BUDGET_YEAR));
}
%>
<div>
<p style="padding-left:10px;">
	<a class="mainlink" href="index.jsp?taskCode=M16-4">Ẻ���������ö¹�����Ҫ����ᢵ��ا෾��л������</a>
</p>
</div>
<div>
<form name="searchFrm" action="index.jsp" method="post">
 <h3>�ʴ�����ѵԡ�â���ö㹻է�����ҳ
    <input type="text" name="input1" style="width:50px;" value="<%=Integer.parseInt(thisForm.getValue(thisForm.ELM_NAME_BUDGET_YEAR)) + 543%>"/>
    <input type="hidden" name="<%=thisForm.ELM_NAME_BUDGET_YEAR%>" value=""/>
    <input type="hidden" name="<%=thisForm.ELM_NAME_EMP_ID%>" value="<%=employee.empId%>"/>
    <input type="submit" name="btnSubmit" value="��ŧ" onclick="return isValidInput();"/> </h3>
</form>
</div> 
<%if(thisForm.formList.size() > 0){%>
<p>
<table width="100%">
<tr>
<td class="tblHeader" width="20%">�ѹ������¡��</td>
<td class="tblHeader" width="25%">�ѹ������ö</td>
<td class="tblHeader" width="30%">ʶҹ����</td>
<td class="tblHeader" width="25%">�Ҫ��÷��任�Ժѵ�</td>
</tr>
<%for(int i = 0; i < thisForm.formList.size(); i++){
	Hashtable row = (Hashtable)thisForm.formList.get(i);
	
    String formissuedate = gitex.utility.Date.thaiShortDateStr(row.get(FrmVehicleReq.ELM_NAME_FORM_ISSUE_DATE).toString());
  	String vehiclerequestdate = gitex.utility.Date.thaiShortDateStr(row.get(FrmVehicleReq.ELM_NAME_VEHICLE_REQ_DATE).toString());
  	String vehiclestarttime = row.get(FrmVehicleReq.ELM_NAME_VEHICLE_START_TIME).toString();
  	String vehicleendtime = row.get(FrmVehicleReq.ELM_NAME_VEHICLE_END_TIME).toString();
  	String placetogo = row.get(FrmVehicleReq.ELM_NAME_PLACE_TO_GO).toString();
  	String reasontogo = row.get(FrmVehicleReq.ELM_NAME_REASON_TO_GO).toString();
    String remark = row.get(FrmVehicleReq.ELM_NAME_REMARK).toString();
    
%>
<tr>
<td class="tblRow<%=i%2%>"><a href="<c:url value='/spring/viewFrmHrVehicleReqForm'/>?id=<%=row.get(FrmVehicleReq.ELM_NAME_ID).toString()%>"><%=formissuedate%></a></td>
<td class="tblRow<%=i%2%>"><%=vehiclerequestdate%> <br/> <%=vehiclestarttime%>�. - <%=vehicleendtime%>�.</td>
<td class="tblRow<%=i%2%>"><%=placetogo%></td>
<td class="tblRow<%=i%2%>"><%=reasontogo%></td>
</tr>
<%}%>
</table>
<p class="block">
<strong>���й� : </strong>��ԡ������������ͧ���ʹ���������´ ��� ���Թ������� ����
<br>
<strong>�����˵� : </strong>* ���¶֧ ���Թ�Է��� ��ͧ���Թ����ѡ�Թ��͹ ���͢�͹��ѵԡ�è����Թ��͹
</p>
<%}else{%>
<p class="block center">��辺��â���ö</p>
<%}%>
</p>
   
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