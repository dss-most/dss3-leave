<%@page contentType="text/html"%>
<%@page pageEncoding="TIS-620"%>
<%@page import="java.util.*"%>
<%@page import="gitex.html.*"%>
<%@page import="gitex.tu.*"%>
<%@page import="gitex.tu.htmlForm.*"%>
<%@page import="gitex.utility.*"%>
<%
LeaveReqHtmlPage thisPage = new LeaveReqHtmlPage(session, request);
gitex.utility.Date date = new gitex.utility.Date();
FrmLeaveReq reqForm = new FrmLeaveReq();
FrmSearchReq thisForm = new FrmSearchReq(session, request);
if(!thisForm.getValue(thisForm.ELM_NAME_IS_NEW_SEARCH).equals("")){
    session.setAttribute(thisForm.sessionName, thisForm);
}else if(session.getAttribute(thisForm.sessionName) != null){
    thisForm = (FrmSearchReq)session.getAttribute(thisForm.sessionName);
}
int rowPerPage = 5;
if(!thisForm.isContainKeyword){
    thisForm.setValue(thisForm.ELM_NAME_SEARCH_FORM_STATUS, FrmLeaveReq.FORM_STATUS_WAITING);
    thisForm.setValue(thisForm.ELM_NAME_MAX_ROW, String.valueOf(rowPerPage));    
}
thisForm.doSearch();
int numOfPage = thisForm.maxItem/rowPerPage;
if(thisForm.maxItem%rowPerPage > 0) numOfPage++;
int pageNo = Integer.parseInt(thisForm.getValue(thisForm.ELM_NAME_PAGE_NO));
%>
<h3>รายการคำร้อง</h3>
<form name="searchFrm" action="index.jsp?#content" method="post">
    <p class="right" style="width:320px;">
    <strong>ค้นหาจาก</strong><img src="images/spacer.gif" width="250" height="1" /><br/>
    ชื่อ - นามสกุล : <input type="text" name="<%=thisForm.ELM_NAME_SEARCH_NAME%>" value="<%=thisForm.getValue(thisForm.ELM_NAME_SEARCH_NAME)%>"/><br/>
    วันที่ส่งคำร้อง : <input type="text" name="txtSearchDate" style="position:relative;" value="" onKeyDown="click();return false;" onClick="window.event.cancelBubble=true;setCalendarCaller(this, '<%=thisForm.ELM_NAME_SEARCH_SUBMIT_DATE%>', this.offsetTop, this.offsetLeft);"/><br/>
    <input type="hidden" name="<%=thisForm.ELM_NAME_SEARCH_SUBMIT_DATE%>" value="<%=thisForm.getValue(thisForm.ELM_NAME_SEARCH_SUBMIT_DATE)%>"/>
    ประเภทคำร้อง : <select name="<%=thisForm.ELM_NAME_SEARCH_FORM_TYPE%>">
        <option value="">ทั้งหมด</option>
        <%for(int i = 0; i < reqForm.formTypeIdList.size(); i++){%>
            <%
               String formId = reqForm.formTypeIdList.get(i).toString();
               String formName = reqForm.getFormName(formId);
               String selectedFormType = thisForm.getValue(thisForm.ELM_NAME_SEARCH_FORM_TYPE);
            %>
            <option value="<%=formId%>" <%if(formId.equals(selectedFormType)){%>selected<%}%>><%=formName%></option>
        <%}%>
    </select><br/>
    <input type="submit" name="btnSubmit" value=" ค้นหา "/>    
    <input type="button" name="btnReset" value=" เริ่มใหม่ " onclick="clearSearchForm();"/>
    <img src="images/spacer.gif" width="92" height="1" />    <input type="hidden" name="<%=thisForm.ELM_NAME_MAX_ROW%>" value="<%=rowPerPage%>"/>
    <input type="hidden" name="<%=thisForm.ELM_NAME_PAGE_NO%>" value="1"/>
    <input type="hidden" name="<%=thisForm.ELM_NAME_SEARCH_FORM_STATUS%>" value="<%=FrmLeaveReq.FORM_STATUS_WAITING%>"/>
    <input type="hidden" name="<%=thisForm.ELM_NAME_IS_NEW_SEARCH%>" value="yes"/>
    </p>
</form>    
<jsp:include page="includes/calendar.jsp"></jsp:include>
<script language="JavaScript">
    document.all['<%=thisForm.ELM_NAME_SEARCH_NAME%>'].style.width = "205px";
    document.all['txtSearchDate'].style.width = "205px";
    setDateDisplayText(document.all['txtSearchDate'], document.all['<%=thisForm.ELM_NAME_SEARCH_SUBMIT_DATE%>'].value);
    
    function gotoPage(pageNo){
        document.searchFrm.<%=thisForm.ELM_NAME_PAGE_NO%>.value = pageNo;
        document.searchFrm.submit();
    }
    
    function clearSearchForm(){
        document.all['<%=thisForm.ELM_NAME_SEARCH_SUBMIT_DATE%>'].value = "";
        document.all['txtSearchDate'].value = "";
        document.all['<%=thisForm.ELM_NAME_SEARCH_NAME%>'].value = "";
        document.searchFrm.<%=thisForm.ELM_NAME_SEARCH_FORM_TYPE%>.selectedIndex = 0;
    }
