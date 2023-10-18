<%@page contentType="text/html"%> <%@page pageEncoding="UTF-8"%> <%@page
import="java.util.*"%> <%@page import="gitex.html.*"%> <%@page
import="gitex.tu.*"%> <%@page import="gitex.tu.htmlForm.*"%> <% FrmLeaveGroup
thisForm = new FrmLeaveGroup(session, FrmLeaveGroup.IN_COUNTRY);
LutLeaveReqTaskCode taskCode = new LutLeaveReqTaskCode(); int numOfItem = 0; int
counter = 0; numOfItem = thisForm.leaveFormId.size(); if(numOfItem % 2 == 1)
numOfItem++; %>
<h3>เลือกประเภทคำร้อง :</h3>

<div style="display: flex">
  <div style="flex: 50%">
    <p style="float: left; padding-left: 120px">
      <%for(int i = 0; i < numOfItem/2; i++){%> <%counter++;%>
      <a
        class="mainlink"
        href="index.jsp?<%=LutGlobalRequestName.TASK_CODE%>=<%=taskCode.REQ_IN_COUNTRY_LEAVE_2%>&<%=FrmLeaveReq.ELM_NAME_FORM_TYPE_ID%>=<%=thisForm.leaveFormId.get(i).toString()%>&<%=FrmLeaveReq.ELM_NAME_FORM_CAT_ID%>=<%=thisForm.getLeaveCategoryId(thisForm.leaveFormId.get(i).toString())%>"
        ><%=thisForm.getLeaveFormName(thisForm.leaveFormId.get(i).toString())%></a
      >
      <%}%>
    </p>
  </div>
  <div style="flex: 50%">
    <p style="float: left">
      <%for(int i = counter; i < thisForm.leaveFormId.size(); i++){%>
      <a
        class="mainlink"
        href="index.jsp?<%=LutGlobalRequestName.TASK_CODE%>=<%=taskCode.REQ_IN_COUNTRY_LEAVE_2%>&<%=FrmLeaveReq.ELM_NAME_FORM_TYPE_ID%>=<%=thisForm.leaveFormId.get(i).toString()%>&<%=FrmLeaveReq.ELM_NAME_FORM_CAT_ID%>=<%=thisForm.getLeaveCategoryId(thisForm.leaveFormId.get(i).toString())%>"
        ><%=thisForm.getLeaveFormName(thisForm.leaveFormId.get(i).toString())%></a
      >
      <%}%>
    </p>
  </div>
</div>
<p style="clear: both"></p>
<p class="block">
  <strong>คำแนะนำ : </strong>คลิกที่ประเภทคำร้องเพื่อกรอกรายละเอียด
</p>
