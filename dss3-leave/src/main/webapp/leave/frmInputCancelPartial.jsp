<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>
<%@page import="java.util.*"%>
<%@page import="gitex.html.*"%>
<%@page import="gitex.tu.*"%>
<%@page import="gitex.tu.htmlForm.*"%>
<%@page import="gitex.utility.*"%>
<%
LeaveReqHtmlPage thisPage = new LeaveReqHtmlPage(session, request);
Employee employee = thisPage.getUser().employee;
FrmLeaveReq thisForm = new FrmLeaveReq(request, thisPage.getUser());   
if(session.getAttribute(LutGlobalSessionName.FORM) != null){
    thisForm = (FrmLeaveReq)session.getAttribute(LutGlobalSessionName.FORM);
}else{
    thisForm = new FrmLeaveReq(thisForm.getValue(thisForm.ELM_NAME_REF_TAKE_LEAVE_ID));
    thisForm.setValue(thisForm.ELM_NAME_REF_TAKE_LEAVE_ID, thisForm.getValue(thisForm.ELM_NAME_TAKE_LEAVE_ID));
    thisForm.setValue(thisForm.ELM_NAME_REMARK, "");
    thisForm.setValue(thisForm.ELM_NAME_FORM_START_DATE, thisForm.getValue(thisForm.ELM_NAME_LEAVE_START_DATE));
    thisForm.setValue(thisForm.ELM_NAME_FORM_START_DATE_PERIOD, thisForm.getValue(thisForm.ELM_NAME_LEAVE_START_DATE_PERIOD));
    thisForm.setValue(thisForm.ELM_NAME_FORM_END_DATE, thisForm.getValue(thisForm.ELM_NAME_LEAVE_END_DATE));
    thisForm.setValue(thisForm.ELM_NAME_FORM_END_DATE_PERIOD, thisForm.getValue(thisForm.ELM_NAME_LEAVE_END_DATE_PERIOD));
}
FrmLeaveReq tempForm = new FrmLeaveReq(thisForm.getValue(thisForm.ELM_NAME_REF_TAKE_LEAVE_ID));
LutLeaveReqTaskCode taskCode = new LutLeaveReqTaskCode();   
gitex.utility.Date date = new gitex.utility.Date();
%>
<h3>
ประเภทคำร้อง : <span class="lblLeaveName"><%=tempForm.getFormName()%></span><br/>
สถานะ : <span class="lblLeaveName"><%=tempForm.getStatusName(tempForm.getValue(tempForm.ELM_NAME_STATUS))%></span><br/>
</h3>
<p class="block blue">
วันที่เริ่มต้นการลา <%=((Hashtable)date.getDate(tempForm.getValue(tempForm.ELM_NAME_LEAVE_START_DATE), date.MONTH_NAME_FULL)).get(date.DATE_THAI).toString()%> <%=tempForm.getPeriodName(tempForm.getValue(tempForm.ELM_NAME_LEAVE_START_DATE_PERIOD))%><br>
วันที่สิ้นสุดการลา <%=((Hashtable)date.getDate(tempForm.getValue(tempForm.ELM_NAME_LEAVE_END_DATE), date.MONTH_NAME_FULL)).get(date.DATE_THAI).toString()%> <%=tempForm.getPeriodName(tempForm.getValue(tempForm.ELM_NAME_LEAVE_END_DATE_PERIOD))%><br>
รวมระยะเวลาทั้งสิ้น <%=tempForm.getValue(tempForm.ELM_NAME_LEAVE_DAY_COUNT_MASTER)%> วัน<br>
</p>
<p>
ต้องการยกเลิกวันลา
<form name="FrmLeaveReq" action="index.jsp" method="post">
<input type="hidden" name="<%=LutGlobalRequestName.TASK_CODE%>" value="<%=taskCode.PREVIEW_CANCEL_PARTIAL%>"/>
<input type="hidden" name="<%=thisForm.ELM_NAME_REF_TAKE_LEAVE_ID%>" value="<%=thisForm.getValue(thisForm.ELM_NAME_REF_TAKE_LEAVE_ID)%>"/>
<p class="right" style="width:350px;">
เรียน : <input type="text" name="<%=thisForm.ELM_NAME_ORG_HEAD_WORK_TITLE%>" value="<%=thisForm.getValue(thisForm.ELM_NAME_ORG_HEAD_WORK_TITLE)%>"/><img src="images/spacer.gif" width="20" height="1" /><img src="images/spacer.gif" width="81" height="1" /><br />
*ตั้งแต่วันที่ : <input type="text" name="txtLeaveSD" style="position:relative;" value="" onKeyDown="click();return false;" onClick="window.event.cancelBubble=true;setCalendarCaller(this, '<%=thisForm.ELM_NAME_FORM_START_DATE%>', this.offsetTop, this.offsetLeft);" onfocus="validateDate(this, '<%=thisForm.ELM_NAME_FORM_START_DATE%>', '<%=thisForm.ELM_NAME_FORM_START_DATE_PERIOD%>');"/> <input type="radio" name="checkPeriod1" value="<%=thisForm.FORM_PERIOD_MORNING%>"  onclick="setPeriodValue('start', this.value);" <%if(thisForm.getValue(thisForm.ELM_NAME_FORM_START_DATE_PERIOD).equals(thisForm.FORM_PERIOD_MORNING)){%>checked<%}%>/> เช้า  <input type="radio" name="checkPeriod1" value="<%=thisForm.FORM_PERIOD_AFTERNOON%>" onclick="setPeriodValue('start', this.value);" <%if(thisForm.getValue(thisForm.ELM_NAME_FORM_START_DATE_PERIOD).equals(thisForm.FORM_PERIOD_AFTERNOON)){%>checked<%}%>/> บ่าย<br/>
*ถึงวันที่ : <input type="text" name="txtLeaveED" style="position:relative;" value="" onKeyDown="click();return false;" onClick="window.event.cancelBubble=true;setCalendarCaller(this, '<%=thisForm.ELM_NAME_FORM_END_DATE%>', this.offsetTop, this.offsetLeft);" onfocus="validateDate(this, '<%=thisForm.ELM_NAME_FORM_END_DATE%>', '<%=thisForm.ELM_NAME_FORM_END_DATE_PERIOD%>');"/> <input type="radio" name="checkPeriod2" value="<%=thisForm.FORM_PERIOD_MORNING%>" onclick="setPeriodValue('end', this.value);" <%if(thisForm.getValue(thisForm.ELM_NAME_FORM_END_DATE_PERIOD).equals(thisForm.FORM_PERIOD_MORNING)){%>checked<%}%>/> เช้า  <input type="radio" name="checkPeriod2" value="<%=thisForm.FORM_PERIOD_AFTERNOON%>" onclick="setPeriodValue('end', this.value);" <%if(thisForm.getValue(thisForm.ELM_NAME_FORM_END_DATE_PERIOD).equals(thisForm.FORM_PERIOD_AFTERNOON)){%>checked<%}%>/> บ่าย<br/>
รวม : <input type="text" name="<%=thisForm.ELM_NAME_LEAVE_DAY_COUNT_MASTER%>" value="<%=thisForm.getValue(thisForm.ELM_NAME_LEAVE_DAY_COUNT_MASTER)%>" onclick="return false" onfocus="blur();"/> วัน <img src="images/spacer.gif" width="77" height="1" /><br />
<input type="hidden" name="<%=thisForm.ELM_NAME_FORM_START_DATE%>" value="<%=thisForm.getValue(thisForm.ELM_NAME_FORM_START_DATE)%>"/>
<input type="hidden" name="<%=thisForm.ELM_NAME_FORM_START_DATE_PERIOD%>" value="<%=thisForm.getValue(thisForm.ELM_NAME_FORM_START_DATE_PERIOD)%>"/>
<input type="hidden" name="<%=thisForm.ELM_NAME_FORM_END_DATE%>" value="<%=thisForm.getValue(thisForm.ELM_NAME_FORM_END_DATE)%>"/>
<input type="hidden" name="<%=thisForm.ELM_NAME_FORM_END_DATE_PERIOD%>" value="<%=thisForm.getValue(thisForm.ELM_NAME_FORM_END_DATE_PERIOD)%>"/>
*เนื่องจาก  : <input type="text" name="<%=thisForm.ELM_NAME_REMARK%>" style="width:241px;" value="<%=thisForm.getValue(thisForm.ELM_NAME_REMARK)%>"/><br />
<br />
<input type="submit" name="btnSubmit" value="ตรวจสอบรายละเอียด" style="width:130px;"> 
<input type="reset" name="btnReset" value="เริ่มใหม่"> 
<input type="button" name="btnBack" value="ย้อนกลับ" onclick="document.location='index.jsp?<%=LutGlobalRequestName.TASK_CODE%>=<%=taskCode.CHECK_REQ_STATUS_2%>&<%=thisForm.ELM_NAME_TAKE_LEAVE_ID%>=<%=thisForm.getValue(thisForm.ELM_NAME_REF_TAKE_LEAVE_ID)%>';">
</p>
</form>
</p>
<p class="block">
<strong>คำแนะนำ : </strong> * หมายถึง ช่องข้อมูลที่ต้องกรอก
</p>
<jsp:include page="includes/calendar.jsp"></jsp:include>
<script language="javaScript">
    function setPeriodValue(startOrEnd, value){
        var periodObj = "";
        var dateTextObj = "";
        var dateValueObj = "";
        if(startOrEnd == 'start'){
            periodObj = document.all['<%=thisForm.ELM_NAME_FORM_START_DATE_PERIOD%>'];
            dateTextObj = document.all['txtLeaveSD'];
            dateValueObj = document.all['<%=thisForm.ELM_NAME_FORM_START_DATE%>'];
        }else{
            periodObj = document.all['<%=thisForm.ELM_NAME_FORM_END_DATE_PERIOD%>'];
            dateTextObj = document.all['txtLeaveED'];
            dateValueObj = document.all['<%=thisForm.ELM_NAME_FORM_END_DATE%>'];
        }
        periodObj.value = value;
        return validateDate(dateTextObj, dateValueObj.name, periodObj.name);
    }
    function validateDate(objTextDate, nameDateValue, namePeriodValue){
        var maxDate = "<%=thisForm.getValue(thisForm.ELM_NAME_FORM_END_DATE)%>" + "<%=thisForm.getValue(thisForm.ELM_NAME_FORM_END_DATE_PERIOD)%>";
        var minDate = "<%=thisForm.getValue(thisForm.ELM_NAME_FORM_START_DATE)%>" + "<%=thisForm.getValue(thisForm.ELM_NAME_FORM_START_DATE_PERIOD)%>";
        var selectedDate = "";
        if(document.all[nameDateValue].value != "" && document.all[namePeriodValue].value != "") selectedDate = document.all[nameDateValue].value + document.all[namePeriodValue].value;
        var startDate = document.all['<%=thisForm.ELM_NAME_FORM_START_DATE%>'].value;
        var startDatePeriod = document.all['<%=thisForm.ELM_NAME_FORM_START_DATE_PERIOD%>'].value;
        var endDate = document.all['<%=thisForm.ELM_NAME_FORM_END_DATE%>'].value;
        var endDatePeriod = document.all['<%=thisForm.ELM_NAME_FORM_END_DATE_PERIOD%>'].value;
        var isError = false;
        if(selectedDate != ""){
            if(parseInt(selectedDate) < parseInt(minDate) || parseInt(selectedDate) > parseInt(maxDate)){
                //alert("maxDate=" + maxDate + "\r" + "minDate=" + minDate + "\rselected date =" + selectedDate);
                alert("วันยกเลิกการลาไม่ถูกต้อง \rวันยกเลิกการลาต้องอยู่ในช่วงของการลา");
                isError = true;
            }      
            var date = new Date(selectedDate.substring(0, 4), selectedDate.substring(4, 6) - 1, selectedDate.substring(6, 8));
            if(date.getDay() == 0 || date.getDay() == 6){
                alert("วันยกเลิกการลาไม่ถูกต้อง \rวันที่คุณเลือกตรงกับวันเสาร์ อาทิตย์ หรือวันหยุดราชการ");
                isError = true;
            }
        }
        if(startDate != '' && endDate != ''){
            //check startDate must be less than endDate
            if(parseInt(startDate) > parseInt(endDate) || (parseInt(startDate) == parseInt(endDate) && startDatePeriod + endDatePeriod == '10')){
                alert("วันยกเลิกการลาไม่ถูกต้อง \rวันเริ่มต้นการยกเลิกการลาต้องน้อยกว่าวันสิ้นสุดการยกเลิกการลา");
                isError = true;
            }else if(startDate + startDatePeriod != minDate && endDate + endDatePeriod != maxDate){
                alert("วันยกเลิกการลาไม่ถูกต้อง \rวันลาที่ต้องการยกเลิกจะต้องเริ่มต้นที่วันที่เริ่มต้นลา \rหรือสิ้นสุดที่วันที่สิ้นสุดการลา");
                isError = true;
            }
        }
        if(isError){
            if(objTextDate) objTextDate.value = "";
            if(document.all[nameDateValue]) document.all[nameDateValue].value = "";
            document.all['<%=thisForm.ELM_NAME_LEAVE_DAY_COUNT_MASTER%>'].value = "";
        }else{
            document.all['<%=thisForm.ELM_NAME_LEAVE_DAY_COUNT_MASTER%>'].value = countWorkDay(startDate, endDate, startDatePeriod, endDatePeriod);
        }
        return !isError;
    }
     function countWorkDay(startDate, endDate, startPeriod, endPeriod){
        if(startDate == "" || endDate == ""){
            return "";
        }else{
            // Create date object for startDate and endDate
            var date1 = new Date(startDate.substring(0,4), startDate.substring(4, 6) - 1, startDate.substring(6, 8));
            var date2 = new Date(endDate.substring(0,4), endDate.substring(4, 6) - 1, endDate.substring(6, 8));

            // The number of milliseconds in one day
            var ONE_DAY = 1000 * 60 * 60 * 24;

            // Convert both dates to milliseconds
            var date1_ms = date1.getTime();
            var date2_ms = date2.getTime();

            // Calculate the difference in milliseconds
            var difference_ms = Math.abs(date1_ms - date2_ms);
            // Convert back to days and return
            var numOfDay = Math.round(difference_ms/ONE_DAY) + 1;
            
            <%if(employee.isCountOnlyWorkday(thisForm.getValue(thisForm.ELM_NAME_FORM_CAT_ID))){%>
                var numOfHoliday = getNumOfHoliday(startDate, endDate);
                
              
                
                // alert(numOfHoliday);
                // Count Saturday and Sunday
                var YYYY = date1.getFullYear();
                var MM = date1.getMonth();
                var DD = date1.getDate();
                for(i = 0; i < numOfDay; i++){
                    var tempDate = new Date(YYYY, MM, DD + i);
                    //alert("date =  " + tempDate);
                    if(tempDate.getDay() == 0 || tempDate.getDay() == 6){
                        numOfHoliday++;
                    }
                }
                // Net work day
                // alert("numOfHoliday"+numOfHoliday);
                numOfDay -= numOfHoliday;
            <%}%>
            // Calculate period
            if(date1.getDay() == 0 || date1.getDay() == 6) startPeriod = "0";
            if(date2.getDay() == 0 || date2.getDay() == 6) endPeriod = "1";
            if(startPeriod + endPeriod == "00" || startPeriod + endPeriod == "11"){
                numOfDay = parseFloat(numOfDay) - 0.5;
            }else if(startPeriod + endPeriod == "10") numOfDay = numOfDay - 1;
            return numOfDay;
        }
    }
    
    function getNumOfHoliday(fromDate, toDate){
        var holiday = new Array();
        <%
        gitex.tu.LeaveHolidays hol = new gitex.tu.LeaveHolidays(Integer.parseInt(thisForm.getValue(thisForm.ELM_NAME_BUDGET_YEAR)));
        for(int i = 0; i < hol.list.size(); i++){
            %>holiday[<%=i%>] = "<%=((java.util.Hashtable)hol.list.get(i)).get(hol.DATE).toString()%>";<%
        }
        %>
        var holCount = 0.0;
        for(var i = 0; i < holiday.length; i++){
            var holDay = holiday[i];
            if(holDay >= fromDate && holDay <= toDate){
                holCount++;
            }
        }
      //   alert(holcount);
        return holCount;
    }
</script>
<script language="JavaScript">
    var frmLoginValidator  = new Validator("FrmLeaveReq");
    frmLoginValidator.addValidation("txtLeaveSD","req","กรุณาใส่วันเริ่มต้นการยกเลิกการลา");
    frmLoginValidator.addValidation("txtLeaveED","req","กรุณาใส่วันสิ้นสุดการยกเลิกการลา");
    frmLoginValidator.addValidation("<%=thisForm.ELM_NAME_REMARK%>","req","กรุณาใส่สาเหตุการยกเลิกวันลา");

    setDateDisplayText(document.all['txtLeaveSD'], document.all['<%=thisForm.ELM_NAME_FORM_START_DATE%>'].value);
    setDateDisplayText(document.all['txtLeaveED'], document.all['<%=thisForm.ELM_NAME_FORM_END_DATE%>'].value);
    validateDate(null, null, null);
</script>
