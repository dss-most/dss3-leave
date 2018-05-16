<%@page contentType="text/html"%>
<%@page pageEncoding="TIS-620"%>
<%@page import="gitex.html.*"%>
<%@page import="gitex.tu.*"%>
<%@page import="gitex.tu.htmlForm.*"%>
<%@page import="gitex.utility.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
LeaveReqHtmlPage thisPage = new LeaveReqHtmlPage(session, request);
User user = thisPage.getUser();
FrmLeaveReq thisForm = new FrmLeaveReq();   
if(session.getAttribute(LutGlobalSessionName.FORM) != null){
    thisForm = (FrmLeaveReq) session.getAttribute(LutGlobalSessionName.FORM);
}else{
    thisForm = new FrmLeaveReq(request, thisPage.getUser());  
}
FrmLeaveStat statForm = new FrmLeaveStat(session, request);
int currentBudgetYear = Date.getCurrentBudgetYear();
int budgetYear = currentBudgetYear;
if(!statForm.getValue(statForm.ELM_NAME_BUDGET_YEAR).equals("")){
    budgetYear = Integer.parseInt(statForm.getValue(statForm.ELM_NAME_BUDGET_YEAR));
}else{
    budgetYear = Integer.parseInt(thisForm.getValue(thisForm.ELM_NAME_BUDGET_YEAR));
}
thisForm.setValue(thisForm.ELM_NAME_BUDGET_YEAR, String.valueOf(budgetYear));
session.setAttribute(LutGlobalSessionName.FORM, thisForm);
%>
<h2>
���ҧ�ʴ������ҹ��ͧ��Ъ�� ����Է����ʵ���ԡ��
</h2>
<div>
<div style="margin: 5px; float:left; background-color: rgb(138, 226, 52); color: rgb(0, 0, 0); width: 70px; top: 38px;" class="fc-event fc-event-skin fc-event-hori fc-corner-left fc-corner-right">
	<div style="text-align: center; background-color:#8ae234;color:#000000" class="fc-event-inner fc-event-skin">
		<span class="fc-event-time">��ͧ��Ъ��<br/>�Ѥ�����</span>
	</div>
</div>

<div style="margin: 5px; float: left; background-color: rgb(252, 233, 79); color: rgb(0, 0, 0); width: 70px; top: 38px;" class="fc-event fc-event-skin fc-event-hori fc-corner-left fc-corner-right">
	<div style="text-align: center; background-color:#fce94f;color:#000000" class="fc-event-inner fc-event-skin">
		<span class="fc-event-time">��ͧ��Ъ��<br/>�Է��Զ�</span>
	</div>
</div>

<div style="margin: 5px; float: left; background-color: rgb(193, 122, 255); color: rgb(0, 0, 0); width: 70px; top: 38px;" class="fc-event fc-event-skin fc-event-hori fc-corner-left fc-corner-right">
	<div style="text-align: center; background-color:#C26FFF;color:#000000" class="fc-event-inner fc-event-skin">
		<span class="fc-event-time">��ͧ��Ъ��<br/>�ԸԻѭ��</span>
	</div>
</div>

<div style="float:right;">
<span class="fc-button fc-button-next fc-state-default fc-corner-right"><span class="fc-button-inner">
	<span class="fc-button-content"><a href="#" onclick="openModal()">�ͧ��ͧ��Ъ��</a></span></span></span>
</div>

</div>
<div style="clear:both;"></div>
<div id="meetingRoomCalendar"></div>