</script>
<%if(thisForm.searchResult.size() > 0){%>
<p class="right">
หน้า
<%for(int i = 1; i <= numOfPage; i++){%>
    <a href="#content" class="pageNum" <%if(i == pageNo){%>style="color:#FFFFFF;background:#000000;"<%}%> onclick="gotoPage(<%=i%>);">&nbsp;<%=i%>&nbsp;</a>
<%}%>
</p>
<p>
<!--style>td{font-size:smaller;}</style-->
<table width="100%" id="content" cellspacing="1">
<tr>
<td class="tblHeader center" width="8%">ลำดับ</td>
<td class="tblHeader center" width="12%">วันที่</td>
<td class="tblHeader" width="25%">ประเภทคำร้อง</td>
<td class="tblHeader" width="20%">ผู้ยื่น</td>
<td class="tblHeader" width="20%">ผู้พิจารณา</td>
<td class="tblHeader" width="15%">สถานะ</td>
</tr>
<%for(int i = 0; i < thisForm.searchResult.size(); i++){
    String takeLeaveId = ((Hashtable)thisForm.searchResult.get(i)).get(thisForm.TAKE_LEAVE_ID).toString();
    String formTypeId = ((Hashtable)thisForm.searchResult.get(i)).get(thisForm.LEAVE_FORM_TYPE).toString();
    String fromName = ((Hashtable)thisForm.searchResult.get(i)).get(thisForm.FROM_NAME).toString();
    String toName = ((Hashtable)thisForm.searchResult.get(i)).get(thisForm.TO_NAME).toString();
    String formTypeName = reqForm.getFormName(((Hashtable)thisForm.searchResult.get(i)).get(thisForm.LEAVE_FORM_TYPE).toString());
    String submitDate = date.getDate(((Hashtable)thisForm.searchResult.get(i)).get(thisForm.SUBMIT_DATE).toString(), date.MONTH_NAME_SHORT).get(date.DATE_THAI).toString();
    String startDate = date.getDate(((Hashtable)thisForm.searchResult.get(i)).get(thisForm.FORM_START_DATE).toString(), date.MONTH_NAME_SHORT).get(date.DATE_THAI).toString();
    String endDate = date.getDate(((Hashtable)thisForm.searchResult.get(i)).get(thisForm.FORM_END_DATE).toString(), date.MONTH_NAME_SHORT).get(date.DATE_THAI).toString();
    String status = reqForm.getStatusName(((Hashtable)thisForm.searchResult.get(i)).get(thisForm.FORM_STATUS).toString());
    String numOfLeaveDay = ((Hashtable)thisForm.searchResult.get(i)).get(thisForm.NUM_OF_LEAVE_DAY).toString();
    String refTakeLeaveId = ((Hashtable)thisForm.searchResult.get(i)).get(thisForm.REF_TAKELEAVE_ID).toString();
    String remark = "";
    if(!refTakeLeaveId.equals("")){
        if(formTypeId.equals(reqForm.FORM_TYPE_VACATION) || formTypeId.equals(reqForm.FORM_TYPE_PRIVATE)){
            remark = "(ไปต่างประเทศ)";
        }
    }
%>
<tr>
<td class="tblRow<%=i%2%> center"><%=(pageNo - 1) * rowPerPage + 1 + i%></td>
<td class="tblRow<%=i%2%> center"><%=submitDate%></td>
<td class="tblRow<%=i%2%>"><a href="index.jsp?<%=LutGlobalRequestName.TASK_CODE%>=<%=LutLeaveReqTaskCode.VIEW_WAITING_FORWARD_REQ_2%>&<%=FrmForwardReqDtl.ELM_NAME_TAKE_LEAVE_ID%>=<%=takeLeaveId%>"><%=formTypeName + remark%></a></td>
<td class="tblRow<%=i%2%>"><%=fromName%></td>
<td class="tblRow<%=i%2%>"><%=toName%></td>
<td class="tblRow<%=i%2%>"><%=status%></td>
</tr>
<%}%>
</table>
<p class="block">
<strong>คำแนะนำ : </strong>คลิกที่ประเภทคำร้องเพื่อดูรายละเอียด และ ดำเนินการอื่นๆ ต่อไป
</p>
<%}else{%>
<p class="block center">ไม่พบการลา</p>
<%}%>
</p>
