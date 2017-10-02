<%@page contentType="text/html"%>
<%@page pageEncoding="TIS-620"%>
<%@page import="java.util.*"%>
<%@page import="gitex.utility.*"%>
<%@page import="gitex.html.*"%>
<%@page import="gitex.tu.*"%>
<%@page import="gitex.tu.htmlForm.*"%>
<%
LeaveReqHtmlPage thisPage = new LeaveReqHtmlPage(session, request);
Employee employee = thisPage.getUser().employee;
LutLeaveReqTaskCode taskCode = new LutLeaveReqTaskCode();   
FrmLeaveStatusDtl thisForm = new FrmLeaveStatusDtl(request);
FrmLeaveReq reqForm = new FrmLeaveReq(thisForm.getValue(thisForm.ELM_NAME_TAKE_LEAVE_ID));
ArrayList listSubForm = new ArrayList();
DecodeConn de=new DecodeConn();

if(reqForm.getValue(reqForm.ELM_NAME_FORM_TYPE_ID).equals(reqForm.FORM_TYPE_OUT_COUNTRY_WITH_LEAVE)){
    ArrayList listSubFormId = reqForm.getSubFormId();
    for(int i = 0; i < listSubFormId.size(); i++){
        FrmLeaveReq subForm = new FrmLeaveReq(listSubFormId.get(i).toString());
        listSubForm.add(subForm);
    }
}
if(listSubForm.size() > 0){
    session.removeAttribute(LutGlobalSessionName.SUB_FORM);
    session.setAttribute(LutGlobalSessionName.SUB_FORM, listSubForm);
}
session.setAttribute(LutGlobalSessionName.FORM, reqForm);
%>
<h3>
����������ͧ : <span class="lblLeaveName"><%=reqForm.getFormName()%></span><br/>
ʶҹ� : <span class="lblLeaveName"><%=reqForm.getStatusName(reqForm.getValue(reqForm.ELM_NAME_STATUS))%></span><br/>
</h3>
<jsp:include page='<%="frmDetailType" + reqForm.getValue(reqForm.ELM_NAME_FORM_TYPE_ID) + ".jsp"%>'></jsp:include>
<p></p>
<p class="center">
    <form action="index.jsp" method="post">
        <%if(reqForm.getValue(reqForm.ELM_NAME_STATUS).equals(reqForm.FORM_STATUS_ALLOW)){%>
            <%if(!reqForm.getValue(reqForm.ELM_NAME_FORM_TYPE_ID).equals(reqForm.FORM_TYPE_CANCEL) 
                && !reqForm.getValue(reqForm.ELM_NAME_FORM_TYPE_ID).equals(reqForm.FORM_TYPE_NO_SIGN_IN_OUT) 
                && !reqForm.getValue(reqForm.ELM_NAME_FORM_TYPE_ID).equals(reqForm.FORM_TYPE_OUT_COUNTRY_WITH_LEAVE) 
                && !reqForm.getValue(reqForm.ELM_NAME_FORM_TYPE_ID).equals(reqForm.FORM_TYPE_OUT_COUNTRY_WITHOUT_LEAVE)){%>
                <%
                session.removeAttribute(LutGlobalSessionName.FORM);
                boolean canCancel = true;
                if(((reqForm.getValue(reqForm.ELM_NAME_FORM_TYPE_ID).equals(reqForm.FORM_TYPE_PRIVATE) || reqForm.getValue(reqForm.ELM_NAME_FORM_TYPE_ID).equals(reqForm.FORM_TYPE_VACATION)) && !reqForm.getValue(reqForm.ELM_NAME_REF_TAKE_LEAVE_ID).equals(""))){
                    FrmLeaveReq mainForm = new FrmLeaveReq(reqForm.getValue(reqForm.ELM_NAME_REF_TAKE_LEAVE_ID));
                    if(!mainForm.getValue(mainForm.ELM_NAME_STATUS).equals(mainForm.FORM_STATUS_ALLOW)) canCancel = false;
                }
                if(canCancel){          
                %>
                <input type="hidden" name="<%=reqForm.ELM_NAME_REF_TAKE_LEAVE_ID%>" value="<%=reqForm.getValue(reqForm.ELM_NAME_TAKE_LEAVE_ID)%>"/>
                <input type="hidden" name="<%=LutGlobalRequestName.TASK_CODE%>" value="<%=taskCode.INPUT_CANCEL_PARTIAL%>"/>
                <input type="submit" name="btnOK" value=" ¡��ԡ�ѹ�� "/>
                <%}%>
            <%}%>
        <%}else if(reqForm.getValue(reqForm.ELM_NAME_STATUS).equals(reqForm.FORM_STATUS_WAITING) || reqForm.getValue(reqForm.ELM_NAME_STATUS).equals(reqForm.FORM_STATUS_NOT_ALLOW)){%>
            <%if(!((reqForm.getValue(reqForm.ELM_NAME_FORM_TYPE_ID).equals(reqForm.FORM_TYPE_PRIVATE) || reqForm.getValue(reqForm.ELM_NAME_FORM_TYPE_ID).equals(reqForm.FORM_TYPE_VACATION)) && !reqForm.getValue(reqForm.ELM_NAME_REF_TAKE_LEAVE_ID).equals(""))){%>
                <input type="hidden" name="<%=FrmSubmitCancelFull.ELM_NAME_TAKE_LEAVE_ID%>" value="<%=reqForm.getValue(reqForm.ELM_NAME_TAKE_LEAVE_ID)%>"/>
                <input type="hidden" name="<%=LutGlobalRequestName.TASK_CODE%>" value="<%=taskCode.SUBMIT_CANCEL_FULL%>"/>
                 <input type="submit" name="btnOK" value=" ¡��ԡ����ͧ " onclick="return confirm('��س��׹�ѹ���¡��ԡ����ͧ\r����͹ : ������׹�ѹ���¡��ԡ���Ǥ���ͧ���ж١ź�͡���ҧ����');"/> 
            <%}%>
        <%}%>
