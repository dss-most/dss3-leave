<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>
<%@page import="java.util.*"%>
<%@page import="gitex.tu.htmlForm.*"%>
<%@page import="gitex.tu.*"%>
<%@page import="gitex.html.*"%>
<%
LeaveReqHtmlPage thisPage = new LeaveReqHtmlPage(session, request);
LutLeaveReqTaskCode taskCode = new LutLeaveReqTaskCode();
FrmCmdTree thisForm = new FrmCmdTree(request, thisPage.getUser());
String orgId = thisForm.getValue(thisForm.ELM_NAME_ORG_ID);
if(orgId.equals("")) orgId = "0";
LeaveOrg thisOrg = new LeaveOrg(orgId);
FrmSearchEmployee searchForm = new FrmSearchEmployee(request);
%>   
<form name="frmUpdateEmp" action="index.jsp" method="post">
    <input type="hidden" name="<%=thisForm.ELM_NAME_ORG_ID%>" value="<%=orgId%>"/>
    <input type="hidden" name="<%=thisForm.ELM_NAME_MOVE_TO_ORG_ID%>" value=""/>
    <input type="hidden" name="<%=thisForm.ELM_NAME_EMP_ID%>" value=""/>
    <input type="hidden" name="<%=thisForm.ELM_NAME_TASK%>" value=""/>
</form>    
<script>
    function updateEmp(taskId, empId){
        document.frmUpdateEmp.<%=thisForm.ELM_NAME_EMP_ID%>.value = empId;
        document.frmUpdateEmp.<%=thisForm.ELM_NAME_TASK%>.value = taskId;
        document.frmUpdateEmp.submit();
    }
    function moveEmp(empId, orgId){
        document.frmUpdateEmp.<%=thisForm.ELM_NAME_MOVE_TO_ORG_ID%>.value = orgId;
        document.frmUpdateEmp.<%=thisForm.ELM_NAME_EMP_ID%>.value = empId;
        document.frmUpdateEmp.<%=thisForm.ELM_NAME_TASK%>.value = <%=thisForm.MOVE_EMP%>;
        document.frmUpdateEmp.submit();
    }
</script>
<h3>โครงสร้างบุคลากร <%//=thisOrg.name%></h3>
<%//if(thisOrg.pathId.size() > 1){%>
    <p class="block" style="font-size:smaller;padding:3px 3px 3px 10px;">
    <%for(int i = thisOrg.pathId.size() - 1; i >= 0; i--){%>
        <%if(i < thisOrg.pathId.size() - 1){%>&gt;<%}%>
        <a href="index.jsp?<%=FrmCmdTree.ELM_NAME_ORG_ID%>=<%=thisOrg.pathId.get(i).toString()%>"><%=thisOrg.pathName.get(i).toString()%></a>
    <% }%>
    </p>
<%//}%>
<h3 style="border-bottom:#555555 1px solid;">หน่วยงานย่อย</h3>
<%if(thisOrg.childId.size() > 0){
    int numOfItem = thisOrg.childId.size();
    if(numOfItem%2 == 1) numOfItem++;
    int counter = 0;
    %>
    <div class="right" style="font-size:smaller;">[<a href="#org" onclick="document.getElementById('org').style.display='none';">ซ่อน</a>-<a href="#org" onclick="document.getElementById('org').style.display='block';">แสดง</a>]</div>
    <div id="org">
    <p style="float:left;width:50%;">
    <%for(int i = 0; i < numOfItem/2; i++){
        counter++;
        %>
        <a class="mainlink" href="index.jsp?<%=FrmCmdTree.ELM_NAME_ORG_ID%>=<%=thisOrg.childId.get(i).toString()%>"><%=thisOrg.childName.get(i).toString()%></a>
    <%}%>
    </p>
    <p style="float:left;width:50%;">
    <%for(int i = counter; i < thisOrg.childId.size(); i++){%>
        <a class="mainlink" href="index.jsp?<%=FrmCmdTree.ELM_NAME_ORG_ID%>=<%=thisOrg.childId.get(i).toString()%>"><%=thisOrg.childName.get(i).toString()%></a>
    <%}%>
    </p>
    </div>
<%}else{%>
    <p class="block" style="padding:3px;">
        ไม่มีหน่วยงานย่อย
    </p>
<%}%>    

