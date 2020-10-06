<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>
<%@page import="java.util.*"%>
<%@page import="gitex.html.*"%>
<%@page import="gitex.tu.*"%>
<%@page import="gitex.tu.htmlForm.*"%>
<%
FrmLeaveGroup thisForm = new FrmLeaveGroup(session, FrmLeaveGroup.OUT_COUNTRY);
LutLeaveReqTaskCode taskCode = new LutLeaveReqTaskCode();
%>
<h3>เลือกประเภทการลา : </h3>
<p style="float:left;padding-left:120px;">
<%for(int i = 0; i < thisForm.leaveFormId.size(); i++){%>
<a class="mainlink" href="index.jsp?<%=LutGlobalRequestName.TASK_CODE%>=<%=taskCode.REQ_IN_COUNTRY_LEAVE_2%>&<%=FrmLeaveReq.ELM_NAME_FORM_TYPE_ID%>=<%=thisForm.leaveFormId.get(i).toString()%>&<%=FrmLeaveReq.ELM_NAME_FORM_CAT_ID%>=<%=thisForm.getLeaveCategoryId(thisForm.leaveFormId.get(i).toString())%>"><%=thisForm.getLeaveFormName(thisForm.leaveFormId.get(i).toString())%></a>
<%}%>
</p>
<p style="clear:both "></p>
<p class="block">
<strong>คำแนะนำ : </strong>คลิกที่ประเภทการลาเพื่อกรอกรายละเอียด
