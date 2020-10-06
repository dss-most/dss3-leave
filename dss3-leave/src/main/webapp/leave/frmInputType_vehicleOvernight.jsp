<%@page import="org.springframework.web.servlet.support.RequestContextUtils"%>
<%@page import="org.springframework.context.ApplicationContext"%>
<%@page contentType="text/html; charset=TIS-620"%>
<%@page pageEncoding="UTF-8"%>
<%@page import="gitex.html.*"%>
<%@page import="gitex.tu.*"%>
<%@page import="gitex.tu.htmlForm.*"%>
<%@page import="gitex.utility.*"%>
<%@page import="th.go.dss.backoffice.services.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
ProvinceService province = new ProvinceService();

LeaveReqHtmlPage thisPage = new LeaveReqHtmlPage(session, request);
Employee employee = thisPage.getUser().employee;
LutLeaveReqTaskCode taskCode = new LutLeaveReqTaskCode();
gitex.utility.Date date = new gitex.utility.Date();
int budgetYear = date.getCurrentBudgetYear();
%>

<p>
<form action="<c:url value='/spring/saveFrmVehicleOvernightInput'/>" name="frmVehicleInput" method="post"  onsubmit="return validateInput();" >
<input type="hidden" name="<%=LutGlobalRequestName.TASK_CODE%>" value="<%=LutLeaveReqTaskCode.VIEW_MISC_FORM_VEHICLE_CONFIRM%>"/>

<table class="frmVehicleInput">
<tr>
	<td class="first" style="width: 200px">*เรียน  : </td>
	<td> ลสล.  ผ่าน   <input type="text" id="orgHead" name="orgHead" style="width:241px;"></input></td>
</tr>

<tr>
	<td class="first">*ขอนำรถยนต์ทะเบียน : </td>
	<td><input type="text" id="licenseNumber" name="licenseNumber" value="" >
	</td>
</tr>
<tr>
	<td class="first">*จังหวัด : </td>
	<td><select id="licenseProvinceId" name="licenseProvinceId">
		</select>
	</td>
</tr>


<tr>
	<td class="first">*จอดตั้งแต่วันที่ : </td>
	<td><input type="text" id="startOvernight" name="startOvernight" style="position:relative;" value="" >
	</td>
</tr>
<tr>
	<td class="first">*ถึงวันที่ : </td>
	<td><input type="text" id="endOvernight" name="endOvernight" style="position:relative;" value="" >
	</td>
</tr>
<tr>
	<td class="first">*เนื่องจาก  :</td>
	<td><textarea id="reason" name="reason" style="width:241px;height:85px;"></textarea></td>
</tr>
</table>

<input type="hidden" id="startOvernightDateStr" name="startOvernightDateStr"/>
<input type="hidden" id="endOvernightDateStr" name="endOvernightDateStr"/>
<input type="hidden" id="licenseProvince" name="licenseProvince"/>


<br/><br/>
<input type="submit" name="btnSubmit" value="ตรวจสอบรายละเอียด" style="width:130px;"> 
<input type="reset" name="btnReset" value="เริ่มใหม่">
<input type="button" name="btnBack" value="ย้อนกลับ" onclick="document.location='index.jsp?<%=LutGlobalRequestName.TASK_CODE%>=<%=taskCode.VIEW_MISC_FORM%>';">

</form>

<p class="block">
<strong>คำแนะนำ : </strong> * หมายถึง ช่องข้อมูลที่ต้องกรอก
</p>
<jsp:include page="includes/calendar.jsp"></jsp:include>


<script type="text/javascript">

var provinces = <%=province.getProviceListJSON()%>;

function isEmpty(str) {
	if(str == null || str.length == 0) {
		return true;
	} 
	
	return false;
}

function validateInput() {
	console.log('validate input');
	
	var vehicleStartTime = $('#vehicleStartTime').val();
	var vehicleEndTime = $('#vehicleEndTime').val();
	
	if(isEmpty($('#startOvernightDateStr').val())) {
		alert("กรุณาระบุวันที่เริ่มการขออนุญาตจอด");
		return false;
	}
	
	if(isEmpty($('#endOvernightDateStr').val())) {
		alert("กรุณาระบุวันที่สิ้นสุดการขออนุญาตจอด");
		return false;
	}

	if(isEmpty($('#licenseNumber').val())) {
		alert("กรุณาระบุทะเบียนรถยนต์");
		return false;
	}
	if(isEmpty($('#reason').val())) {
		alert("กรุณาระบุเหตุผลที่ขอนำรถยนต์มาจอด");
		return false;
	}
	
	if( isEmpty($('#licenseProvinceId').val())) {
		alert("กรุณาเลือกจังหวัดของทะเบียนรถยนต์");
		return false;
	} else {
		var currentProvinceId = $('#licenseProvinceId').val();
		var currentProvince = provinces.find(function(p) {return p.PROVINCE_ID == currentProvinceId});
		$('#licenseProvince').val(currentProvince.PROVINCE_NAME);
	}

}

$('#startOvernight').datepicker({
	isBE: true,
    autoConversionField: true,
    showButtonPanel: true,
    dateFormat: "dd MM yy",
    changeMonth: true,
    changeYear: true,
    altField: "#startOvernightDateStr",
    altFormat: "yymmdd"
});

$('#endOvernight').datepicker({
	isBE: true,
    autoConversionField: true,
    showButtonPanel: true,
    dateFormat: "dd MM yy",
    changeMonth: true,
    changeYear: true,
    altField: "#endOvernightDateStr",
    altFormat: "yymmdd"
});


var dropdown = $('#licenseProvinceId');

dropdown.empty();

dropdown.append('<option selected="true" disabled>เลือกจังหวัด</option>');
dropdown.prop('selectedIndex', 0);

$.each(provinces, function (key, entry) {
    dropdown.append($('<option></option>').attr('value', entry.PROVINCE_ID).text(entry.PROVINCE_NAME));
  })

</script>
