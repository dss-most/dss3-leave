<%@page contentType="text/html"%>
<%@page pageEncoding="TIS-620"%>
<%@page import="java.util.*"%>
<%@page import="gitex.tu.*"%>
<%@page import="gitex.tu.htmlForm.*"%>
<%@page import="gitex.utility.*"%>
<%
LeaveReqHtmlPage thisPage = new LeaveReqHtmlPage(session, request);
//Employee employee = thisPage.getUser().employee;

Employee employee = thisPage.getUser().employee;

//ยกเลิกเนื่องจากไม่มีการมาสายแล้ว
//Period per = new Period();
//per.setPeriod(Integer.parseInt(employee.empId),Integer.parseInt(request.getParameter("budgetYear")));



//out.println(employee.empId);   emp_id
gitex.utility.Date date = new gitex.utility.Date();
int budgetYear = date.getCurrentBudgetYear();

//out.println(request.getParameter("budgetYear"));   budgetYear

if(request.getParameter("budgetYear") != null){
    budgetYear = Integer.parseInt(request.getParameter("budgetYear"));
}


employee.getLeaveStat(budgetYear);
employee.getLeaveStat(employee.PERIOD_FIRST_HALF_YEAR, budgetYear);
employee.getLeaveStat(employee.PERIOD_SECOND_HALF_YEAR, budgetYear);
employee.getReqCount(employee.PERIOD_FIRST_HALF_YEAR, budgetYear);
employee.getReqCount(employee.PERIOD_SECOND_HALF_YEAR, budgetYear);
%>
<!-- 
<h3>สถิติการลาปีในปีงบประมาณ <%=budgetYear + 543%></h3>
-->
<%if(employee.leaveCategoryId.size() > 0){%>
<p>
<table width="100%" cellspacing="1">
<tr>
<td class="tblHeader center" width="45%" rowspan="2">ประเภทการลา</td>
<td class="tblHeader center" width="55%" colspan="3" style="padding-right:5px;">จำนวนวันที่ลา/จำนวนครั้งการลา</td>
</tr>
<tr>
<td class="tblHeader center" width="20%" style="padding-right:5px;">ต.ค. - มี.ค.</td>
<td class="tblHeader center" width="20%" style="padding-right:5px;">เม.ย. - ก.ย.</td>
<td class="tblHeader center" width="15%" style="padding-right:5px;">ทั้งหมด</td>
</tr>
<%for(int i = 0; i < employee.leaveCategoryId.size(); i++){
    double numOfLeaveOn1stHalf = employee.getNumOfLeaveDay(employee.leaveCategoryId.get(i).toString(), employee.PERIOD_FIRST_HALF_YEAR);
    double numOfLeaveOn2ndHalf = employee.getNumOfLeaveDay(employee.leaveCategoryId.get(i).toString(), employee.PERIOD_SECOND_HALF_YEAR);
    double numOfReqOn1stHalf = employee.getNumOfRequest(employee.leaveCategoryId.get(i).toString(), employee.PERIOD_FIRST_HALF_YEAR);
    double numOfReqOn2ndHalf = employee.getNumOfRequest(employee.leaveCategoryId.get(i).toString(), employee.PERIOD_SECOND_HALF_YEAR);
    %>
    <tr>
    <td class="tblRow<%=i % 2%>"><%=employee.getLeaveCategoryName(employee.leaveCategoryId.get(i).toString())%><%if(employee.isLeaveOutOfLimit(employee.leaveCategoryId.get(i).toString())){%>*<%}%></td>
    <td class="tblRow<%=i % 2%> center" style="padding-right:5px;"><%=numOfLeaveOn1stHalf + "/" + numOfReqOn1stHalf%></td>
    <td class="tblRow<%=i % 2%> center" style="padding-right:5px;"><%=numOfLeaveOn2ndHalf + "/" + numOfReqOn2ndHalf%></td>
    <td class="tblRow<%=i % 2%> center" style="padding-right:5px;"><%=(numOfLeaveOn1stHalf + numOfLeaveOn2ndHalf) + "/" + (numOfReqOn1stHalf + numOfReqOn2ndHalf)%></td>
    </tr>
<%}%>
</table>
<!-- ยกเลิกการแสดงผลข้อมูลการมาสาย -->
<!-- 
<%//if(employee.labsTypeList.size() > 0){%>
    <h3>สถิติการมาสาย </h3>
    <h4>ข้อมูลสิ้นสุด ณ วันที่ 30 มิถุนายน 2563</h4>
    <p>
    <table width="100%">
    <tr>
    <td class="tblHeader" width="45%">รายการ</td>
    <td class="tblHeader" width="20%" style="padding-right:5px;"><div align="center">&#3605;.&#3588;. - &#3617;&#3637;.&#3588;.</div></td>
    <td class="tblHeader" width="18%" style="padding-right:5px;"><div align="center">&#3648;&#3617;.&#3618;. - &#3585;.&#3618;.</div></td>
    <td class="tblHeader center" width="17%" style="padding-right:5px;">จำนวนวัน</td>
    </tr>
    <%
    //FrmLateAbsent labsForm = new FrmLateAbsent();
    //for(int i = 0; i < employee.labsTypeList.size(); i++){%>
    <tr>
    <td class="tblRow<%//=i % 2%>"><%//=labsForm.getTypeName(employee.labsTypeList.get(i).toString())%></td>
    <td class="tblRow<%//=i % 2%>"><div align="center"><%//=per.per1%></div></td>
    <td class="tblRow<%//=i % 2%>"><div align="center"><%//=per.per2%></div></td>
    <td class="tblRow<%//=i % 2%> center"><%//=Integer.parseInt(per.per1)+Integer.parseInt(per.per2)%><%//=employee.getNumOfLabs(employee.labsTypeList.get(i).toString())%></td>
    </tr>
    <%//}%>
    </table>
<%//}%>
-->

</p>
<p class="block"><strong>หมายเหตุ 1 : </strong>* หมายถึง ลาเกินสิทธิ์</p>
<p class="block">
<strong>หมายเหตุ 2 : </strong>
จะไม่มีการเลื่อนขั้นเงินเดือน ถ้า<strong>ลาป่วยรวมกับลากิจ</strong>ในรอบ 6 เดือนแรกหรือหลัง มีจำนวนการขอลาเกิน 11 ครั้ง หรือ จำนวนวันลาเกิน 23 วัน 
<!-- และ<strong>สายได้ไม่เกิน 15 วัน</strong>-->
</p>
<%}else{%>
<p class="block center">ไม่มีการลาในปีงบประมาณนี้</p>
<%}%>
