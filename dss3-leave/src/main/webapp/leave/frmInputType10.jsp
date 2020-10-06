<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>
<%@page import="java.util.*"%>
<%@page import="gitex.html.*"%>
<%@page import="gitex.tu.*"%>
<%@page import="gitex.tu.htmlForm.*"%>
<%@page import="gitex.utility.*"%>
<%
LeaveReqHtmlPage thisPage = new LeaveReqHtmlPage(session, request);
LutLeaveReqTaskCode taskCode = new LutLeaveReqTaskCode();   
gitex.utility.Date date = new gitex.utility.Date();
FrmLeaveReq thisForm = new FrmLeaveReq(request, thisPage.getUser());
if(thisForm.getValue(thisForm.ELM_NAME_FORM_TYPE_ID).equals("")){
    thisForm = (FrmLeaveReq) session.getAttribute(LutGlobalSessionName.FORM);
}
ArrayList listSubForm = new ArrayList();
if(session.getAttribute(LutGlobalSessionName.SUB_FORM) != null){
    listSubForm = (ArrayList)session.getAttribute(LutGlobalSessionName.SUB_FORM);
}
FrmLeaveReq newSubForm = new FrmLeaveReq(request, thisPage.getUser());
if(!thisForm.getValue(thisForm.ELM_NAME_SUB_FORM_TYPE_ID).equals("")){
    if(listSubForm.size() < Integer.parseInt(thisForm.getValue(thisForm.ELM_NAME_SUB_FORM_COUNT))){
        newSubForm.setValue(newSubForm.ELM_NAME_FORM_TYPE_ID, thisForm.getValue(thisForm.ELM_NAME_SUB_FORM_TYPE_ID));
        newSubForm.setValue(newSubForm.ELM_NAME_FORM_CAT_ID, newSubForm.getCategoryId(newSubForm.getValue(newSubForm.ELM_NAME_FORM_TYPE_ID)));
        newSubForm.setValue(newSubForm.ELM_NAME_FORM_START_DATE, thisForm.getValue(thisForm.ELM_NAME_LEAVE_START_DATE));
        newSubForm.setValue(newSubForm.ELM_NAME_FORM_START_DATE_PERIOD, thisForm.getValue(thisForm.ELM_NAME_LEAVE_START_DATE_PERIOD));
        newSubForm.setValue(newSubForm.ELM_NAME_FORM_END_DATE, thisForm.getValue(thisForm.ELM_NAME_LEAVE_END_DATE));
        newSubForm.setValue(newSubForm.ELM_NAME_FORM_END_DATE_PERIOD, thisForm.getValue(thisForm.ELM_NAME_LEAVE_END_DATE_PERIOD));
        newSubForm.setValue(newSubForm.ELM_NAME_LEAVE_DAY_COUNT_MASTER, thisForm.getValue(thisForm.ELM_NAME_LEAVE_DAY_COUNT_CHILD));
        newSubForm.setValue(newSubForm.ELM_NAME_TEXT_1, "มีความประสงค์จะเดินทางไปต่างประเท(" + thisForm.getValue(thisForm.ELM_NAME_TO_COUNTRY) + ")");
        newSubForm.setValue(newSubForm.ELM_NAME_TEXT_2, thisForm.getValue(thisForm.ELM_NAME_CONTACT_DETAIL));
        listSubForm.add(newSubForm);
        session.setAttribute(LutGlobalSessionName.SUB_FORM, listSubForm);        
    }
}
if(!thisForm.getValue(thisForm.ELM_NAME_SUB_FORM_DELETE).equals("")){
    if(listSubForm.size() > 0){
        int index = Integer.parseInt(thisForm.getValue(thisForm.ELM_NAME_SUB_FORM_DELETE));
        listSubForm.remove(index);
    }    
}
%>
<p>
<form name="FrmLeaveReq" action="index.jsp" method="post">
<input type="hidden" name="<%=LutGlobalRequestName.TASK_CODE%>" value="<%=taskCode.REQ_IN_COUNTRY_LEAVE_3%>"/>
<input type="hidden" name="<%=thisForm.ELM_NAME_FORM_TYPE_ID%>" value="<%=thisForm.getValue(thisForm.ELM_NAME_FORM_TYPE_ID)%>"/>
<input type="hidden" name="<%=thisForm.ELM_NAME_FORM_CAT_ID%>" value="<%=thisForm.getValue(thisForm.ELM_NAME_FORM_CAT_ID)%>"/>
<p class="right" style="width:350px;">
<span style="text-align:right;font-weight:bold">เดินทางไปต่างประเทศ</span>
<img src="images/spacer.gif" width="205" height="1"/><br/><br/>
*ตั้งแต่วันที่ : <input type="text" name="txtLeaveSD" style="position:relative;" value="" onKeyDown="click();return false;" onClick="window.event.cancelBubble=true;setCalendarCaller(this, '<%=thisForm.ELM_NAME_FORM_START_DATE%>', this.offsetTop, this.offsetLeft);" onfocus="validateDate(this, '<%=thisForm.ELM_NAME_FORM_START_DATE%>');" <%if(listSubForm.size() > 0){%>disabled<%}%>/> <input type="radio" name="checkPeriod1" value="<%=thisForm.FORM_PERIOD_MORNING%>"  onclick="setPeriodValue('start', this.value);" <%if(thisForm.getValue(thisForm.ELM_NAME_FORM_START_DATE_PERIOD).equals(thisForm.FORM_PERIOD_MORNING)){%>checked<%}%> <%if(listSubForm.size() > 0){%>disabled<%}%>/> เช้า  <input type="radio" name="checkPeriod1" value="<%=thisForm.FORM_PERIOD_AFTERNOON%>" onclick="setPeriodValue('start', this.value);" <%if(thisForm.getValue(thisForm.ELM_NAME_FORM_START_DATE_PERIOD).equals(thisForm.FORM_PERIOD_AFTERNOON)){%>checked<%}%> <%if(listSubForm.size() > 0){%>disabled<%}%>/> บ่าย<br/>
*ถึงวันที่ : <input type="text" name="txtLeaveED" style="position:relative;" value="" onKeyDown="click();return false;" onClick="window.event.cancelBubble=true;setCalendarCaller(this, '<%=thisForm.ELM_NAME_FORM_END_DATE%>', this.offsetTop, this.offsetLeft);" onfocus="validateDate(this, '<%=thisForm.ELM_NAME_FORM_END_DATE%>');" <%if(listSubForm.size() > 0){%>disabled<%}%>/> <input type="radio" name="checkPeriod2" value="<%=thisForm.FORM_PERIOD_MORNING%>" onclick="setPeriodValue('end', this.value);" <%if(thisForm.getValue(thisForm.ELM_NAME_FORM_END_DATE_PERIOD).equals(thisForm.FORM_PERIOD_MORNING)){%>checked<%}%> <%if(listSubForm.size() > 0){%>disabled<%}%>/> เช้า  <input type="radio" name="checkPeriod2" value="<%=thisForm.FORM_PERIOD_AFTERNOON%>" onclick="setPeriodValue('end', this.value);" <%if(thisForm.getValue(thisForm.ELM_NAME_FORM_END_DATE_PERIOD).equals(thisForm.FORM_PERIOD_AFTERNOON)){%>checked<%}%> <%if(listSubForm.size() > 0){%>disabled<%}%>/> บ่าย<br/>
รวม : <input type="text" name="<%=thisForm.ELM_NAME_LEAVE_DAY_COUNT_MASTER%>" value="<%=thisForm.getValue(thisForm.ELM_NAME_LEAVE_DAY_COUNT_MASTER)%>" onclick="return false" onfocus="blur();"/> วันทำการ <img src="images/spacer.gif" width="39" height="1" /><br />
<input type="hidden" name="<%=thisForm.ELM_NAME_FORM_START_DATE%>" value="<%=thisForm.getValue(thisForm.ELM_NAME_FORM_START_DATE)%>"/>
<input type="hidden" name="<%=thisForm.ELM_NAME_FORM_START_DATE_PERIOD%>" value="<%=thisForm.getValue(thisForm.ELM_NAME_FORM_START_DATE_PERIOD)%>"/>
<input type="hidden" name="<%=thisForm.ELM_NAME_FORM_END_DATE%>" value="<%=thisForm.getValue(thisForm.ELM_NAME_FORM_END_DATE)%>"/>
<input type="hidden" name="<%=thisForm.ELM_NAME_FORM_END_DATE_PERIOD%>" value="<%=thisForm.getValue(thisForm.ELM_NAME_FORM_END_DATE_PERIOD)%>"/>
<br />
<script language="javaScript">
    function setPeriodValue(startOrEnd, value){
        if(startOrEnd == 'start') document.all['<%=thisForm.ELM_NAME_FORM_START_DATE_PERIOD%>'].value = value;
        else document.all['<%=thisForm.ELM_NAME_FORM_END_DATE_PERIOD%>'].value = value;
        
        return validateDate(document.all['txtLeaveED'], '<%=thisForm.ELM_NAME_FORM_END_DATE%>');
    }
    function validateDate(objTextDate, nameDateValue){
        var date = new Date();
        var bMonth = date.getMonth() + 1;
        var bYear = date.getFullYear();
        if(bMonth > 9) bYear++;
        var maxDate = date.getFullYear() + "0931";
        var minDate = (date.getFullYear() -1) + "1001";
        var selectedDate = "";
        if(document.all[nameDateValue]) selectedDate = document.all[nameDateValue].value;
        //alert("selected date =" + selectedDate);
        var startDate = document.all['<%=thisForm.ELM_NAME_FORM_START_DATE%>'].value;
        var startDatePeriod = document.all['<%=thisForm.ELM_NAME_FORM_START_DATE_PERIOD%>'].value;
        var endDate = document.all['<%=thisForm.ELM_NAME_FORM_END_DATE%>'].value;
        var endDatePeriod = document.all['<%=thisForm.ELM_NAME_FORM_END_DATE_PERIOD%>'].value;
        var isError = false;
        if(selectedDate != ""){
            if(parseInt(selectedDate) < parseInt(minDate) || parseInt(selectedDate) > parseInt(maxDate)){
                alert("วันลาไม่ถูกต้อง วันลาต้องอยู่ในปีงบประมาณ");
                isError = true;
            }      
            date = new Date(selectedDate.substring(0, 4), selectedDate.substring(4, 6) - 1, selectedDate.substring(6, 8));
            /*
            if(date.getDay() == 0 || date.getDay() == 6){
                alert("วันลาไม่ถูกต้อง \rวันที่คุณเลือกตรงกับวันเสาร์ อาทิตย์ หรือวันหยุดราชการ");
                isError = true;
            }
            */
        }
        if(startDate != '' && endDate != ''){
            //check startDate must be less than endDate
            if(parseInt(startDate) > parseInt(endDate) || (parseInt(startDate) == parseInt(endDate) && startDatePeriod + endDatePeriod == '10')){
                alert("วันลาไม่ถูกต้อง วันเริ่มต้นลาต้องน้อยกว่าวันสิ้นสุดการลา");
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
            var YYYY = date1.getFullYear();
            var MM = date1.getMonth();
            var DD = date1.getDate();
            var numOfHoliday = 0;
            for(i = 0; i < numOfDay; i++){
                var tempDate = new Date(YYYY, MM, DD + i);
                //alert("date =  " + tempDate);
                if(tempDate.getDay() == 0 || tempDate.getDay() == 6){
                    numOfHoliday++;
                }
            }
            numOfDay -= numOfHoliday;
            // Calculate period
            if(date1.getDay() == 0 || date1.getDay() == 6) startPeriod = "0";
            if(date2.getDay() == 0 || date2.getDay() == 6) endPeriod = "1";
            if(startPeriod + endPeriod == "00" || startPeriod + endPeriod == "11"){
                numOfDay = parseFloat(numOfDay) - 0.5;
            }else if(startPeriod + endPeriod == "10") numOfDay = numOfDay - 1;
            return numOfDay;
        }
    }
</script>

*ประเทศ  : <input type="text" name="<%=thisForm.ELM_NAME_TO_COUNTRY%>" style="width:241px;" value="<%=thisForm.getValue(thisForm.ELM_NAME_TO_COUNTRY)%>"/><br />
*สถานที่ติดต่อ  : <input type="text" name="<%=thisForm.ELM_NAME_CONTACT_DETAIL%>" style="width:241px;" value="<%=thisForm.getValue(thisForm.ELM_NAME_CONTACT_DETAIL)%>"/><br />
หมายเหตุ  : <input type="text" name="<%=thisForm.ELM_NAME_REMARK%>" style="width:241px;" value="<%=thisForm.getValue(thisForm.ELM_NAME_REMARK)%>"/><br />
<span style="font-size:smaller">*หนังสือรับรองเพื่อขอวีซ่า</span> : <input type="radio" name="<%=thisForm.ELM_NAME_IS_NEED_VISA%>" value="<%=thisForm.FORM_NEED_VISA%>" <%if(thisForm.getValue(thisForm.ELM_NAME_IS_NEED_VISA).equals(thisForm.FORM_NEED_VISA)){%>checked<%}%>/> ต้องการ  <input type="radio" name="<%=thisForm.ELM_NAME_IS_NEED_VISA%>" value="<%=thisForm.FORM_NOT_NEED_VISA%>" <%if(thisForm.getValue(thisForm.ELM_NAME_IS_NEED_VISA).equals(thisForm.FORM_NOT_NEED_VISA)){%>checked<%}%>/> ไม่ต้องการ
<img src="images/spacer.gif" width="35" height="1"/><br/>
<br/>
<span style="text-align:right;font-weight:bold">โดยใช้การลาดังนี้</span>
<img src="images/spacer.gif" width="235" height="1"/><br/><br/>
*ประเภทการลา : <select name="<%=thisForm.ELM_NAME_SUB_FORM_TYPE_ID%>" style="width:146px;">
    <option value="<%=thisForm.FORM_TYPE_VACATION%>" selected><%=thisForm.getFormName(thisForm.FORM_TYPE_VACATION)%></option>
    <option value="<%=thisForm.FORM_TYPE_PRIVATE%>"><%=thisForm.getFormName(thisForm.FORM_TYPE_PRIVATE)%></option>
</select><img src="images/spacer.gif" width="101" height="1" /><br/>
<%@include file="/WEB-INF/jspf/dateInput2.jspf" %>
<input type="submit" value="เพิ่มการลา" onclick="return addLeave();" style="width:61px;"/>
</p>
<br/>
<%
double totalLeaveDayCount = 0; 
if(listSubForm.size() > 0){%>
    <table width="100%">
    <tr>
    <td class="tblHeader left" width="25%">ประเภทการลา</td>
    <td class="tblHeader center" width="50%">วันที่</td>
    <td class="tblHeader center" width="20%">รวม(วัน)</td>
    <td class="tblHeader center" width="5%">&nbsp;</td>
    </tr>
    <%
    int rowCount = 0;
    for(int i = 0; i < listSubForm.size(); i++){
       FrmLeaveReq tempForm = (FrmLeaveReq)listSubForm.get(i);
       String formTypeName = tempForm.getFormName();
       String startDate = date.getDate(tempForm.getValue(tempForm.ELM_NAME_FORM_START_DATE), date.MONTH_NAME_SHORT).get(date.DATE_THAI).toString();
       String endDate = date.getDate(tempForm.getValue(tempForm.ELM_NAME_FORM_END_DATE), date.MONTH_NAME_SHORT).get(date.DATE_THAI).toString();
       String startDatePeriod = tempForm.getPeriodName(tempForm.getValue(tempForm.ELM_NAME_FORM_START_DATE_PERIOD));
       String endDatePeriod = tempForm.getPeriodName(tempForm.getValue(tempForm.ELM_NAME_FORM_END_DATE_PERIOD));
       String leaveDayCount = tempForm.getValue(tempForm.ELM_NAME_LEAVE_DAY_COUNT_MASTER);
       totalLeaveDayCount += Double.parseDouble(leaveDayCount);
    %>
    <tr>
    <td class="tblRow<%=rowCount % 2%>" width="25%"><%=formTypeName%></td>
    <td class="tblRow<%=rowCount % 2%> center" width="50%"><%=startDate + " " + startDatePeriod%> - <%=endDate + " " + endDatePeriod%></td>
    <td class="tblRow<%=rowCount % 2%> center" width="20%"><%=leaveDayCount%></td>
    <td class="tblRow<%=rowCount % 2%> center" width="5%"><input type="submit" name="btnDelete" value=" ลบ " onclick="return submitDelete(<%=i%>);"/></td>
    </tr>
    <%
       rowCount++;
    }%>
    <tr>
    <td colspan="2" class="tblRow<%=rowCount % 2%> right" width="75%"><strong>รวมวันลาทั้งหมด</strong>&nbsp;</td>
    <td class="tblRow<%=rowCount  % 2%> center blue" width="25%"><strong><%=totalLeaveDayCount%></strong></td>
    </tr>
    </table>
    <br/>
<%}%>
<p class="right" style="width:350px;">
<input type="hidden" name="<%=thisForm.ELM_NAME_SUB_FORM_COUNT%>" value="<%=listSubForm.size()%>"/>
<input type="hidden" name="numOfSubLeaveDay" value="<%=totalLeaveDayCount%>"/>
<input type="hidden" name="<%=thisForm.ELM_NAME_SUB_FORM_DELETE%>" value=""/>
<input type="submit" name="btnSubmit" value="ตรวจสอบรายละเอียด" style="width:130px;" onclick=" return submitReq();"> 
<input type="reset" name="btnReset" value="เริ่มใหม่"> 
<input type="button" name="btnBack" value="ย้อนกลับ" onclick="document.location='index.jsp?<%=LutGlobalRequestName.TASK_CODE%>=<%=taskCode.REQ_OUT_COUNTRY_LEAVE_1%>';">
</p>
</form>
</p>
<p class="block">
<strong>คำแนะนำ : </strong> * หมายถึง ช่องข้อมูลที่ต้องกรอก
</p>
<jsp:include page="includes/calendar.jsp"></jsp:include>
<script language="JavaScript">
    var frmLoginValidator  = new Validator("FrmLeaveReq");
    frmLoginValidator.addValidation("txtLeaveSD","req","กรุณาใส่วันเริ่มต้นการลา(วันที่เดินทาง)");
    frmLoginValidator.addValidation("txtLeaveED","req","กรุณาใส่วันสิ้นสุดการลา(วันที่กลับ)");
    frmLoginValidator.addValidation("<%=thisForm.ELM_NAME_TO_COUNTRY%>","req","กรุณาใส่ชื่อประเทศที่จะไป");
    frmLoginValidator.addValidation("<%=thisForm.ELM_NAME_CONTACT_DETAIL%>","req","กรุณาใส่สถานที่ติดต่อ");
    setDateDisplayText(document.all['txtLeaveSD'], document.all['<%=thisForm.ELM_NAME_FORM_START_DATE%>'].value);
    setDateDisplayText(document.all['txtLeaveED'], document.all['<%=thisForm.ELM_NAME_FORM_END_DATE%>'].value);
    validateDate(null, null, null);
</script>
<script>    
    function addLeave(){
        if(document.FrmLeaveReq.txtLeaveSD2.value == ""){
            alert("กรุณาใส่วันเริ่มต้นการลา");
            return false;
        }else if(document.FrmLeaveReq.txtLeaveED2.value == ""){
            alert("กรุณาใส่วันสิ้นสุดการลา");
            return false;
        }else{
            if(isValidLeaveRange()){
                var numOfSubForm = document.FrmLeaveReq.<%=thisForm.ELM_NAME_SUB_FORM_COUNT%>.value;
                document.FrmLeaveReq.<%=thisForm.ELM_NAME_SUB_FORM_COUNT%>.value = parseFloat(numOfSubForm) + 1;
                document.FrmLeaveReq.<%=LutGlobalRequestName.TASK_CODE%>.value = "<%=taskCode.REQ_OUT_COUNTRY_LEAVE_2%>";
                return true;
            }else{
                alert("ช่วงเวลาการลาได้มีอยู่แล้ว");
                return false;
            }
        }
    }

    function submitReq(){
        if(document.FrmLeaveReq.<%=thisForm.ELM_NAME_SUB_FORM_COUNT%>.value <= 0){
            alert("กรุณาระบุการลาที่ต้องการใช้สำหรับลาไปต่างประเทศ");
            return false;
        }else if(parseFloat(document.FrmLeaveReq.numOfSubLeaveDay.value) != parseFloat(document.FrmLeaveReq.<%=thisForm.ELM_NAME_LEAVE_DAY_COUNT_MASTER%>.value)){
            alert("จำนวนรวมวันลา ไม่เท่ากับจำนวนวันที่อยู่ต่างประเทศ");
            return false;
        }else{
            return true;
        }
    }
    
    function submitDelete(index){
        document.all["<%=thisForm.ELM_NAME_SUB_FORM_DELETE%>"].value = index;
        document.FrmLeaveReq.<%=LutGlobalRequestName.TASK_CODE%>.value = "<%=taskCode.REQ_OUT_COUNTRY_LEAVE_2%>";
        return true;
    }

    function isValidLeaveRange(){
        //new leave range
        var start = document.FrmLeaveReq.<%=thisForm.ELM_NAME_LEAVE_START_DATE%>.value + document.FrmLeaveReq.<%=thisForm.ELM_NAME_LEAVE_START_DATE_PERIOD%>.value;
        var end = document.FrmLeaveReq.<%=thisForm.ELM_NAME_LEAVE_END_DATE%>.value + document.FrmLeaveReq.<%=thisForm.ELM_NAME_LEAVE_END_DATE_PERIOD%>.value;
        //existing leave range
        var existStart = new Array();
        var existEnd = new Array();
        <%
        for(int i = 0; i < listSubForm.size(); i++){
           FrmLeaveReq tempForm = (FrmLeaveReq)listSubForm.get(i);
           String startDate = tempForm.getValue(tempForm.ELM_NAME_FORM_START_DATE);
           String endDate = tempForm.getValue(tempForm.ELM_NAME_FORM_END_DATE);
           String startDatePeriod = tempForm.getValue(tempForm.ELM_NAME_FORM_START_DATE_PERIOD);
           String endDatePeriod = tempForm.getValue(tempForm.ELM_NAME_FORM_END_DATE_PERIOD);
           %>
           existStart[<%=i%>] = "<%=startDate + startDatePeriod%>";
           existEnd[<%=i%>] = "<%=endDate + endDatePeriod%>";
           <%
        }%>
        for(var i = 0; i < existStart.length; i++){
            //alert('start=' + start + ', end=' + end + '\rexistStart=' + existStart[i] + ', existEnd=' + existEnd[i]);
            if((parseFloat(start) >= parseFloat(existStart[i]) && parseFloat(start) <= parseFloat(existEnd[i])) ||
                (parseFloat(end) >= parseFloat(existStart[i]) && parseFloat(end) <= parseFloat(existEnd[i]))){
                return false;
            }
        }
        return true;
    }
</script>
