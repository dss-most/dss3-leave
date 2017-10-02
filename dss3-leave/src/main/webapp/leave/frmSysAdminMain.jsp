<%@page contentType="text/html"%>
<%@page pageEncoding="TIS-620"%>
<%@page import="java.util.*"%>
<%@page import="gitex.tu.htmlForm.*"%>
<%@page import="gitex.tu.*"%>
<%@page import="gitex.html.*"%>
<%
LeaveReqHtmlPage thisPage = new LeaveReqHtmlPage(session, request);
LutLeaveReqTaskCode taskCode = new LutLeaveReqTaskCode();
FrmSysAdmin thisForm = new FrmSysAdmin(request, thisPage.getUser());
SysAdmin sysAdmin = new SysAdmin();
FrmSearchEmployee searchForm = new FrmSearchEmployee(request);
%>   
<form name="frmAdmin" action="index.jsp" method="post">
<input type="hidden" name="<%=thisForm.ELM_NAME_TASK%>" value="<%=thisForm.REMOVE_FROM_ADMIN%>"/>
<script>
    function removeAdmin(){
        if(confirm("��س��׹�ѹ���¡��ԡ���˹�ҷ������к�")){
            document.frmAdmin.submit();
        }
    }
</script>
<h3>��ª������˹�ҷ������к�</h3>
<%if(sysAdmin.getAdminList().size() > 0){%>
    <table width="100%" id="normEmp">
    <tr>
    <td class="tblHeader center" width="10%">�ӴѺ</td>
    <td class="tblHeader left" width="25%" style="padding-right:5px;">����-���ʡ��</td>
    <td class="tblHeader left" width="25%" style="padding-right:5px;">���ͧҹ</td>
    <td class="tblHeader left" width="30%" style="padding-right:5px;">�ͺࢵ</td>
    <td class="tblHeader center" width="10%" style="padding-right:5px;">¡��ԡ</td>
    </tr>
    <%for(int i = 0; i < sysAdmin.getAdminList().size(); i++){
        Hashtable admin = (Hashtable)sysAdmin.getAdminList().get(i);
        Employee emp = new Employee(admin.get(sysAdmin.EMP_ID).toString());
        String roleDesc = sysAdmin.getRoleName(admin.get(sysAdmin.ROLE_ID).toString());
        String roleScope = admin.get(sysAdmin.ROLE_SCOPE).toString();
        %>
        <tr>
        <td class="tblRow<%=i % 2%> center"><%=i+1%></td>
        <td class="tblRow<%=i % 2%> left" style="padding-right:5px;"><%=emp.fullName%><br/><span style="font-size:0.9em;">�ѧ�Ѵ <%=emp.topORGName%></span></td>
        <td class="tblRow<%=i % 2%> left" style="padding-right:5px;"><%=roleDesc%></td>
        <td class="tblRow<%=i % 2%> left" style="padding-right:5px;"><%if(roleScope.equals(sysAdmin.GLOBAL_SCOPE)){%>������<%}else{%>੾��˹����ѧ�Ѵ<%}%></td>
        <td class="tblRow<%=i % 2%> center"><input type="checkbox" name="<%=thisForm.ELM_NAME_EMP_ID%>" value="<%=emp.empId%>"></td>
        </tr>
    <%}%>
        <tr>
        <td colspan="4">&nbsp;</td>
        <td class="center"><input type="button" name="btnSelectOrg" value="  ¡��ԡ  " onclick="removeAdmin();"></td>
        </tr>
    </table>
     <%}else{%>
        �����
<%}%>
</form>
<p>
<h3 style="border-bottom:#555555 1px solid;clear:both;">�������˹�Ҵ����к�</h3>
<form name="frmSearch" class="left" action="index.jsp#frmSearch" method="post">
<input type="hidden" name="<%=FrmSearchEmployee.ELM_NAME_PAGE_NO%>" value="1"/>
<input type="hidden" name="<%=FrmSearchEmployee.ELM_NAME_IS_NEW_SEARCH%>" value="1"/>
���� <input type="text" name="<%=FrmSearchEmployee.ELM_NAME_KEYWORD%>" value="<%=searchForm.getValue(searchForm.ELM_NAME_KEYWORD)%>"> <input type="submit" name="btnSubmit" value="����"/>
</form>
<%if(searchForm.isContainKeyword && searchForm.searchResult.size() > 0){
    int numOfPage = searchForm.maxItem/searchForm.pageSize;
    if(searchForm.maxItem%searchForm.pageSize > 0) numOfPage++;
    int pageNo = searchForm.pageNo;
    %>
    <p class="block" style="padding:3px;">
        ���ؤ�ҡ÷���ժ��͵ç�Ѻ����ͧ��ä��Ҩӹǹ <%=searchForm.maxItem%> ��ª��ʹѧ���仹��
    </p>
    <script>
        function gotoPage(pageNo){
            document.frmSearch.<%=FrmSearchEmployee.ELM_NAME_PAGE_NO%>.value = pageNo;
            document.frmSearch.submit();
        }        
    </script>
    <p class="right">
    ˹��
    <%for(int i = 1; i <= numOfPage; i++){%>
        <a href="#content" class="pageNum" <%if(i == pageNo){%>style="color:#FFFFFF;background:#000000;"<%}%> onclick="gotoPage(<%=i%>);">&nbsp;<%=i%>&nbsp;</a>
    <%}%>
    </p>
    <script>
        function setToAdmin(empId){
            document.frmEmployee.<%=thisForm.ELM_NAME_EMP_ID%>.value = empId;
            popUp("frmSelectAdminRole.jsp", "setNewAdmin", 300, 250);
        }
        function doSelectAdminRole(roleId, roleScope){
            if(confirm("��س��׹�ѹ��á�˹��ؤ�ҡ÷��١���͡����繼������к�")){
                document.frmEmployee.<%=thisForm.ELM_NAME_ROLE_ID%>.value = roleId;
                document.frmEmployee.<%=thisForm.ELM_NAME_ROLE_SCOPE%>.value = roleScope;
                document.frmEmployee.submit();
            }
        }
    </script>
    <form name="frmEmployee" action="index.jsp" method="post">
        <input type="hidden" name="<%=thisForm.ELM_NAME_EMP_ID%>" value=""/>
        <input type="hidden" name="<%=thisForm.ELM_NAME_ROLE_ID%>" value=""/>
        <input type="hidden" name="<%=thisForm.ELM_NAME_ROLE_SCOPE%>" value=""/>
        <input type="hidden" name="<%=thisForm.ELM_NAME_TASK%>" value="<%=thisForm.SET_TO_ADMIN%>"/>
    </form>
    <table width="100%" id="normEmp">
    <tr>
    <td class="tblHeader center" width="10%">�ӴѺ</td>
    <td class="tblHeader left" width="25%" style="padding-right:5px;">����-���ʡ��</td>
    <td class="tblHeader left" width="30%" style="padding-right:5px;">�ѧ�Ѵ</td>
    <td class="tblHeader left" width="35%" style="padding-right:5px;">&nbsp;</td>
    </tr>
    <%for(int i = 0; i < searchForm.searchResult.size(); i++){
        Employee emp = (Employee)searchForm.searchResult.get(i);
        %>
        <tr>
        <td class="tblRow<%=i % 2%> center"><%=i+1%></td>
        <td class="tblRow<%=i % 2%> left" style="padding-right:5px;"><%=emp.fullName%></td>
        <td class="tblRow<%=i % 2%> left" style="padding-right:5px;"><%=emp.parentORGName%></td>
        <td class="tblRow<%=i % 2%> left" style="padding-right:5px;font-size:smaller;">
            <a href="#normEmp" onclick="setToAdmin('<%=emp.empId%>');">�����������˹�ҷ������к�</a>
        </td>
        </tr>
    <%}%>
    </table>
     <%}else if(searchForm.isNewSearch){%>
        <p class="block" style="padding:3px;">
            ��辺�ؤ�ҡ÷���ͧ��ä���
        </p>
<%}%>
</p>
