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
        if(confirm("กรุณายืนยันการยกเลิกเจ้าหน้าที่ดูแลระบบ")){
            document.frmAdmin.submit();
        }
    }
</script>
<h3>รายชื่อเจ้าหน้าที่ดูแลระบบ</h3>
<%if(sysAdmin.getAdminList().size() > 0){%>
    <table width="100%" id="normEmp">
    <tr>
    <td class="tblHeader center" width="10%">ลำดับ</td>
    <td class="tblHeader left" width="25%" style="padding-right:5px;">ชื่อ-นามสกุล</td>
    <td class="tblHeader left" width="25%" style="padding-right:5px;">ชื่องาน</td>
    <td class="tblHeader left" width="30%" style="padding-right:5px;">ขอบเขต</td>
    <td class="tblHeader center" width="10%" style="padding-right:5px;">ยกเลิก</td>
    </tr>
    <%for(int i = 0; i < sysAdmin.getAdminList().size(); i++){
        Hashtable admin = (Hashtable)sysAdmin.getAdminList().get(i);
        Employee emp = new Employee(admin.get(sysAdmin.EMP_ID).toString());
        String roleDesc = sysAdmin.getRoleName(admin.get(sysAdmin.ROLE_ID).toString());
        String roleScope = admin.get(sysAdmin.ROLE_SCOPE).toString();
        %>
        <tr>
        <td class="tblRow<%=i % 2%> center"><%=i+1%></td>
        <td class="tblRow<%=i % 2%> left" style="padding-right:5px;"><%=emp.fullName%><br/><span style="font-size:0.9em;">สังกัด <%=emp.topORGName%></span></td>
        <td class="tblRow<%=i % 2%> left" style="padding-right:5px;"><%=roleDesc%></td>
        <td class="tblRow<%=i % 2%> left" style="padding-right:5px;"><%if(roleScope.equals(sysAdmin.GLOBAL_SCOPE)){%>ทั้งหมด<%}else{%>เฉพาะหน่วยสังกัด<%}%></td>
        <td class="tblRow<%=i % 2%> center"><input type="checkbox" name="<%=thisForm.ELM_NAME_EMP_ID%>" value="<%=emp.empId%>"></td>
        </tr>
    <%}%>
        <tr>
        <td colspan="4">&nbsp;</td>
        <td class="center"><input type="button" name="btnSelectOrg" value="  ยกเลิก  " onclick="removeAdmin();"></td>
        </tr>
    </table>
     <%}else{%>
        ไม่มี
<%}%>
</form>
<p>
<h3 style="border-bottom:#555555 1px solid;clear:both;">เพิ่มเจ้าหน้าดูแลระบบ</h3>
<form name="frmSearch" class="left" action="index.jsp#frmSearch" method="post">
<input type="hidden" name="<%=FrmSearchEmployee.ELM_NAME_PAGE_NO%>" value="1"/>
<input type="hidden" name="<%=FrmSearchEmployee.ELM_NAME_IS_NEW_SEARCH%>" value="1"/>
ชื่อ <input type="text" name="<%=FrmSearchEmployee.ELM_NAME_KEYWORD%>" value="<%=searchForm.getValue(searchForm.ELM_NAME_KEYWORD)%>"> <input type="submit" name="btnSubmit" value="ค้นหา"/>
</form>
<%if(searchForm.isContainKeyword && searchForm.searchResult.size() > 0){
    int numOfPage = searchForm.maxItem/searchForm.pageSize;
    if(searchForm.maxItem%searchForm.pageSize > 0) numOfPage++;
    int pageNo = searchForm.pageNo;
    %>
    <p class="block" style="padding:3px;">
        พบบุคลากรที่มีชื่อตรงกับที่ต้องการค้นหาจำนวน <%=searchForm.maxItem%> รายชื่อดังต่อไปนี้
    </p>
    <script>
        function gotoPage(pageNo){
            document.frmSearch.<%=FrmSearchEmployee.ELM_NAME_PAGE_NO%>.value = pageNo;
            document.frmSearch.submit();
        }        
    </script>
    <p class="right">
    หน้า
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
            if(confirm("กรุณายืนยันการกำหนดบุคลากรที่ถูกเลือกให้เป็นผู้ดูแลระบบ")){
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
    <td class="tblHeader center" width="10%">ลำดับ</td>
    <td class="tblHeader left" width="25%" style="padding-right:5px;">ชื่อ-นามสกุล</td>
    <td class="tblHeader left" width="30%" style="padding-right:5px;">สังกัด</td>
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
            <a href="#normEmp" onclick="setToAdmin('<%=emp.empId%>');">ตั้งให้เป็นเจ้าหน้าที่ดูแลระบบ</a>
        </td>
        </tr>
    <%}%>
    </table>
     <%}else if(searchForm.isNewSearch){%>
        <p class="block" style="padding:3px;">
            ไม่พบบุคลากรที่ต้องการค้นหา
        </p>
<%}%>
</p>