<div id="modal" title="�ͧ��ͧ��Ъ��" style="display: none;">
	<div id="alert">
	</div>
	<form action="#" id="meetingRoomReservationFrm" name="meetingRoomReservationFrm" onsubmit="return reserveMeetingRoom();">
		<input type="hidden" id="empId" name="empId" value="<%=user.employee.empId%>"/>
		<input type="hidden" id="meetingRoomRequestDateStr" name="meetingRoomRequestDateStr"/>
		<table class="frmVehicleInput">
			<tr>
				<td class="first">���͡��ͧ��Ъ��  : </td>
				<td>
					<select id="category_id">
						<option value="1">��ͧ��Ъ���Ѥ�����</option>
						<option value="2">��ͧ��Ъ���Է��Զ�</option>
						<option value="3">��ͧ��Ъ���ԸԻѭ��</option>
					</select>
				</td>
			</tr>
			<tr>
				<td class="first">*�����ѹ��� : </td>
				<td><input type="text" id="meetingRoomRequestDate" readonly="readonly"  class="datepicker" name="meetingRoomRequestDate" value="" >
				</td>
			</tr>
			<tr>
				<td class="first">*�����ҧ���� : </td>
				<td>  <input type="text" name="startTime" id="startTime" style="width:50px;"></input>�. �֧ <input type="text" name="endTime" id="endTime" style="width:50px;"></input> �. </td>
			</tr>
			<tr>
				<td class="first">*�к���Ǣ�͡�û�Ъ��  :</td>
				<td><textarea id="title" name="title" style="width:241px;height:85px;"></textarea></td>
			</tr>
			<tr>
				<td class="first">���ͧ��ͧ��Ъ��: </td>
				<td> <span id="userName"><%=user.employee.fullName%></span></td>
			</tr>
		</table>
		<br/>
		<input type="submit" name="btnSubmit" value="�ͧ��ͧ��Ъ��" style="width:130px;"/> 
		<input type="reset" name="btnReset" value="���������"/>
		<input type="button" name="btnBack" value="��͹��Ѻ" onclick="closeModal()"/>
	</form> 
</div>

<script type="text/javascript">

$('#meetingRoomCalendar').fullCalendar({
    events: '<c:url value="/spring/api/searchEvents" />',
    timeFormat: 'HH:mm{-HH:mm}'
});

function closeModal() {
	$('#modal').find('form')[0].reset();
	$("#modal").dialog("close");
	
	return false;
}

function openModal() {
	$(".datepicker").datepicker({                
        isBE: true,
        autoConversionField: true,
        dateFormat: "d MM yy",
        altField: "#meetingRoomRequestDateStr",
        altFormat: "yymmdd"
	});

	$("#modal").dialog({
		height: 400,
		width: 600,
		modal: true
	});
}

function reserveMeetingRoom() {
	
	function isEmpty(str) {
		if(str == null || str.length == 0) {
			return true;
		} 
		
		return false;
	}
	
	if(isEmpty($('#meetingRoomRequestDateStr').val())) {
		alert("��س��к��ѹ��������ͧ��Ъ��)");
		return false;
	}
	
	if(validateTimeString( $('#startTime').val()) == false) {
		alert("��س��к����ҷ�����������ͧ��Ъ�� ���������ٻẺ HH:MM (�� 13 ���ԡ� 30 �ҷ� ����к��� 13:30)");
		return false;
	}
	
	if(validateTimeString( $('#endTime').val()) == false) {
		alert("��س��к����ҷ������ش�������ͧ��Ъ�� ���������ٻẺ HH:MM (�� 13 ���ԡ� 30 �ҷ� ����к��� 13:30)");
		return false;
	}
	
	if(isEmpty($('#title').val())) {
		alert("��س��к�������Ǣ�͡�û�Ъ��)");
		return false;
	}
	
	
	
	var title = $('#title').val() + " (" + $('#userName').html() + ")";
	
	$.ajax({
		type: "POST",
		url: "<c:url value='/spring/api/reserveMeetingRoom'/>",
		data: {
			categoryId: $('#category_id').val(),
			title: title,
			meetingDay: $('#meetingRoomRequestDateStr').val(),
			startTime: $('#startTime').val(),
			endTime: $('#endTime').val(),
			empId: $('#empId').val()
		},
		success: function(response) {
			if(response.length > 0  && response[0] != "success") {
				var s="";
				for(var i=0; i<response.length; i++ ) {
					s += "  - " + response[i] + "\n";
				}
				alert("��س����͡�ѹ/�������� \n�ѹ���/���ҷ��س���͡��ӡѺ�ѹ����ա�èͧ������� \n" + s);
			} else if(response[0] = "success") {
				alert("�ѹ�֡�����š�èͧ���º���� �ҡ��ͧ������ ��سҵԴ��ͽ��� IT");
				$('#modal').find('form')[0].reset();
				$("#modal").dialog("close");
				$('#meetingRoomCalendar').fullCalendar('refetchEvents');
				
				// now get the year and month
				var yearToGo = parseInt($('#meetingRoomRequestDateStr').val().substr(0,4))-543;
				var monthToGo = parseInt($('#meetingRoomRequestDateStr').val().substr(4,2))-1;
				$('#meetingRoomCalendar').fullCalendar('gotoDate', yearToGo, monthToGo);
			}
		}
	});
	
	
	return false;
}
</script>