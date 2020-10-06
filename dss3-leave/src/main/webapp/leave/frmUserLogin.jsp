<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>
<%@page import="gitex.tu.htmlForm.*"%>
<%
FrmUserLogin thisForm = new FrmUserLogin(request);
%>
<h3>กรุณาลงทะเบียนเข้าระบบ : </h3>
<form name="frmLogin" action="index.jsp" method="post">
	
	<div class="input-block">
		<label>ชื่อผู้ใช้ :</label>
		<input type="text" name="<%=thisForm.ELM_NAME_USERNAME%>" tabindex="1">
	</div>
	
	<div class="input-block">
		<label>รหัสผ่าน :</label>
		<input type="password" name="<%=thisForm.ELM_NAME_PASSWORD%>" tabindex="2">
	</div>

	<div class="input-block">
		<label></label>
		<input type="submit" name="btnSubmit" value="ตกลง" style="width:55px; " tabindex="3">
 		<input type="reset" name="btnReset" value="เริ่มใหม่" style="width:55px; " tabindex="4">
	</div>
	
 
</form>
<script language="JavaScript">
var frmLoginValidator  = new Validator("frmLogin");
frmLoginValidator.addValidation("<%=thisForm.ELM_NAME_USERNAME%>","req","กรุณาใส่ชื่อผู้ใช้");
frmLoginValidator.addValidation("<%=thisForm.ELM_NAME_PASSWORD%>","req","กรุณาใส่รหัสผ่าน");
</script>
