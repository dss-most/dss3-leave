<%@page contentType="text/html"%>
<%@page pageEncoding="TIS-620"%>
<%@page import="gitex.tu.htmlForm.*"%>
<%
FrmUserLogin thisForm = new FrmUserLogin(request);
%>
<h3>��س�ŧ����¹����к� : </h3>
<form name="frmLogin" action="index.jsp" method="post">
	
	<div class="input-block">
		<label>���ͼ���� :</label>
		<input type="text" name="<%=thisForm.ELM_NAME_USERNAME%>" tabindex="1">
	</div>
	
	<div class="input-block">
		<label>���ʼ�ҹ :</label>
		<input type="password" name="<%=thisForm.ELM_NAME_PASSWORD%>" tabindex="2">
	</div>

	<div class="input-block">
		<label></label>
		<input type="submit" name="btnSubmit" value="��ŧ" style="width:55px; " tabindex="3">
 		<input type="reset" name="btnReset" value="���������" style="width:55px; " tabindex="4">
	</div>
	
 
</form>
<script language="JavaScript">
var frmLoginValidator  = new Validator("frmLogin");
frmLoginValidator.addValidation("<%=thisForm.ELM_NAME_USERNAME%>","req","��س������ͼ����");
frmLoginValidator.addValidation("<%=thisForm.ELM_NAME_PASSWORD%>","req","��س�������ʼ�ҹ");
</script>
