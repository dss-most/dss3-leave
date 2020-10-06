<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>
<%@page import="gitex.utility.*"%>
<%
Date date = new Date();
String thaiYear = date.getDate(date.DATE_THAI).substring(0, 4);
%>
<style>
#calendar{
    font-family:tahoma, "ms sans serif";
    font-size:12px;
}  
#calendar a{
    color:#000000;
    text-decoration:none;
}
#calendar a:visited{
    text-decoration:none;
}
#calendar a:hover{
    text-decoration:none;
    font-weight:bold;
}
.cButton{
        font-size:10px;
	width:18px;
        height:20px;
	color:#000000;
	text-align:center;
}
.tab{
	padding: 1px;
	font-size:11px;
	text-align:center;
}
.cMonth{
	color:#000000;
	background-color:#FFFFDD;
	border: solid #A0A0A0 1px;
	padding: 2px 2px 2px 2px;
	font-size:11px;
	text-align:center;
}
.cDay{
	color:#000000;
	background-color:#AAEEEE;
	border: solid #A0A0A0 1px;
	padding: 1px 2px 1px 2px;
	font-size:11px;
	text-align:center;
        cursor:hand;
}
</style>
<script language="JavaScript">
function validateYear(yearObj){
	if(isNaN(yearObj.value)){
		dateObj = new Date();
		yearObj.value = dateObj.getYear();
	}else{
		yearObj.value = parseFloat(yearObj.value);
	}
	setCalendarDate(yearObj.value, document.selectedMonth, document.selectedDay)
}
function setSelectedMonth(monthNum){
    //alert('month num 3 =' + monthNum);
    document.all['cm' + monthNum].style.backgroundColor = "#FFFFFF";
    document.all['cm' + monthNum].style.fontWeight = "bold";
    if(document.oldMonthObj) {
            if(document.oldMonthObj != document.all['cm' + monthNum]){
                    document.oldMonthObj.style.backgroundColor = "#FFFFDD";
                    document.oldMonthObj.style.fontWeight = "normal";
            }
    }
    document.oldMonthObj = document.all['cm' + monthNum];
    document.selectedMonth = monthNum + 1;
}
function setCalendarDate(year, month, day){	
	//Gen day number
	dateObj = new Date()
	if(isNaN(year) || year <= 0){
		year = dateObj.getYear();
	}else{
            year = parseFloat(year);
        }
        //alert("year=" + year);
        if(year > 2250) year -= 543;
        document.all["cYear"].value = year + 543;        
    
        //alert('month num1 =' + month);
	if(isNaN(month) || month < 0 || month > 11){
		month = dateObj.getMonth();
	}
        //alert('month num 2 =' + month);
	setSelectedMonth(parseFloat(month));
	
	if(!day || isNaN(day) || day < 1 || day > 31){
            if(document.selectedDay){ 
                day = document.selectedDay;
            }else{
                day = (new Date()).getDate();
            }
	}
        //alert("day = " + day);
	dateObj = new Date(year, month, 1)
	dayNum = dateObj.getDay();
	//alert("first day is " + dayNum + ".");
	if(month == 3 || month == 5 || month == 8 || month == 10) 
		dayMax = 30;
	else if(month ==1){
		if(year % 4 == 0) dayMax = 29;
		else dayMax = 28;
	}else dayMax = 31;
	//alert("monthNum=" + monthNum + ", dayMax=" + dayMax);
	dayIndex = 0;
	for(i = 0; i < 6; i++){
		for(j = 0; j < 7; j++){
			if(dayIndex >= dayNum && dayIndex < (dayMax + dayNum)){
				document.all["c" + i + j].innerHTML = (dayIndex - dayNum) + 1;
				document.all["c" + i + j].style.visibility = "visible";
				if((dayIndex - dayNum) + 1 == day){
                                    document.all["c" + i + j].style.backgroundColor = "#FFFFFF";
				}else{
                                    document.all["c" + i + j].style.backgroundColor = "#AAEEEE";
				}
			}else{
				document.all["c" + i + j].innerHTML = " ";
				document.all["c" + i + j].style.visibility = "hidden";
			}
			dayIndex++;
		}
	}
}
function setCalendarPosition(top, left){
	//alert("top=" + top + ", left=" + left);
	document.all['calendar'].style.top = top;
	document.all['calendar'].style.left = left;
}
function setCalendarCaller(objText, nameDate, top, left){
	document.calendarObjText = objText;
	document.calendarNameDate = nameDate;
	setCalendarPosition(top, left);
        var YYYYMMDD = document.all[nameDate].value;
        if(YYYYMMDD == '') YYYYMMDD = 'yyyy00dd';
	setCalendarDate(YYYYMMDD.substring(0, 4), parseFloat(YYYYMMDD.substring(4, 6)) -1, YYYYMMDD.substring(6, 8));
	//Hide select input type
	var selectElm = document.getElementsByTagName("select");
	for(i = 0; i < selectElm.length; i++){
		selectElm[i].style.visibility = "hidden";
	}
	document.all['calendar'].style.display = "inline";
	document.all['calendar'].style.visibility = "visible";
}
function setCalendarSelectedDate(){
    var YYYY = parseFloat(document.all['cYear'].value);
    if(YYYY > 2250) YYYY -= 543;
    YYYY = new String(YYYY + 10000);
    YYYY = YYYY.substring(1);
    var MM = document.selectedMonth;
    if(MM < 10) MM = '0' + MM;
    if(!document.selectedDay) document.selectedDay = (new Date()).getDate();
    var DD = document.selectedDay;
    if(DD < 10) DD = '0' + DD;
    document.all[document.calendarNameDate].value = YYYY + MM + DD;
    setDateDisplayText(document.calendarObjText, YYYY+MM+DD);
}
function setDateDisplayText(calendarObjText, YYYYMMDD){
    if(YYYYMMDD != ''){
        //alert('YYYYMMDD=' + document.all[document.calendarNameDate].value);
        //monthName = new Array("Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec");
        monthName = new Array("มกราคม", "กุมภาพันธ์", "มีนาคม", "เมษายน", "พฤษภาคม", "มิถุนายน", "กรกฏาคม", "สิงหาคม", "กันยายน", "ตุลาคม", "พฤศจิกายน", "ธันวาคม");
        monthPrefix = "";
        dayPrefix = "";
        calendarObjText.value = dayPrefix + parseFloat(YYYYMMDD.substring(6,8)) + " " + monthName[parseFloat(YYYYMMDD.substring(4,6)) - 1] + " พ.ศ." + (parseFloat(YYYYMMDD.substring(0,4)) + 543);
        if(!calendarObjText.disabled){
            calendarObjText.focus();
            calendarObjText.blur();
        }
        //hideCalendar();
    }
}
function hideCalendar(){
	//document.all['calendar'].style.visibility = "hidden";
	document.all['calendar'].style.display = "none";
	for(i = 0; i < 6; i++){
		for(j = 0; j < 7; j++){
			document.all["c" + i + j].style.visibility = "hidden";
		}
	}
	//Display all select element wish was set to hidden.
	var selectElm = document.getElementsByTagName("select");
	for(i = 0; i < selectElm.length; i++){
		selectElm[i].style.visibility = "visible";
	}
}
function setSelectedDay(objDay){
    document.selectedDay = objDay.innerText;
    setCalendarSelectedDate();
    hideCalendar();
}
function noAction(){}
</script>
<div id="calendar" style="position:absolute;display:none;">
<table width="200" cellpadding="2" cellspacing="0" border="0" style="border:solid #CCCCCC 1px;background-color:#EEEEEE;" onClick="window.event.cancelBubble=true;">
	<tr>
                <td align="center">พ.ศ. <input type="text" name="cYear" style="font-size:10px;width:35px;text-align:center;" value="" onChange="validateYear(this);setCalendarSelectedDate();">
                        <input class="cButton" type="button" value="<" onClick="window.event.cancelBubble=true;document.all['cYear'].value--;setCalendarDate(document.all['cYear'].value, document.selectedMonth);setCalendarSelectedDate();">
                        <input class="cButton" type="button" value=">" onClick="window.event.cancelBubble=true;document.all['cYear'].value++;setCalendarDate(document.all['cYear'].value, document.selectedMonth);setCalendarSelectedDate();">
		</td>
	</tr>
	<tr>
		<td align="center">
			<table cellpadding="0" cellspacing="1" border="0" width="200">
				<tr>
					<td class="cMonth" id="cm0"><a href="javascript:noAction();" onClick="setCalendarDate(document.all['cYear'].value, 0, document.selectedDate);setCalendarSelectedDate();">ม.ค.</a></td>
					<td class="cMonth" id="cm1"><a href="javascript:noAction();" onClick="setCalendarDate(document.all['cYear'].value, 1, document.selectedDate);setCalendarSelectedDate();">ก.พ.</a></td>
					<td class="cMonth" id="cm2"><a href="javascript:noAction();" onClick="setCalendarDate(document.all['cYear'].value, 2, document.selectedDate);setCalendarSelectedDate();">มี.ค.</a></td>
					<td class="cMonth" id="cm3"><a href="javascript:noAction();" onClick="setCalendarDate(document.all['cYear'].value, 3, document.selectedDate);setCalendarSelectedDate();">เม.ย.</a></td>
					<td class="cMonth" id="cm4"><a href="javascript:noAction();" onClick="setCalendarDate(document.all['cYear'].value, 4, document.selectedDate);setCalendarSelectedDate();">พ.ค.</a></td>
					<td class="cMonth" id="cm5"><a href="javascript:noAction();" onClick="setCalendarDate(document.all['cYear'].value, 5, document.selectedDate);setCalendarSelectedDate();">มิ.ย.</a></td>
				</tr>
				<tr>
					<td class="cMonth" id="cm6"><a href="javascript:noAction();" onClick="setCalendarDate(document.all['cYear'].value, 6, document.selectedDate);setCalendarSelectedDate();">ก.ค.</a></td>
					<td class="cMonth" id="cm7"><a href="javascript:noAction();" onClick="setCalendarDate(document.all['cYear'].value, 7, document.selectedDate);setCalendarSelectedDate();">ส.ค.</a></td>
					<td class="cMonth" id="cm8"><a href="javascript:noAction();" onClick="setCalendarDate(document.all['cYear'].value, 8, document.selectedDate);setCalendarSelectedDate();">ก.ย.</a></td>
					<td class="cMonth" id="cm9"><a href="javascript:noAction();" onClick="setCalendarDate(document.all['cYear'].value, 9, document.selectedDate);setCalendarSelectedDate();">ต.ค.</a></td>
					<td class="cMonth" id="cm10"><a href="javascript:noAction();" onClick="setCalendarDate(document.all['cYear'].value, 10, document.selectedDate);setCalendarSelectedDate();">พ.ย.</a></td>
					<td class="cMonth" id="cm11"><a href="javascript:noAction();" onClick="setCalendarDate(document.all['cYear'].value, 11, document.selectedDate);setCalendarSelectedDate();">ธ.ค.</a></td>
				</tr>
			</table>
		</td>
	</tr>
	<tr>
		<td align="center">
			<table cellpadding='0' cellspacing='1' border='0' width="200">
				<tr>
					<td class='tab'>อา</td>
					<td class='tab'>จ</td>
					<td class='tab'>อ</td>
					<td class='tab'>พ</td>
					<td class='tab'>พฤ</td>
					<td class='tab'>ศ</td>
					<td class='tab'>ส</td>
				</tr>
				<tr>
					<td class="cDay" id="c00" onClick="setSelectedDay(this)" onmouseover="this.style.fontWeight='bold';" onmouseout="this.style.fontWeight='normal';">&nbsp;</td>
					<td class="cDay" id="c01" onClick="setSelectedDay(this)" onmouseover="this.style.fontWeight='bold';" onmouseout="this.style.fontWeight='normal';">&nbsp;</td>
					<td class="cDay" id="c02" onClick="setSelectedDay(this)" onmouseover="this.style.fontWeight='bold';" onmouseout="this.style.fontWeight='normal';">&nbsp;</td>
					<td class="cDay" id="c03" onClick="setSelectedDay(this)" onmouseover="this.style.fontWeight='bold';" onmouseout="this.style.fontWeight='normal';">&nbsp;</td>
					<td class="cDay" id="c04" onClick="setSelectedDay(this)" onmouseover="this.style.fontWeight='bold';" onmouseout="this.style.fontWeight='normal';">&nbsp;</td>
					<td class="cDay" id="c05" onClick="setSelectedDay(this)" onmouseover="this.style.fontWeight='bold';" onmouseout="this.style.fontWeight='normal';">&nbsp;</td>
					<td class="cDay" id="c06" onClick="setSelectedDay(this)" onmouseover="this.style.fontWeight='bold';" onmouseout="this.style.fontWeight='normal';">&nbsp;</td>
				</tr>
				<tr>
					<td class="cDay" id="c10" onClick="setSelectedDay(this)" onmouseover="this.style.fontWeight='bold';" onmouseout="this.style.fontWeight='normal';">&nbsp;</td>
					<td class="cDay" id="c11" onClick="setSelectedDay(this)" onmouseover="this.style.fontWeight='bold';" onmouseout="this.style.fontWeight='normal';">&nbsp;</td>
					<td class="cDay" id="c12" onClick="setSelectedDay(this)" onmouseover="this.style.fontWeight='bold';" onmouseout="this.style.fontWeight='normal';">&nbsp;</td>
					<td class="cDay" id="c13" onClick="setSelectedDay(this)" onmouseover="this.style.fontWeight='bold';" onmouseout="this.style.fontWeight='normal';">&nbsp;</td>
					<td class="cDay" id="c14" onClick="setSelectedDay(this)" onmouseover="this.style.fontWeight='bold';" onmouseout="this.style.fontWeight='normal';">&nbsp;</td>
					<td class="cDay" id="c15" onClick="setSelectedDay(this)" onmouseover="this.style.fontWeight='bold';" onmouseout="this.style.fontWeight='normal';">&nbsp;</td>
					<td class="cDay" id="c16" onClick="setSelectedDay(this)" onmouseover="this.style.fontWeight='bold';" onmouseout="this.style.fontWeight='normal';">&nbsp;</td>
				</tr>
				<tr>
					<td class="cDay" id="c20" onClick="setSelectedDay(this)" onmouseover="this.style.fontWeight='bold';" onmouseout="this.style.fontWeight='normal';">&nbsp;</td>
					<td class="cDay" id="c21" onClick="setSelectedDay(this)" onmouseover="this.style.fontWeight='bold';" onmouseout="this.style.fontWeight='normal';">&nbsp;</td>
					<td class="cDay" id="c22" onClick="setSelectedDay(this)" onmouseover="this.style.fontWeight='bold';" onmouseout="this.style.fontWeight='normal';">&nbsp;</td>
					<td class="cDay" id="c23" onClick="setSelectedDay(this)" onmouseover="this.style.fontWeight='bold';" onmouseout="this.style.fontWeight='normal';">&nbsp;</td>
					<td class="cDay" id="c24" onClick="setSelectedDay(this)" onmouseover="this.style.fontWeight='bold';" onmouseout="this.style.fontWeight='normal';">&nbsp;</td>
					<td class="cDay" id="c25" onClick="setSelectedDay(this)" onmouseover="this.style.fontWeight='bold';" onmouseout="this.style.fontWeight='normal';">&nbsp;</td>
					<td class="cDay" id="c26" onClick="setSelectedDay(this)" onmouseover="this.style.fontWeight='bold';" onmouseout="this.style.fontWeight='normal';">&nbsp;</td>
				</tr>
				<tr>
					<td class="cDay" id="c30" onClick="setSelectedDay(this)" onmouseover="this.style.fontWeight='bold';" onmouseout="this.style.fontWeight='normal';">&nbsp;</td>
					<td class="cDay" id="c31" onClick="setSelectedDay(this)" onmouseover="this.style.fontWeight='bold';" onmouseout="this.style.fontWeight='normal';">&nbsp;</td>
					<td class="cDay" id="c32" onClick="setSelectedDay(this)" onmouseover="this.style.fontWeight='bold';" onmouseout="this.style.fontWeight='normal';">&nbsp;</td>
					<td class="cDay" id="c33" onClick="setSelectedDay(this)" onmouseover="this.style.fontWeight='bold';" onmouseout="this.style.fontWeight='normal';">&nbsp;</td>
					<td class="cDay" id="c34" onClick="setSelectedDay(this)" onmouseover="this.style.fontWeight='bold';" onmouseout="this.style.fontWeight='normal';">&nbsp;</td>
					<td class="cDay" id="c35" onClick="setSelectedDay(this)" onmouseover="this.style.fontWeight='bold';" onmouseout="this.style.fontWeight='normal';">&nbsp;</td>
					<td class="cDay" id="c36" onClick="setSelectedDay(this)" onmouseover="this.style.fontWeight='bold';" onmouseout="this.style.fontWeight='normal';">&nbsp;</td>
				</tr>
				<tr>
					<td class="cDay" id="c40" onClick="setSelectedDay(this)" onmouseover="this.style.fontWeight='bold';" onmouseout="this.style.fontWeight='normal';">&nbsp;</td>
					<td class="cDay" id="c41" onClick="setSelectedDay(this)" onmouseover="this.style.fontWeight='bold';" onmouseout="this.style.fontWeight='normal';">&nbsp;</td>
					<td class="cDay" id="c42" onClick="setSelectedDay(this)" onmouseover="this.style.fontWeight='bold';" onmouseout="this.style.fontWeight='normal';">&nbsp;</td>
					<td class="cDay" id="c43" onClick="setSelectedDay(this)" onmouseover="this.style.fontWeight='bold';" onmouseout="this.style.fontWeight='normal';">&nbsp;</td>
					<td class="cDay" id="c44" onClick="setSelectedDay(this)" onmouseover="this.style.fontWeight='bold';" onmouseout="this.style.fontWeight='normal';">&nbsp;</td>
					<td class="cDay" id="c45" onClick="setSelectedDay(this)" onmouseover="this.style.fontWeight='bold';" onmouseout="this.style.fontWeight='normal';">&nbsp;</td>
					<td class="cDay" id="c46" onClick="setSelectedDay(this)" onmouseover="this.style.fontWeight='bold';" onmouseout="this.style.fontWeight='normal';">&nbsp;</td>
				</tr>
				<tr>
					<td class="cDay" id="c50" onClick="setSelectedDay(this)" onmouseover="this.style.fontWeight='bold';" onmouseout="this.style.fontWeight='normal';">&nbsp;</td>
					<td class="cDay" id="c51" onClick="setSelectedDay(this)" onmouseover="this.style.fontWeight='bold';" onmouseout="this.style.fontWeight='normal';">&nbsp;</td>
					<td class="cDay" id="c52" onClick="setSelectedDay(this)" onmouseover="this.style.fontWeight='bold';" onmouseout="this.style.fontWeight='normal';">&nbsp;</td>
					<td class="cDay" id="c53" onClick="setSelectedDay(this)" onmouseover="this.style.fontWeight='bold';" onmouseout="this.style.fontWeight='normal';">&nbsp;</td>
					<td class="cDay" id="c54" onClick="setSelectedDay(this)" onmouseover="this.style.fontWeight='bold';" onmouseout="this.style.fontWeight='normal';">&nbsp;</td>
					<td class="cDay" id="c55" onClick="setSelectedDay(this)" onmouseover="this.style.fontWeight='bold';" onmouseout="this.style.fontWeight='normal';">&nbsp;</td>
					<td class="cDay" id="c56" onClick="setSelectedDay(this)" onmouseover="this.style.fontWeight='bold';" onmouseout="this.style.fontWeight='normal';">&nbsp;</td>
				</tr>
			</table>
		</td>
	</tr>
</table>
</div>
