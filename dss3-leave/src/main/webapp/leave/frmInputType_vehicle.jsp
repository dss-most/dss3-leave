<%@page contentType="text/html; charset=TIS-620"%>
<%@page pageEncoding="TIS-620"%>
<%@page import="gitex.html.*"%>
<%@page import="gitex.tu.*"%>
<%@page import="gitex.tu.htmlForm.*"%>
<%@page import="gitex.utility.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
LeaveReqHtmlPage thisPage = new LeaveReqHtmlPage(session, request);
Employee employee = thisPage.getUser().employee;
LutLeaveReqTaskCode taskCode = new LutLeaveReqTaskCode();
gitex.utility.Date date = new gitex.utility.Date();
int budgetYear = date.getCurrentBudgetYear();
%>

<p>
<form action="<c:url value='/spring/saveFrmVehicleInput'/>" name="frmVehicleInput" method="post"  onsubmit="return validateInput();" >
<input type="hidden" name="<%=LutGlobalRequestName.TASK_CODE%>" value="<%=LutLeaveReqTaskCode.VIEW_MISC_FORM_VEHICLE_CONFIRM%>"/>

<table class="frmVehicleInput">
<tr>
	<td class="first">*���¹  : </td>
	<td><input type="text" id="orgHead" name="orgHead" style="width:241px;"></input></td>
</tr>
<tr>
	<td class="first">*����ö�ѹ��� : </td>
	<td><input type="text" id="vehicleRequestDate" name="vehicleRequestDate" style="position:relative;" value="" >
	</td>
</tr>
<tr>
	<td class="first">*�����ҧ���� : </td>
	<td>  <input type="text" name="vehicleStartTime" id="vehicleStartTime" style="width:50px;"></input>�. �֧ <input type="text" name="vehicleEndTime" id="vehicleEndTime" style="width:50px;"></input> �. </td>
</tr>
<tr>
	<td class="first">*ʶҹ����  :</td>
	<td><textarea id="placeToGo" name="placeToGo" style="width:241px;height:85px;"></textarea></td>
</tr>
<tr>
	<td class="first">*�Ҫ��÷��任�Ժѵ�  : </td>
	<td><textarea id="reasonToGo" name="reasonToGo" style="width:241px;height:85px;"></textarea></td>
</tr>
<tr>
	<td class="first">���仡Ѻö¹��</td>
	<td> <input type="button" name="btnAddPassenger" value="������ª���"/ onclick="addPassenger()"></td>
</tr>
<tr>
	<td></td>
	<td>
		<ol id="passengerList">
		</ol>
	</td>
</tr>
<tr>
	<td class="first">�����˵�</td>
	<td><textarea name="remark" style="width:241px;height:50px;"></textarea></td>
</tr>
</table>

<input type="hidden" id="vehicleRequestDateStr" name="vehicleRequestDateStr"/>
<input type="hidden" id="passengerIds" name="passengerIds[]"/>
<input type="hidden" id="passengerNames" name="passengerNames[]"/>

<br/><br/>
<input type="submit" name="btnSubmit" value="��Ǩ�ͺ��������´" style="width:130px;"> 
<input type="reset" name="btnReset" value="���������">
<input type="button" name="btnBack" value="��͹��Ѻ" onclick="document.location='index.jsp?<%=LutGlobalRequestName.TASK_CODE%>=<%=taskCode.VIEW_MISC_FORM%>';">

</form>

<p class="block">
<strong>���й� : </strong> * ���¶֧ ��ͧ�����ŷ���ͧ��͡
</p>
<jsp:include page="includes/calendar.jsp"></jsp:include>

<div id="modal" title="������ª��ͼ��仡Ѻö¹��" style="display: none;">
	<form action="#" onsubmit="return searchEmployee();">
	������ª��ͺؤ�ҡ� <input type="text" id="search"/> <input type="submit" value="����"/>
	<div id="employeeSelectionTbl" style="margin-top: 25px; height: 250px; overflow: auto;">
	</div>
	</form> 
</div>

