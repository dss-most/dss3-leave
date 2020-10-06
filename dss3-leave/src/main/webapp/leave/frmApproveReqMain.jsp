<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>
<%@page import="java.util.*"%>
<%@page import="gitex.html.*"%>
<%@page import="gitex.tu.*"%>
<%@page import="gitex.tu.htmlForm.*"%>
<%
LeaveReqHtmlPage thisPage = new LeaveReqHtmlPage(session, request);
LutLeaveReqTaskCode taskCode = new LutLeaveReqTaskCode();   
gitex.utility.Date date = new gitex.utility.Date();
FrmLeaveReq reqForm = new FrmLeaveReq();
FrmApproveReqMain thisForm = new FrmApproveReqMain(thisPage.getUser());
%>
<h3>รายการคำร้องรอการพิจารณา : </h3>
<%
if(thisForm.formList.size() > 0){
%>
<p>
<table width="100%">
<tr>
<td class="tblHeader" width="45%">ประเภทคำร้อง</td>
<td class="tblHeader" width="20%">ผู้ส่ง</td>
<td class="tblHeader" width="15%">วันที่ส่ง</td>
<td class="tblHeader" width="20%">สถานะ</td>
</tr>
<%for(int i = 0; i < thisForm.formList.size(); i++){
    String takeLeaveId = ((Hashtable)thisForm.formList.get(i)).get(thisForm.TAKE_LEAVE_ID).toString();
    String formTypeId = ((Hashtable)thisForm.formList.get(i)).get(thisForm.LEAVE_FORM_TYPE).toString();
    String formTypeName = reqForm.getFormName(((Hashtable)thisForm.formList.get(i)).get(thisForm.LEAVE_FORM_TYPE).toString());
    String formOwner = ((Hashtable)thisForm.formList.get(i)).get(thisForm.FORM_OWNER).toString();
    String issueDate = date.getDate(((Hashtable)thisForm.formList.get(i)).get(thisForm.FORM_ISSUE_DATE).toString(), date.MONTH_NAME_SHORT).get(date.DATE_THAI).toString();
    String status = reqForm.getStatusName(((Hashtable)thisForm.formList.get(i)).get(thisForm.FORM_STATUS).toString());
    String refTakeLeaveId = ((Hashtable)thisForm.formList.get(i)).get(thisForm.REF_TAKELEAVE_ID).toString();
    String remark = "";
    if(!refTakeLeaveId.equals("")){
        if(formTypeId.equals(reqForm.FORM_TYPE_VACATION) || formTypeId.equals(reqForm.FORM_TYPE_PRIVATE)){
            remark = "(ไปต่างประเทศ)";
        }
    }
%>
<tr>
<td class="tblRow<%=i%2%>"><a href="index.jsp?<%=LutGlobalRequestName.TASK_CODE%>=<%=LutLeaveReqTaskCode.VIEW_WAITING_APPROVE_REQ_2%>&<%=FrmApproveReqDtl.ELM_NAME_TAKE_LEAVE_ID%>=<%=takeLeaveId%>"><%=formTypeName + remark%></a></td>
<td class="tblRow<%=i%2%>"><%=formOwner%></td>
<td class="tblRow<%=i%2%>"><%=issueDate%></td>
<td class="tblRow<%=i%2%>"><%=status%></td>
</tr>
<%}%>
</table>
<p class="block">
<strong>คำแนะนำ : </strong>คลิกที่ประเภทคำร้องเพื่อดูรายละเอียดและดำเนินการอื่นๆ ต่อไป
</p>
<%}else{%>
<p class="block center">ไม่พบคำร้องที่รอการพิจารณา</p>
<%}%>
</p>
