<%@page contentType="text/html"%>
<%@page pageEncoding="TIS-620"%>
<%@page import="gitex.tu.htmlForm.*"%>
<%
FrmUserLogin thisForm = new FrmUserLogin(request);
%>
<h3>กรุณาลงทะเบียนเข้าระบบ : </h3>
<form class="right" style="width:50%;" name="frmLogin" action="index.jsp" method="post">
ชื่อผู้ใช้ : <input type="text" name="<%=thisForm.ELM_NAME_USERNAME%>" tabindex="1"><input type="submit" name="btnSubmit" value="ตกลง" style="width:55px; " tabindex="3"><br>
รหัสผ่าน : <input type="password" name="<%=thisForm.ELM_NAME_PASSWORD%>" tabindex="2"><input type="reset" name="btnReset" value="เริ่มใหม่" style="width:55px; " tabindex="4"><br>
</form>
<script language="JavaScript">
var frmLoginValidator  = new Validator("frmLogin");
frmLoginValidator.addValidation("<%=thisForm.ELM_NAME_USERNAME%>","req","กรุณาใส่ชื่อผู้ใช้");
frmLoginValidator.addValidation("<%=thisForm.ELM_NAME_PASSWORD%>","req","กรุณาใส่รหัสผ่าน");
</script>
