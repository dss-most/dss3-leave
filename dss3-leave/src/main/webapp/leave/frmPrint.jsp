<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>
<%@page import="java.util.*"%>
<%@page import="gitex.tu.*"%>
<%@page import="gitex.html.*"%>
<%@page import="gitex.tu.htmlForm.*"%>
<%
request.setCharacterEncoding("TIS-620");   
LeaveReqHtmlPage thisPage = new LeaveReqHtmlPage(session, request);
FrmLeaveStatusDtl thisForm = new FrmLeaveStatusDtl(request);
FrmLeaveReq reqForm = new FrmLeaveReq(thisForm.getValue(thisForm.ELM_NAME_TAKE_LEAVE_ID));
boolean doRemoveSession = false;
if(session.getAttribute(LutGlobalSessionName.FORM) == null){
    session.setAttribute(LutGlobalSessionName.FORM, reqForm);
    doRemoveSession = true;
};
%>
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
<title>ม.ธรรมศาสตร์ : ระบบการลา</title>
</head>

<body style="background:#FFFFFF;">
<jsp:include page='<%="frmDetailType" + reqForm.getValue(reqForm.ELM_NAME_FORM_TYPE_ID) + ".jsp"%>'></jsp:include>
<script>
    if(confirm("กรุณายืนยันการพิมพ์แบบฟอร์มใบลา")){
        window.print();
        //if(confirm("คลิกที่ปุ่ม OK เพื่อปิดหน้าต่างนี้หลังการพิมพ์เสร็จสิ้นแล้ว")) window.close();
    }else  window.close();
</script>
</body>
</html>
<%if(doRemoveSession) session.removeAttribute(LutGlobalSessionName.FORM);%>