<!--         <input type="button" name="btnPrint" value="�����Ẻ��� 1" onclick="printForm(1);"/>      -->       
<!--          <input type="button" name="btnPrint" value="�����Ẻ��� 2" onclick="printForm(2);"/>             -->
         <input type="button" name="btnPrint" value="�����" onclick="printForm(2);"/>            
       <input type="button" name="btnBack" value="��͹��Ѻ" onclick="document.backFrm.submit();"/>            
    </form>
</p>
<%if(((reqForm.getValue(reqForm.ELM_NAME_FORM_TYPE_ID).equals(reqForm.FORM_TYPE_PRIVATE) || reqForm.getValue(reqForm.ELM_NAME_FORM_TYPE_ID).equals(reqForm.FORM_TYPE_VACATION)) && !reqForm.getValue(reqForm.ELM_NAME_REF_TAKE_LEAVE_ID).equals(""))){%>
    <div class="block">
    <strong>�����˵� : </strong> ��ҹ�����������Ѻ仵�ҧ����� ����ҡ��ͧ���¡��ԡ�����Թ��ôѧ���<br/>
    <ol style="padding-left:65px;">
        <li>���㺢�͹حҵ仵�ҧ������ѧ������Ѻ���͹حҵ ���ӡ��¡��ԡ���㺢�͹حҵ仵�ҧ�����</li>        
        <li>���㺢�͹حҵ仵�ҧ��������Ѻ���͹حҵ���� ���ӡ��¡��ԡ�ѹ�ҷ��㺢�͹حҵ���</li>
    </ol>
    </div>
<%}%>
<!--p></p-->
<!--jsp:include page="frmReqLog.jsp"-->
    <!--jsp:param name="takeLeaveId" value="<%=thisForm.getValue(thisForm.ELM_NAME_TAKE_LEAVE_ID)%>"/-->
<!--/jsp:include-->
<form name="backFrm" action="index.jsp" method="post">
    <input type="hidden" name="<%=LutGlobalRequestName.TASK_CODE%>" value="<%=LutLeaveReqTaskCode.CHECK_REQ_STATUS_1%>"/>
    <input type="hidden" name="<%=FrmLeaveHistory.ELM_NAME_BUDGET_YEAR%>" value="<%=reqForm.getValue(reqForm.ELM_NAME_BUDGET_YEAR)%>"/>
    <input type="hidden" name="<%=FrmLeaveHistory.ELM_NAME_EMP_ID%>" value="<%=employee.empId%>"/>
</form>    
<%
Database db = new Database();
String sql = "";
sql += " select	server_name, server_port, server_alias";
sql += " from	glb_server";
sql += " where	server_desc	= 'REPORT_SERVER'";
ArrayList field = new ArrayList();
field.add("server_name");
field.add("server_port");
field.add("server_alias");
ArrayList data = new ArrayList();
data = db.getResultSet(sql, field, null);
String serverName = "";
String serverPort = "";
String serverAlias = "";
if(data.size() > 0){
    serverName = ((Hashtable)data.get(0)).get("server_name").toString();
    serverPort = ((Hashtable)data.get(0)).get("server_port").toString();
    serverAlias = ((Hashtable)data.get(0)).get("server_alias").toString();
}
%>
<script>
    function printForm(type){
        if(type == 1) popUp('frmPrint.jsp?<%=thisForm.ELM_NAME_TAKE_LEAVE_ID%>=<%=thisForm.getValue(thisForm.ELM_NAME_TAKE_LEAVE_ID)%>', 'frmPrint', '650', '550');
        else if(type == 2){
            var printURL = "http://<%=serverName%>:<%=serverPort%>/<%=serverAlias%>/rwservlet";
            printURL += "?report=hr_leave_form_<%=reqForm.getValue(reqForm.ELM_NAME_FORM_TYPE_ID)%>";
            printURL += "&destype=cache&desformat=pdf&userid=<%=de.userName%>/<%=de.passWord%>@<%=de.sid%>";
            printURL += "&p_leave_id=<%=reqForm.getValue(reqForm.ELM_NAME_TAKE_LEAVE_ID)%>";
            popUp(printURL, 'frmPrint', '650', '550');
        }
    }
</script>    
<div style="clear:both;"></div>