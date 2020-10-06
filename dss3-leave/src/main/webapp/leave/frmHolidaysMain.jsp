<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>
<%@page import="java.util.*"%>
<%@page import="gitex.html.*"%>
<%@page import="gitex.tu.*"%>
<%@page import="gitex.tu.htmlForm.*"%>
<%@page import="gitex.utility.*"%>
<%
LeaveReqHtmlPage thisPage = new LeaveReqHtmlPage(session, request);
gitex.utility.Date date = new gitex.utility.Date();
FrmHolidaysMain thisForm = new FrmHolidaysMain(session, request, thisPage.getUser());
int budgetYear = date.getCurrentBudgetYear();
if(!thisForm.getValue(thisForm.ELM_NAME_BUDGET_YEAR).equals("")){
    budgetYear = Integer.parseInt(thisForm.getValue(thisForm.ELM_NAME_BUDGET_YEAR));
}
LeaveHolidays hol = new LeaveHolidays(budgetYear);
%>
<%if(!thisForm.errMsg.equals("")){%>
    <p class="block">
        <strong>เกิดข้อผิดพลาดในการทำงาน : </strong>
        <%=thisForm.errMsg%>
    </p>
<%}%>
<h3>รายการวันหยุดราชการปีงบประมาณ <%=budgetYear + 543%></h3>
<%if(hol.list.size() > 0){%>
<p>
<form name="editFrom" action="index.jsp?#content" method="post">
<input type="hidden" name="<%=thisForm.ELM_NAME_TASK%>" value="<%=thisForm.TASK_DELETE%>"/>
<input type="hidden" name="<%=thisForm.ELM_NAME_BUDGET_YEAR%>" value="<%=budgetYear%>"/>
<table width="100%" id="content" cellspacing="1">
<tr>
<td class="tblHeader center" width="10%">ลำดับ</td>
<td class="tblHeader" width="30%">วันที่</td>
<td class="tblHeader" width="50%">ชื่อวัน</td>
<td class="tblHeader center" width="10%">ลบออก</td>
</tr>
<%for(int i = 0; i < hol.list.size(); i++){
    String hId = ((Hashtable)hol.list.get(i)).get(hol.ID).toString();    
    String hDate = ((Hashtable)hol.list.get(i)).get(hol.DATE).toString();
    String txtDate = date.getDate(hDate, date.MONTH_NAME_FULL).get(date.DATE_THAI).toString();
    String hName = ((Hashtable)hol.list.get(i)).get(hol.NAME).toString();
    %>
    <tr>
    <td class="tblRow<%=i%2%> center"><%=i + 1%></td>
    <td class="tblRow<%=i%2%>"><%=txtDate%></td>
    <td class="tblRow<%=i%2%>"><%=hName%></td>
    <td class="tblRow<%=i%2%> center"><input type="checkbox" name="<%=thisForm.ELM_NAME_ID%>" value="<%=hId%>"/></td>
    </tr>
    <%
}%>
    <tr>
    <td class="tblRow0 center" colspan="3">&nbsp;</td>
    <td class="tblRow0 center"><input type="submit" name="bSubmit" value="   ลบ   " onclick="return confirm('กรุณายืนยันการลบข้อมูลอีกครั้ง');"/></td>
    </tr>
</table>
</form>
</p>
<p class="block">
<strong>คำแนะนำ : </strong>การแก้ไขรายการใดๆ ทำได้โดยการลบรายการนั้นออก แล้วเพิ่มรายการนั้นใหม่ด้วยข้อมูลที่ถูกต้อง
</p>
<%}else{%>
<p class="block center">ไม่พบรายการวันหยุดราชการ</p>
<%}%>
<form name="searchForm" action="index.jsp?#content" method="post">
    <strong></strong><img src="images/spacer.gif" width="225" height="1" /><br/>
    <span>แสดงวันหยุดในปีงบประมาณ : </span><input type="text" name="frmElmBudgetYear" value="<%=budgetYear + 543%>" style="width:35px;text-align:center;"/>
    <input type="hidden" name="<%=thisForm.ELM_NAME_BUDGET_YEAR%>" value="<%=budgetYear%>"/>
    <input type="button" name="btnSubmit" value=" แสดง " onclick="submitSearchForm();"/>    
</form>    
<script>
    function submitSearchForm(){
        var budgetYear = document.searchForm.frmElmBudgetYear.value;
        if(!isNaN(budgetYear) && budgetYear != "") budgetYear -= 543;
        else budgetYear = "";
        document.searchForm.<%=thisForm.ELM_NAME_BUDGET_YEAR%>.value = budgetYear;        
        document.searchForm.submit();
    }    
