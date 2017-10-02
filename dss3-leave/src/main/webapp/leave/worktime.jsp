<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>
<%@page import="gitex.html.*"%>
<%@page import="gitex.tu.*"%>
<%@page import="gitex.tu.htmlForm.*"%>
<%@page import="gitex.utility.*"%>

<%@page import="java.util.*" %>
<%@page import="java.util.Date" %>

<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<fmt:setLocale value="th_TH"/>


<% 

LeaveReqHtmlPage thisPage = new LeaveReqHtmlPage(session, request);
Employee employee = thisPage.getUser().employee;
//LutLeaveReqTaskCode taskCode = new LutLeaveReqTaskCode();   
gitex.utility.Date date = new gitex.utility.Date();
FrmLeaveWorkTime thisForm = new FrmLeaveWorkTime(session, request);

//if(thisForm.getValue(thisForm.ELM_NAME_EMP_ID).equals("") && thisForm.getValue(thisForm.START_DATE).equals("") && thisForm.getValue(thisForm.END_DATE).equals("")){
	if(thisForm.getValue(thisForm.ELM_NAME_EMP_ID).equals("") ){
 thisForm.setFrmLeaveWorkTime(employee.empId, thisForm.getValue(thisForm.START_DATE),thisForm.getValue(thisForm.END_DATE) );
}
	
	
%>


<h3 class="left">ตรวจสอบเวลาปฏิบัติงาน</h3>
<form class="right" style="width:50%;" name="WorkTime" action="index.jsp" method="post">
ตั้งแต่วันที่ : <input type="text" id="txtLeaveBegin" name="txtLeaveSD" style="position:relative;" value=" " > <br>
ถึงวันที่ : <input type="text" id="txtLeaveEnd" name="txtLeaveSD"  style="position:relative;" value=" " >
<br><br>

<input type="hidden" id="<%=thisForm.START_DATE%>" name="<%=thisForm.START_DATE%>" value="<%=thisForm.getValue(thisForm.START_DATE)%>"/>
<input type="hidden" id="<%=thisForm.END_DATE%>" name="<%=thisForm.END_DATE%>" value="<%=thisForm.getValue(thisForm.END_DATE)%>"/>

<input type="submit" name="btnReset" value="  ค้นหา  " tabindex="4">
&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<br>
<input type="hidden" name="<%=thisForm.ELM_NAME_EMP_ID %> " value="<%=employee.empId %>">







</form> 




<%

//String ELM_NAME_EMP_ID="";
if(thisForm.formList.size() > 0){
	%>
	<table width="100%">
	<tr>
	<td class="tblHeader center" width="20%">วันที่</td>
	<td class="tblHeader center" width="15%">เวลามา</td>
	<td class="tblHeader center" width="15%">เวลากลับ</td>
	<td class="tblHeader center" width="50%">หมายเหตุ</td>

	</tr>
	<%
		for(int i = 0; i < thisForm.formList.size(); i++){
			
			Hashtable h = (Hashtable) thisForm.formList.get(i);
			
			Object workDate =  h.get(thisForm.WORK_DATE) ;
			Date d = (Date) workDate;
			String endDate = h.get(thisForm.END_DATE).toString();
			String startDate = h.get(thisForm.START_DATE).toString();
			String holidayRemark = h.get(thisForm.HOLIDAY_REMARK).toString();

			 %>
		<tr>
		<td class="tblRow<%=i%2%>"> <fmt:formatDate value="<%=d %>" pattern="EEE"/> <fmt:formatDate value="<%=d %>"/>  </td>
		<td class="tblRow<%=i%2%>"><%=startDate %></td>
		<td class="tblRow<%=i%2%>"><%=endDate %></td>
		<td class="tblRow<%=i%2%>"><%=holidayRemark %></td>
		</tr>
		<%
		}

		//out.println("test "+thisForm.formList.size());
	}else{
	  out.println("<p class='block center'>ไม่พบวัน เวลา ปฏิบัติงาน</p>");
}

%>
</table>

<script type="text/javascript">
<!--

$(document).ready(function() {

	$.datepicker.setDefaults($.datepicker.regional['th']);
	
	$('#txtLeaveBegin').datepicker({
		isBE: true,
        autoConversionField: true,
        showButtonPanel: true,
        dateFormat: "dd MM yy",
        changeMonth: true,
        changeYear: true,
        altField: "#in_time",
        altFormat: "yymmdd"
	});
	
	$('#txtLeaveEnd').datepicker({
		isBE: true,
        autoConversionField: true,
        showButtonPanel: true,
        dateFormat: "dd MM yy",
        changeMonth: true,
        changeYear: true,
        altField: "#out_time",
        altFormat: "yymmdd"
	});
	
});

//-->
</script>

<jsp:include page="includes/calendar.jsp"></jsp:include>