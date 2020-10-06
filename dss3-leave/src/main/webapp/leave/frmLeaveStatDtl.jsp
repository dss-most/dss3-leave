<%@page contentType="text/html"%>
<%@page pageEncoding="TIS-620"%>
<%@page import="java.util.*"%>
<%@page import="gitex.tu.*"%>
<%@page import="gitex.tu.htmlForm.*"%>
<%@page import="gitex.utility.*"%>
<%
LeaveReqHtmlPage thisPage = new LeaveReqHtmlPage(session, request);
//Employee employee = thisPage.getUser().employee;

Employee employee = thisPage.getUser().employee;

//¡��ԡ���ͧ�ҡ����ա�����������
//Period per = new Period();
//per.setPeriod(Integer.parseInt(employee.empId),Integer.parseInt(request.getParameter("budgetYear")));



//out.println(employee.empId);   emp_id
gitex.utility.Date date = new gitex.utility.Date();
int budgetYear = date.getCurrentBudgetYear();

//out.println(request.getParameter("budgetYear"));   budgetYear

if(request.getParameter("budgetYear") != null){
    budgetYear = Integer.parseInt(request.getParameter("budgetYear"));
}


employee.getLeaveStat(budgetYear);
employee.getLeaveStat(employee.PERIOD_FIRST_HALF_YEAR, budgetYear);
employee.getLeaveStat(employee.PERIOD_SECOND_HALF_YEAR, budgetYear);
employee.getReqCount(employee.PERIOD_FIRST_HALF_YEAR, budgetYear);
employee.getReqCount(employee.PERIOD_SECOND_HALF_YEAR, budgetYear);
%>
<!-- 
<h3>ʶԵԡ���һ�㹻է�����ҳ <%=budgetYear + 543%></h3>
-->
<%if(employee.leaveCategoryId.size() > 0){%>
<p>
<table width="100%" cellspacing="1">
<tr>
<td class="tblHeader center" width="45%" rowspan="2">�����������</td>
<td class="tblHeader center" width="55%" colspan="3" style="padding-right:5px;">�ӹǹ�ѹ�����/�ӹǹ���駡����</td>
</tr>
<tr>
<td class="tblHeader center" width="20%" style="padding-right:5px;">�.�. - ��.�.</td>
<td class="tblHeader center" width="20%" style="padding-right:5px;">��.�. - �.�.</td>
<td class="tblHeader center" width="15%" style="padding-right:5px;">������</td>
</tr>
<%for(int i = 0; i < employee.leaveCategoryId.size(); i++){
    double numOfLeaveOn1stHalf = employee.getNumOfLeaveDay(employee.leaveCategoryId.get(i).toString(), employee.PERIOD_FIRST_HALF_YEAR);
    double numOfLeaveOn2ndHalf = employee.getNumOfLeaveDay(employee.leaveCategoryId.get(i).toString(), employee.PERIOD_SECOND_HALF_YEAR);
    double numOfReqOn1stHalf = employee.getNumOfRequest(employee.leaveCategoryId.get(i).toString(), employee.PERIOD_FIRST_HALF_YEAR);
    double numOfReqOn2ndHalf = employee.getNumOfRequest(employee.leaveCategoryId.get(i).toString(), employee.PERIOD_SECOND_HALF_YEAR);
    %>
    <tr>
    <td class="tblRow<%=i % 2%>"><%=employee.getLeaveCategoryName(employee.leaveCategoryId.get(i).toString())%><%if(employee.isLeaveOutOfLimit(employee.leaveCategoryId.get(i).toString())){%>*<%}%></td>
    <td class="tblRow<%=i % 2%> center" style="padding-right:5px;"><%=numOfLeaveOn1stHalf + "/" + numOfReqOn1stHalf%></td>
    <td class="tblRow<%=i % 2%> center" style="padding-right:5px;"><%=numOfLeaveOn2ndHalf + "/" + numOfReqOn2ndHalf%></td>
    <td class="tblRow<%=i % 2%> center" style="padding-right:5px;"><%=(numOfLeaveOn1stHalf + numOfLeaveOn2ndHalf) + "/" + (numOfReqOn1stHalf + numOfReqOn2ndHalf)%></td>
    </tr>
<%}%>
</table>
<!-- ¡��ԡ����ʴ��Ţ����š������� -->
<!-- 
<%//if(employee.labsTypeList.size() > 0){%>
    <h3>ʶԵԡ������� </h3>
    <h4>����������ش � �ѹ��� 30 �Զع�¹ 2563</h4>
    <p>
    <table width="100%">
    <tr>
    <td class="tblHeader" width="45%">��¡��</td>
    <td class="tblHeader" width="20%" style="padding-right:5px;"><div align="center">&#3605;.&#3588;. - &#3617;&#3637;.&#3588;.</div></td>
    <td class="tblHeader" width="18%" style="padding-right:5px;"><div align="center">&#3648;&#3617;.&#3618;. - &#3585;.&#3618;.</div></td>
    <td class="tblHeader center" width="17%" style="padding-right:5px;">�ӹǹ�ѹ</td>
    </tr>
    <%
    //FrmLateAbsent labsForm = new FrmLateAbsent();
    //for(int i = 0; i < employee.labsTypeList.size(); i++){%>
    <tr>
    <td class="tblRow<%//=i % 2%>"><%//=labsForm.getTypeName(employee.labsTypeList.get(i).toString())%></td>
    <td class="tblRow<%//=i % 2%>"><div align="center"><%//=per.per1%></div></td>
    <td class="tblRow<%//=i % 2%>"><div align="center"><%//=per.per2%></div></td>
    <td class="tblRow<%//=i % 2%> center"><%//=Integer.parseInt(per.per1)+Integer.parseInt(per.per2)%><%//=employee.getNumOfLabs(employee.labsTypeList.get(i).toString())%></td>
    </tr>
    <%//}%>
    </table>
<%//}%>
-->

</p>
<p class="block"><strong>�����˵� 1 : </strong>* ���¶֧ ���Թ�Է���</p>
<p class="block">
<strong>�����˵� 2 : </strong>
������ա������͹����Թ��͹ ���<strong>�һ�������Ѻ�ҡԨ</strong>��ͺ 6 ��͹�á������ѧ �ըӹǹ��â����Թ 11 ���� ���� �ӹǹ�ѹ���Թ 23 �ѹ 
<!-- ���<strong>���������Թ 15 �ѹ</strong>-->
</p>
<%}else{%>
<p class="block center">����ա����㹻է�����ҳ���</p>
<%}%>
