<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>
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
FrmVehicleOvernight thisForm = new FrmVehicleOvernight(session, request);
if(thisForm.getValue(thisForm.ELM_NAME_BUDGET_YEAR).equals("")){
    thisForm.setInfo(employee.empId, budgetYear);
}else{
    budgetYear = Integer.parseInt(thisForm.getValue(thisForm.ELM_NAME_BUDGET_YEAR));
}
%>
<div>
<p style="padding-left:10px;">
	<a class="mainlink" href="index.jsp?taskCode=M16-8">แบบฟอร์มขออนุญาตนำรถยนต์มาจอดค้างคืนในกรมวิทยาศาสตร์บริการ</a>
</p>
</div>
<div>
<form name="searchFrm" action="index.jsp" method="post">
 <h3>แสดงประวัติการขออนุญาตนำรถยนต์์มาจอดค้างคืนในปีงบประมาณ
    <input type="text" name="input1" style="width:50px;" value="<%=Integer.parseInt(thisForm.getValue(thisForm.ELM_NAME_BUDGET_YEAR)) + 543%>"/>
    <input type="hidden" name="<%=thisForm.ELM_NAME_BUDGET_YEAR%>" value=""/>
    <input type="hidden" name="<%=thisForm.ELM_NAME_EMP_ID%>" value="<%=employee.empId%>"/>
    <input type="submit" name="btnSubmit" value="ตกลง" onclick="return isValidInput();"/> </h3>
</form>
</div> 
<%if(thisForm.formList.size() > 0){%>
<p>
<table width="100%">
<tr>
<td class="tblHeader" width="20%">วันที่ทำรายการ</td>
<td class="tblHeader" width="25%">วันที่ขออนุญาต</td>
<td class="tblHeader" width="25%">ทะเบียนรถยนต์</td>
<td class="tblHeader" width="25%">เหตุผล</td>
</tr>
<%for(int i = 0; i < thisForm.formList.size(); i++){
	Hashtable row = (Hashtable)thisForm.formList.get(i);
	
    String formissuedate = gitex.utility.Date.thaiShortDateStr(row.get(FrmVehicleOvernightReq.ELM_NAME_FORM_ISSUE_DATE).toString());
  	String start_overnight = gitex.utility.Date.thaiShortDateStr(row.get(FrmVehicleOvernightReq.ELM_NAME_START_OVERNIGHT).toString());
  	String end_overnight = gitex.utility.Date.thaiShortDateStr(row.get(FrmVehicleOvernightReq.ELM_NAME_END_OVERNIGHT).toString());
  	
  	String reason = row.get(FrmVehicleOvernightReq.ELM_NAME_REASON).toString();
    String license_number = row.get(FrmVehicleOvernightReq.ELM_NAME_LICENSE_NUMBER).toString();
    String license_province = row.get(FrmVehicleOvernightReq.ELM_NAME_LICENSE_PROVINCE).toString();
    
%>
<tr>
<td class="tblRow<%=i%2%>"><a href="<c:url value='/spring/viewFrmHrVehicleOvernightReqForm'/>?id=<%=row.get(FrmVehicleOvernightReq.ELM_NAME_ID).toString()%>"><%=formissuedate%></a></td>
<td class="tblRow<%=i%2%>"><%=start_overnight%> - <%=end_overnight%></td>
<td class="tblRow<%=i%2%>"><%=license_number%> <%=license_province%> </td>
<td class="tblRow<%=i%2%>"><%=reason%></td>
</tr>
<%}%>
</table>

<%}else{%>
<p class="block center">ไม่พบการขออนุญาตจอดรถค้างคืนในปีงบประมาณนี้</p>
<%}%>
</p>
   
<script>
    function isValidInput(){
        var input = document.searchFrm.input1.value;
        if(isNaN(input) || input == ""){
            alert("กรุณาใส่ปีงบประมาณให้ถูกต้อง");
            document.searchFrm.input1.value = "";
            document.searchFrm.input1.focus();
            return false;
        }else{
            document.searchFrm.<%=thisForm.ELM_NAME_BUDGET_YEAR%>.value = parseFloat(input) - 543;
            return true;
        }
    }
</script>    