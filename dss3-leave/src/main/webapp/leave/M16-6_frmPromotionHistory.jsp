<%@page contentType="text/html"%>
<%@page pageEncoding="TIS-620"%>
<%@page import="java.util.*"%>
<%@page import="gitex.html.*"%>
<%@page import="gitex.tu.*"%>
<%@page import="gitex.tu.htmlForm.*"%>
<%@page import="gitex.utility.*"%>
<%@page import="java.text.DecimalFormat"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
LeaveReqHtmlPage thisPage = new LeaveReqHtmlPage(session, request);
Employee employee = thisPage.getUser().employee;

FrmPromotionHistory thisForm = new FrmPromotionHistory(session, request);
thisForm.setInfo(employee.idCardNo);

DecimalFormat formatter = new DecimalFormat("#,###");
%>
<div>
<p style="padding-left:10px;">
	ประวัติการขึ้นเงินเดือน
</p>
</div>
<div>

</div> 
<%if(thisForm.formList.size() > 0){%>
<p>
<table width="100%">
<tr>
<td class="tblHeader" width="20%">รอบการเลื่อน</td>   
<td class="tblHeader" width="30%">ตำแหน่ง/สังกัด</td>
<td class="tblHeader" width="25%">เงินเดือนก่อนเลื่อน</td>
<td class="tblHeader" width="25%">ฐานในการคำนวณ</td>
<td class="tblHeader" width="25%">ร้อยละที่ได้เลื่อน</td>
<td class="tblHeader" width="25%">จำนวนเงินที่ได้เลื่อน</td>
<td class="tblHeader" width="25%">เงินเดือนหลังเลื่อน</td>
<td class="tblHeader" width="25%">ค่าครองชีพ</td>
<td class="tblHeader" width="25%">ผลการประเมิน</td>
<td class="tblHeader" width="25%">หมายเหตุ</td>
</tr>
<%for(int i = 0; i < thisForm.formList.size(); i++){
	Hashtable row = (Hashtable)thisForm.formList.get(i);
	String fiscalYear = row.get(FrmPromotionReq.ELM_NAME_FISCALYEAR).toString();
	String fiscalNo = row.get(FrmPromotionReq.ELM_NAME_FISCAL_NO).toString();
	String title = row.get(FrmPromotionReq.ELM_NAME_EMP_TITLE).toString();
	String titleLevel = row.get(FrmPromotionReq.ELM_NAME_EMP_TITLE_LEVEL).toString();
	String titleNo = row.get(FrmPromotionReq.ELM_NAME_EMP_TITLE_NO).toString();
	
	String salaryBeforePromotion = row.get(FrmPromotionReq.ELM_NAME_SALARY_BEFORE_PROMOTION).toString();
	String salaryBase = row.get(FrmPromotionReq.ELM_NAME_SALARY_BASE).toString().length()==0?null:row.get(FrmPromotionReq.ELM_NAME_SALARY_BASE).toString();
	String salaryPromotion = row.get(FrmPromotionReq.ELM_NAME_SALARY_PROMTION).toString();
	String salaryAfterPromotion = row.get(FrmPromotionReq.ELM_NAME_SALARY_AFTER_PROMOTION).toString();
	
	String addtionalAllowance = row.get(FrmPromotionReq.ELM_NAME_ADDITIONAL_ALLOWANCE).toString().length()==0?null:row.get(FrmPromotionReq.ELM_NAME_ADDITIONAL_ALLOWANCE).toString();
	
	String assessmentLevel = row.get(FrmPromotionReq.ELM_NAME_ASSESSMENT_LEVEL).toString();

    String percentPromotion = row.get(FrmPromotionReq.ELM_NAME_PERCENT_PROMOTION).toString();
    String remark = row.get(FrmPromotionReq.ELM_NAME_REMARK).toString();
    
%>
<tr>
<td class="tblRow<%=i%2%>">ปี <%=fiscalYear%> <%if(!fiscalNo.equals("0")) { %>  ครั้งที่ <%=fiscalNo%> <%	}%></td>
<td class="tblRow<%=i%2%>"><%=title%> <%=titleLevel%>  (ตำแหน่งเลขที่ <%=titleNo%>)</td>
<td class="tblRow<%=i%2%>"><%= formatter.format( Integer.parseInt(salaryBeforePromotion)) %></td>
<td class="tblRow<%=i%2%>"><%= salaryBase!=null?formatter.format( Integer.parseInt(salaryBase)):"" %></td>
<td class="tblRow<%=i%2%>"><%=percentPromotion %></td>
<td class="tblRow<%=i%2%>"><%= salaryPromotion!=null?formatter.format( Integer.parseInt(salaryPromotion)):"" %></td>
<td class="tblRow<%=i%2%>"><%= salaryAfterPromotion!=null?formatter.format( Integer.parseInt(salaryAfterPromotion)):"" %></td>
<td class="tblRow<%=i%2%>"><%= addtionalAllowance!=null?formatter.format( Integer.parseInt(addtionalAllowance)):"" %></td>
<td class="tblRow<%=i%2%>"><%=assessmentLevel %></td>
<td class="tblRow<%=i%2%>"><%=remark%></td>
</tr>
<%}%>
</table>
<p class="block">
<strong>หมายเหตุ : </strong>หากมีข้อสงสัย กรุณาติดต่อ ฝ่ายทรัพยากรบุคคล สำนักงานเลขานุการกรม
</p>
<%}else{%>
<p class="block center">ไม่พบประวัติการขึ้นเงินเดือน</p>
<%}%>
</p>
     