<h3 style="border-bottom:#555555 1px solid;clear:both;">บุคลากร</h3>
<%if(!thisOrg.commanderName.equals("") || thisOrg.supervisorId.size() > 0  || thisOrg.empId.size() > 0){%>
    <div class="right" style="font-size:smaller;">[<a href="#employee" onclick="document.getElementById('employee').style.display='none';">ซ่อน</a>-<a href="#employee" onclick="document.getElementById('employee').style.display='inline';">แสดง</a>]</div>
    <div id="employee">  
        <p>
        <span class="blue">ผู้มีอำนาจพิจารณาคำร้อง</span> : <%if(!thisOrg.commanderName.equals("")){%><%=thisOrg.commanderName%><%}else{%>ไม่มี<%}%>
        <p/>
        <p>
        <span class="blue">ผู้มีอำนาจพิจารณาคำร้องแทน</span> : 
        <%if(thisOrg.supervisorId.size() > 0){%>
            <table width="100%">
            <tr>
            <td class="tblHeader center" width="10%">ลำดับ</td>
            <td class="tblHeader left" width="20%" style="padding-right:5px;">ชื่อ-นามสกุล</td>
            <td class="tblHeader left" width="30%" style="padding-right:5px;">ตำแหน่ง</td>
            <td class="tblHeader left" width="40%" style="padding-right:5px;">กำหนดหน้าที่</td>
            </tr>
            <%for(int i = 0; i < thisOrg.supervisorId.size(); i++){%>
                <tr>
                <td class="tblRow<%=i % 2%> center"><%=i+1%></td>
                <td class="tblRow<%=i % 2%> left" style="padding-right:5px;"><%=thisOrg.supervisorName.get(i).toString()%></td>
                <td class="tblRow<%=i % 2%> left" style="padding-right:5px;"><%=thisOrg.supervisorTitle.get(i).toString()%></td>
                <td class="tblRow<%=i % 2%> left" style="padding-right:5px;font-size:smaller;">
                    <li><a href="#normEmp" onclick="if(confirm('กรุณายืนยันการกำหนดหน้าที่อีกครั้ง')) updateEmp('<%=thisForm.SET_TO_COMMANDER%>', '<%=thisOrg.supervisorId.get(i).toString()%>');">ให้เป็นผู้มีอำนาจพิจารณาคำร้อง</a> 
                    <li><a href="#normEmp" onclick="if(confirm('กรุณายืนยันการกำหนดหน้าที่อีกครั้ง')) updateEmp('<%=thisForm.SET_TO_NORMAL%>', '<%=thisOrg.supervisorId.get(i).toString()%>');">ให้เป็นบุคลากรอื่นๆ</a>
                </td>
                </tr>
            <%}%>
            </table>
        <%}else{%>
                ไม่มี
        <%}%>
        </p>
        <form name="frmEmployee" action="index.jsp" method="post">
        <input type="hidden" name="<%=thisForm.ELM_NAME_ORG_ID%>" value="<%=orgId%>"/>
        <input type="hidden" name="<%=thisForm.ELM_NAME_MOVE_TO_ORG_ID%>" value=""/>
        <input type="hidden" name="<%=thisForm.ELM_NAME_TASK%>" value="<%=thisForm.MOVE_EMP%>"/>
        <script>
            function doSelectOrg(orgId, orgName){
                if(confirm("กรุณายืนยันการย้ายบุคลากรที่เลือกไปยัง " + orgName)){
                    document.frmEmployee.<%=thisForm.ELM_NAME_MOVE_TO_ORG_ID%>.value = orgId;
                    document.frmEmployee.submit();
                }
            }
        </script>
        <span class="blue">บุคลากรอื่นๆ</span> : 
        <%if(thisOrg.empId.size() > 0){%>
            <table width="100%" id="normEmp">
            <tr>
            <!--td class="tblHeader center" width="10%">ลำดับ</td-->
            <td class="tblHeader left" width="25%" style="padding-right:5px;">ชื่อ-นามสกุล</td>
            <td class="tblHeader left" width="25%" style="padding-right:5px;">ตำแหน่ง</td>
            <td class="tblHeader left" width="40%" style="padding-right:5px;">กำหนดหน้าที่</td>
            <td class="tblHeader left" width="10%" style="padding-right:5px;">ย้ายออก</td>
            </tr>
            <%for(int i = 0; i < thisOrg.empId.size(); i++){%>
                <tr>
                <!--td class="tblRow<%=i % 2%> center"><%=i+1%></td-->
                <td class="tblRow<%=i % 2%> left" style="padding-right:5px;"><%=thisOrg.empName.get(i).toString()%></td>
                <td class="tblRow<%=i % 2%> left" style="padding-right:5px;font-size:smaller;"><%=thisOrg.empTitle.get(i).toString()%></td>
                <td class="tblRow<%=i % 2%> left" style="padding-right:5px;font-size:smaller;">
                    <li><a href="#normEmp" onclick="if(confirm('กรุณายืนยันการกำหนดหน้าที่อีกครั้ง')) updateEmp('<%=thisForm.SET_TO_COMMANDER%>', '<%=thisOrg.empId.get(i).toString()%>');">ให้เป็นผู้มีอำนาจพิจารณาคำร้อง</a>
                    <li><a href="#normEmp" onclick="if(confirm('กรุณายืนยันการกำหนดหน้าที่อีกครั้ง')) updateEmp('<%=thisForm.SET_TO_SUPERVISOR%>', '<%=thisOrg.empId.get(i).toString()%>');">ให้เป็นผู้มีอำนาจพิจารณาคำร้องแทน</a>
                </td>
                <td class="tblRow<%=i % 2%> center"><input type="checkbox" name="<%=thisForm.ELM_NAME_EMP_ID%>" value="<%=thisOrg.empId.get(i).toString()%>"></td>
                </tr>
            <%}%>
                <tr>
                <td colspan="3">&nbsp;</td>
                <td class="center"><input type="button" name="btnSelectOrg" value="  ย้าย  " onclick="popUp('frmSelectOrg.jsp', 'frmSelectOrg', '450', '450');"></td>
                </tr>
            </table>
             <%}else{%>
                ไม่มี
        <%}%>
        </form>
    </div>
<%}else{%>
    <p class="block" style="padding:3px;">
        ไม่มีบุคลากร
    </p>
<%}%>    
<p>
<h3 style="border-bottom:#555555 1px solid;clear:both;">บุคลากรเพื่อย้ายเข้า</h3>
<form name="frmSearch" class="left" action="index.jsp#frmSearch" method="post">
<input type="hidden" name="<%=FrmCmdTree.ELM_NAME_ORG_ID%>" value="<%=thisOrg.orgId%>"/>
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
    <table width="100%" id="normEmp">
    <tr>
    <td class="tblHeader center" width="10%">ลำดับ</td>
    <td class="tblHeader left" width="25%" style="padding-right:5px;">ชื่อ-นามสกุล</td>
    <td class="tblHeader left" width="40%" style="padding-right:5px;">สังกัด</td>
    <td class="tblHeader left" width="25%" style="padding-right:5px;">กำหนดการย้าย</td>
    </tr>
    <%for(int i = 0; i < searchForm.searchResult.size(); i++){
        Employee emp = (Employee)searchForm.searchResult.get(i);
        %>
        <tr>
        <td class="tblRow<%=i % 2%> center"><%=i+1%></td>
        <td class="tblRow<%=i % 2%> left" style="padding-right:5px;"><%=emp.fullName%></td>
        <td class="tblRow<%=i % 2%> left" style="padding-right:5px;"><%=emp.parentORGName%></td>
        <td class="tblRow<%=i % 2%> left" style="padding-right:5px;font-size:smaller;">
            <a href="#normEmp" onclick="if(confirm('กรุณายืนยันการย้ายบุคลากรเข้าหน่วยงานนี้อีกครั้ง')) moveEmp('<%=emp.empId%>', '<%=thisOrg.orgId%>');">ย้ายเข้าหน่วยงานนี้</a>
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
