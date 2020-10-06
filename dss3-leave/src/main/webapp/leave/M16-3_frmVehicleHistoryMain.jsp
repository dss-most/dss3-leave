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
FrmVehicleHistory thisForm = new FrmVehicleHistory(session, request);
if(thisForm.getValue(thisForm.ELM_NAME_BUDGET_YEAR).equals("")){
    thisForm.setInfo(employee.empId, budgetYear);
}else{
    budgetYear = Integer.parseInt(thisForm.getValue(thisForm.ELM_NAME_BUDGET_YEAR));
}
%>
<div>
<p style="padding-left:10px;">
	<a class="mainlink" href="index.jsp?taskCode=M16-4">แบบฟอร์มขอใช้รถยนตร์ไปราชการในแขตกรุงเทพและปริมณฑล</a>
</p>
</div>
<div>
<form name="searchFrm" action="index.jsp" method="post">
 <h3>แสดงประวัติการขอใช้รถในปีงบประมาณ
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
<td class="tblHeader" width="25%">วันที่ขอใช้รถ</td>
<td class="tblHeader" width="30%">สถานที่ไป</td>
<td class="tblHeader" width="25%">ราชการที่ไปปฏิบัติ</td>
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
<td class="tblRow<%=i%2%>"><%=vehiclerequestdate%> <br/> <%=vehiclestarttime%>น. - <%=vehicleendtime%>น.</td>
<td class="tblRow<%=i%2%>"><%=placetogo%></td>
<td class="tblRow<%=i%2%>"><%=reasontogo%></td>
</tr>
<%}%>
</table>
<p class="block">
<strong>คำแนะนำ : </strong>คลิกที่ประเภทคำร้องเพื่อดูรายละเอียด และ ดำเนินการอื่นๆ ต่อไป
<br>
<strong>หมายเหตุ : </strong>* หมายถึง ลาเกินสิทธิ์ ต้องดำเนินการหักเงินเดือน หรือขออนุมัติการจ่ายเงินเดือน
</p>
<%}else{%>
<p class="block center">ไม่พบการขอใช้รถ</p>
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