<%@page contentType="text/html"%>
<%@page pageEncoding="TIS-620"%>
<%@page import="gitex.tu.htmlForm.*"%>
<%
FrmUserLogin thisForm = new FrmUserLogin(request);
%>
<h3>��س�ŧ����¹����к� : </h3>
<form class="right" style="width:50%;" name="frmLogin" action="index.jsp" method="post">
���ͼ���� : <input type="text" name="<%=thisForm.ELM_NAME_USERNAME%>" tabindex="1"><input type="submit" name="btnSubmit" value="��ŧ" style="width:55px; " tabindex="3"><br>
���ʼ�ҹ : <input type="password" name="<%=thisForm.ELM_NAME_PASSWORD%>" tabindex="2"><input type="reset" name="btnReset" value="���������" style="width:55px; " tabindex="4"><br>
</form>
<script language="JavaScript">
var frmLoginValidator  = new Validator("frmLogin");
frmLoginValidator.addValidation("<%=thisForm.ELM_NAME_USERNAME%>","req","��س������ͼ����");
frmLoginValidator.addValidation("<%=thisForm.ELM_NAME_PASSWORD%>","req","��س�������ʼ�ҹ");
</script>
