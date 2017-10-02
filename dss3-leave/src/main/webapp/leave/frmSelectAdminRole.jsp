<%@page contentType="text/html"%>
<%@page pageEncoding="TIS-620"%>
<%@page import="java.util.*"%>
<%@page import="gitex.tu.*"%>
<%@page import="gitex.html.*"%>
<%@page import="gitex.tu.htmlForm.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=tis-620" />
<meta name="description" content="TU Web Application" />
<meta name="keywords" content="�к�������, ������ʵ��" />
<meta name="author" content="Disillusion  / Original design: Andreas Viklund - http://andreasviklund.com/" />
<script language="JavaScript" type="text/javascript" src="js/gen_validatorv.js"></script>
<script language="JavaScript" type="text/javascript" src="js/popUp.js"></script>
<link rel="stylesheet" type="text/css" href="css/andreas02.css" media="screen" title="andreas02 (screen)" />
<link rel="stylesheet" type="text/css" href="css/addOn.css" media="screen" title="addOn (screen)" />
<link rel="stylesheet" type="text/css" href="css/print.css" media="print" />
<title>�.������ʵ�� : ���͡�ҹ����Ѻ���˹�ҷ������к�</title>
</head>

<body style="background:#FFFFFF;">
<div id="container" style="width:85%;">
<%
SysAdmin sysAdmin = new SysAdmin();
%>   
<h3>��ª��ͧҹ</h3>
<%if(sysAdmin.getRoleIdList().size() > 0){%>
    <form name="frmAdminRole">
        <select name="roleId">
        <%for(int i = 0; i < sysAdmin.getRoleIdList().size(); i++){
            String roleId = sysAdmin.getRoleIdList().get(i).toString();
            String roleDesc = sysAdmin.getRoleName(roleId);
            %>
            <option value="<%=roleId%>"><%=roleDesc%></option>
        <%}%>
            
        </select>
        <br/>
        <h3>�ͺࢵ�ҹ</h3>
        <input type="radio" name="scope" checked onclick="document.frmAdminRole.roleScope.value='<%=sysAdmin.LOCAL_SCOPE%>'">੾��˹����ѧ�Ѵ<br/>
        <input type="radio" name="scope"  onclick="document.frmAdminRole.roleScope.value='<%=sysAdmin.GLOBAL_SCOPE%>'">������
        <input type="hidden" name="roleScope" value="<%=sysAdmin.LOCAL_SCOPE%>">
    </form>
    <div align="center">
    <input type="button" name="btnOK" value=" ��ŧ " onclick="doSelectAdminRole();">
    <input type="button" name="btnCancel" value=" ¡��ԡ " onclick="window.close();">
    </div>
    <script>
        function doSelectAdminRole(){
            var roleId = document.frmAdminRole.roleId.value;
            var scope = document.frmAdminRole.roleScope.value;
            window.opener.doSelectAdminRole(roleId, scope);window.close();
        }
    </script>
<%}else{%>
    <p class="block" style="padding:3px;">
        �������ª��ͧҹ
    </p>
    <div align="center">
    <input type="button" name="btnCancel" value=" ¡��ԡ " onclick="window.close();">
    </div>
<%}%>    
</div>
</body>
</html>