</script>
<form name="addForm" action="index.jsp?#content" method="post">
    <p class="right" style="width:300px;">
    <strong>เพิ่มวันหยุด</strong><img src="images/spacer.gif" width="225" height="1" /><br/>
    ปีงบประมาณ : <a id="frmElmBudgetYear"><%=budgetYear + 543%></a><img src="images/spacer.gif" width="179" height="1" /><br/>
    <input type="hidden" name="<%=thisForm.ELM_NAME_BUDGET_YEAR%>" value="<%=budgetYear%>"/>
    ชื่อวันหยุด : <input type="text" name="<%=thisForm.ELM_NAME_NAME%>" value=""/><br/>
    วันที่ : <input type="text" name="txtHDate" style="position:relative;" value="" onKeyDown="click();return false;" onClick="window.event.cancelBubble=true;setCalendarCaller(this, '<%=thisForm.ELM_NAME_DATE%>', this.offsetTop, this.offsetLeft);"/><br/>
    <input type="hidden" name="<%=thisForm.ELM_NAME_DATE%>" value=""/>
    <input type="button" name="btnSubmit" value=" บันทึก " onclick="submitAddForm();"/>    
    <input type="button" name="btnReset" value=" เริ่มใหม่ " onclick="clearAddForm();"/>
    <img src="images/spacer.gif" width="90" height="1" />    
    <input type="hidden" name="<%=thisForm.ELM_NAME_TASK%>" value="<%=thisForm.TASK_ADD%>"/>
    </p>
</form>    
<jsp:include page="includes/calendar.jsp"></jsp:include>
<script language="JavaScript">
    document.addForm.<%=thisForm.ELM_NAME_NAME%>.style.width = "205px";
    document.addForm.<%=thisForm.ELM_NAME_BUDGET_YEAR%>.style.width = "205px";
    document.addForm.txtHDate.style.width = "205px";
    
    function clearAddForm(){
        document.addForm.<%=thisForm.ELM_NAME_DATE%>.value = "";
        document.addForm.txtHDate.value = "";
        document.addForm.<%=thisForm.ELM_NAME_NAME%>.value = "";
    }
    
    function submitAddForm(){
        var name = document.addForm.<%=thisForm.ELM_NAME_NAME%>.value;
        if(name == ""){
            alert("กรุณาระบุชื่อวันหยุด");
            document.addForm.<%=thisForm.ELM_NAME_NAME%>.focus();
            return;
        }
        var budgetYear = document.addForm.<%=thisForm.ELM_NAME_BUDGET_YEAR%>.value;
        var date = document.addForm.<%=thisForm.ELM_NAME_DATE%>.value;
        var minDate =  (parseFloat(budgetYear) - 1) + '1001';
        var maxDate =  budgetYear + '0930';
        if( date == '' || date < minDate || date > maxDate){
            alert("วันหยุดไม่ได้ระบุวันที่ หรือ ไม่อยู่ในปีงบประมาณ");
            document.addForm.<%=thisForm.ELM_NAME_DATE%>.value = "";
            document.addForm.txtHDate.value = "";
            document.addForm.txtHDate.focus();
            return;
        }
        document.addForm.submit();
    }
</script>
<form name="coppyForm" action="index.jsp?#content" method="post">
    <strong></strong><img src="images/spacer.gif" width="225" height="1" /><br/>
    <span>สร้างสำเนาวันหยุด<strong>จาก</strong>ปีงบประมาณ : </span><input type="text" name="frmElmBudgetYear" value="<%=budgetYear + 543 - 1%>" style="width:35px;text-align:center;"/>
    <input type="hidden" name="<%=thisForm.ELM_NAME_BUDGET_YEAR_TO_COPPY%>" value=""/>
    <input type="hidden" name="<%=thisForm.ELM_NAME_BUDGET_YEAR%>" value="<%=budgetYear%>"/>
    <input type="hidden" name="<%=thisForm.ELM_NAME_TASK%>" value="<%=thisForm.TASK_COPPY%>"/>
    <input type="button" name="btnSubmit" value=" สร้างสำเนา " onclick="submitCopyForm();"/>    
</form>    
<script>
    function submitCopyForm(){
        var fromYear = document.coppyForm.frmElmBudgetYear.value;
        if(!isNaN(fromYear) && fromYear != ""){
            if(confirm("กรุณายืนยันการสร้างสำเนาวันหยุดอีกครั้ง")){
                fromYear -= 543;
                document.coppyForm.<%=thisForm.ELM_NAME_BUDGET_YEAR_TO_COPPY%>.value = fromYear;        
                document.coppyForm.submit();
            }
        }else{
            alert("ปีงบประมาณไม่ถูกต้อง");
            document.coppyForm.frmElmBudgetYear.value = "";
            document.coppyForm.frmElmBudgetYear.focus();
        }
    }    
</script>
</p>
