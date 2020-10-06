<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>
<%@page import="java.util.*"%>
<%@page import="gitex.tu.*"%>
<%@page import="gitex.html.*"%>
<%@page import="gitex.tu.htmlForm.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=tis-620" />
<meta name="description" content="TU Web Application" />
<meta name="keywords" content="ระบบการลาม, ธรรมศาสตร์" />
<meta name="author" content="Disillusion  / Original design: Andreas Viklund - http://andreasviklund.com/" />
<script language="JavaScript" type="text/javascript" src="js/gen_validatorv.js"></script>
<script language="JavaScript" type="text/javascript" src="js/popUp.js"></script>
<link rel="stylesheet" type="text/css" href="css/andreas02.css" media="screen" title="andreas02 (screen)" />
<link rel="stylesheet" type="text/css" href="css/addOn.css" media="screen" title="addOn (screen)" />
<link rel="stylesheet" type="text/css" href="css/print.css" media="print" />
<title>ม.ธรรมศาสตร์ : เลือกหน่วยงาน</title>
</head>

<body style="background:#FFFFFF;">
<div id="container" style="width:85%;">
<%
LeaveReqHtmlPage thisPage = new LeaveReqHtmlPage(session, request);
LutLeaveReqTaskCode taskCode = new LutLeaveReqTaskCode();
FrmCmdTree thisForm = new FrmCmdTree(request, thisPage.getUser());
String orgId = thisForm.getValue(thisForm.ELM_NAME_ORG_ID);
if(orgId.equals("")) orgId = "0";
LeaveOrg thisOrg = new LeaveOrg(orgId);
%>   
<h3>หน่วยงาน : <%=thisOrg.name%></h3>
<div align="center">
<input type="button" name="btnOK" value=" ตกลง " onclick="window.opener.doSelectOrg('<%=thisOrg.orgId%>', '<%=thisOrg.name%>');window.close();">
<input type="button" name="btnCancel" value=" ยกเลิก " onclick="window.close();">
</div>
<p></p>
<%//if(thisOrg.pathId.size() > 1){%>
    <p style="width:100%;font-size:smaller;padding:5px 5px 5px 5px;">
    <%for(int i = thisOrg.pathId.size() - 1; i >= 0; i--){%>
        <%if(i < thisOrg.pathId.size() - 1){%>&gt;<%}%>
        <a href="frmSelectOrg.jsp?<%=FrmCmdTree.ELM_NAME_ORG_ID%>=<%=thisOrg.pathId.get(i).toString()%>"><%=thisOrg.pathName.get(i).toString()%></a>
    <% }%>
    </p>
<%//}%>
<h3 style="border-bottom:#555555 1px solid;">หน่วยงานย่อย</h3>
<%if(thisOrg.childId.size() > 0){
    int numOfItem = thisOrg.childId.size();
    if(numOfItem%2 == 1) numOfItem++;
    int counter = 0;
    %>
    <div id="org">
    <p style="float:left;width:50%;">
    <%for(int i = 0; i < numOfItem/2; i++){
        counter++;
        %>
        <a class="mainlink" href="frmSelectOrg.jsp?<%=FrmCmdTree.ELM_NAME_ORG_ID%>=<%=thisOrg.childId.get(i).toString()%>"><%=thisOrg.childName.get(i).toString()%></a>
    <%}%>
    </p>
    <p style="float:left;width:50%;">
    <%for(int i = counter; i < thisOrg.childId.size(); i++){%>
        <a class="mainlink" href="frmSelectOrg.jsp?<%=FrmCmdTree.ELM_NAME_ORG_ID%>=<%=thisOrg.childId.get(i).toString()%>"><%=thisOrg.childName.get(i).toString()%></a>
    <%}%>
    </p>
    </div>
<%}else{%>
    <p class="block" style="padding:3px;">
        ไม่มีหน่วยงานย่อย
    </p>
<%}%>    
</div>
</body>
</html>