<script id="employeeTable" type="text/x-handlebars-template">
<table class="border">
	<tr>
		<td width="100"></td>
		<td width="400"> ���� - ���ʡ��</td>
	</tr>
	{{#each this}}
	<tr>
		<td><input type="button" value="���͡" onclick="selectEmpID( '{{EMP_ID}}', '{{EMP_NAME}}' )"/></td>
		<td>{{EMP_NAME}}</td>
	</tr>
	{{/each}}
</table>
</script>
<script id="passengerListTemplate" type="text/x-handlebars-template">
{{#each this}}
<li><input type="button" value="ź" onclick="removePassenger({{empId}})"/> {{empName}}</li>
{{/each}}
</script>


<script type="text/javascript">
var empList = [];

function isEmpty(str) {
	if(str == null || str.length == 0) {
		return true;
	} 
	
	return false;
}

function validateInput() {
	var vehicleStartTime = $('#vehicleStartTime').val();
	var vehicleEndTime = $('#vehicleEndTime').val();
	if(isEmpty($('#orgHead').val())) {
		alert("��س��кت��ͼ�����ӹҨ�����ʹ�");
		return false;
	}
	if(isEmpty($('#vehicleRequestDateStr').val())) {
		alert("��س��к��ѹ������ö");
		return false;
	}
	
	if(validateTimeString(vehicleStartTime) == false) {
		alert("��س��к����ҷ���������ö¹�� ���������ٻẺ HH:MM (�� 13 ���ԡ� 30 �ҷ� ����к��� 13:30)");
		return false;
	}
	
	if(validateTimeString(vehicleEndTime) == false) {
		alert("��س��к����ҷ���������ö¹�� ���������ٻẺ HH:MM (�� 13 ���ԡ� 30 �ҷ� ����к��� 13:30)");
		return false;
	}

	if(isEmpty($('#placeToGo').val())) {
		alert("��س��к�ʶҹ�����仮Ժѵ��Ҫ���");
		return false;
	}
	if(isEmpty($('#reasonToGo').val())) {
		alert("��س��к��Ҫ��÷��仮Ժѵ�");
		return false;
	}
	if(isEmpty($('#remark').val())) {
		$('#remark').val("-");
	}
	
	
	
	
	// now get PassengerIds...
	var passengerIds =[];
	var passengerNames =[];
	if(empList.length == 0) {
		alert("��س��кؼ�����仡Ѻö¹�����ҧ���� 1 ��ҹ");
		return false;
	} else {
		ids = '';
		for(var i=0; i< empList.length; i++) {
			passengerIds.push(empList[i].empId);
			passengerNames.push(empList[i].empName);
		}
		$('#passengerIds').val(passengerIds);
		$('#passengerNames').val(passengerNames);
	}
	
	

}

function addPassenger() {
	// empty table and previous search
	$('#search').val("");
	$('#employeeSelectionTbl').empty();
	
	$("#modal").dialog({
		height: 400,
		width: 600,
		modal: true
	});
}

function searchEmployee() {
	var query = $('#search').val();
	var source   = $("#employeeTable").html();
	var template = Handlebars.compile(source);
	
	// now do search
	$.ajax({
		type: "POST",
		url: "<c:url value='/spring/api/searchEmployee'/>",
		data: {
			query: query
		},
		success: function(response) {
			$('#employeeSelectionTbl').html(template(response));
		}
	});

	return false;
}

function selectEmpID(empId, empName) {
	var source   = $("#passengerListTemplate").html();
	var template = Handlebars.compile(source);
	
	empList.push({empId : empId, empName : empName});
	
	$('#passengerList').html(template(empList));
	$("#modal").dialog("close");
	
}

function removePassenger(empId) {
	
	var source   = $("#passengerListTemplate").html();
	var template = Handlebars.compile(source);
	
	for(var i=0; i< empList.length; i++) {
		if(empList[i].empId == empId) {
			var r=confirm("�س��ͧ�����Ҫ��� " + empList[i].empName + " �͡?");
			if (r==true) {
				empList.splice(i,1);
			} else{
				return;
			}
		}
	}
	
	$('#passengerList').html(template(empList));
	
}

$('#vehicleRequestDate').datepicker({
	isBE: true,
    autoConversionField: true,
    showButtonPanel: true,
    dateFormat: "dd MM yy",
    changeMonth: true,
    changeYear: true,
    altField: "#vehicleRequestDateStr",
    altFormat: "yymmdd"
});

</script>
