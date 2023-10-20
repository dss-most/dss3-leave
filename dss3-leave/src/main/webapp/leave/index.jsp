<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>
<%@page import="java.util.*"%>
<%@page import="gitex.tu.*"%>
<%@page import="gitex.html.*"%>
<%@page import="gitex.tu.htmlForm.*"%>
<%
request.setCharacterEncoding("utf-8");   
LeaveReqHtmlPage thisPage = new LeaveReqHtmlPage(session, request);
LutLeaveReqTaskCode task = new LutLeaveReqTaskCode();
LutLeaveReqMenuCode menu = new LutLeaveReqMenuCode();
User user = thisPage.getUser();
ArrayList userMenu = user.userModule.moduleCode;
ArrayList adminMenu = user.adminModule.moduleCode;
gitex.utility.Date date = new gitex.utility.Date();   

//out.println( thisPage.getUser());
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">

<%@page import="th.go.dss.BuildInfo"%><html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=tis-620" />
<meta name="description" content="TU Web Application" />
<meta name="keywords" content="ระบบการลาม, ธรรมศาสตร์" />
<meta name="author" content="Disillusion  / Original design: Andreas Viklund - http://andreasviklund.com/" />
<script language="JavaScript" type="text/javascript" src="js/gen_validatorv.js"></script>
<script language="JavaScript" type="text/javascript" src="js/popUp.js"></script>
<script language="JavaScript" type="text/javascript" src="js/jquery-1.9.0.js"></script>
<script language="JavaScript" type="text/javascript" src="js/jquery-ui-1.10.0.custom.min.js"></script>
<script language="JavaScript" type="text/javascript" src="js/jquery.ui.datepicker-th.js" charset="utf-8"></script>
<script language="JavaScript" type="text/javascript" src="js/jquery.ui.datepicker.ext.be.js"></script>
<script language="JavaScript" type="text/javascript" src="js/handlebars-1.0.0.beta.6.js"></script>
<script language="JavaScript" type="text/javascript" src="js/fullcalendar.js"></script>

<link rel="stylesheet" type="text/css" href="css/andreas02.css" media="screen"  />
<link rel="stylesheet" type="text/css" href="css/addOn.css" media="screen"  />
<link rel="stylesheet" type="text/css" href="css/print.css" media="print" />
<link rel="stylesheet" type="text/css" href="css/fullcalendar.css" />
<link rel="stylesheet" type="text/css" href="css/smoothness/jquery-ui-1.10.0.custom.css" />
<title>กรมวิทยาศาสตร์บริการ : ระบบการลา</title>
</head>

<body onclick="if(document.all['calendar']) hideCalendar();">
<div id="toptabs">
<p>ระบบงาน :
<a class="activetoptab" href="index.jsp">การลา</a><span class="hide"> | </span>
<!--a class="toptab" href="index.html">ข้อมูลส่วนตัว</a><span class="hide"> | </span-->
</div>

<div id="container">
<div id="logo">
<h2>กรมวิทยาศาสตร์บริการ กระทรวงการอุดมศึกษา วิทยาศาสตร์  วิจัยและนวัตกรรม</h2>
</div>

<!--p class="block">
Menu code = <%=thisPage.getMenuCode()%><br>
Task code = <%=thisPage.getTaskCode()%><br>
Form name = <%=task.getJSPFormName(thisPage.getTaskCode())%><br>
User role = <%=user.getRole(user.ROLE_TYPE_USER)%><br>
Admin role = <%=user.getRole(user.ROLE_TYPE_ADMIN)%><br>
Admin scope = <%if(user.isGlobalAdmin){%>Global<%}else{%>Local<%}%>
</p-->

<div id="navitabs">
<h2 class="hide">Site menu:</h2>
<%
for(int i = 0; i < userMenu.size(); i++){%>
    <a class="<%if(userMenu.get(i).toString().equals(thisPage.getMenuCode())){%>activenavitab<%}else{%>navitab<%}%>" href="index.jsp?<%=LutGlobalRequestName.MENU_CODE%>=<%=userMenu.get(i)%>&<%=LutGlobalRequestName.TASK_CODE%>=<%=menu.getInitialTaskCode(userMenu.get(i).toString())%>"><%=user.userModule.getName(userMenu.get(i).toString())%></a><span class="hide"> | </span>
<%}%>
</div>
<div id="desc">

<table>
    <tr>
    <td style="padding-top:20px; padding-left:20px;">
    	<%if(user.employee.idCardNo != null) { %>
    		<img width="85" height="100" src="http://dpis.dss.local:8080/attachment/pic_personal/<%=user.employee.idCardNo%>-001.jpg"/>
    	<%}else{%>
    	
    	<%}%>
    </td>
    <td>
    


<%if(!thisPage.getErrMsg().equals("")){%>
	<p>
        <%=thisPage.getErrMsg()%>
    </p>
<%}else{%>
    <%if(user.getRole(user.ROLE_TYPE_USER).equals(user.ROLE_NONE_USER)){%>
    <p style="margin-top: 40px;">
        ระบบการลาออนไลน์ เป็นระบบการขออนุญาตลาผ่านเครือข่ายอินเตอร์เน็ต ซึ่งเป็นระบบที่จัดทำขึ้นเพื่ออำนวยความสะดวก
        ให้แก่เจ้าหน้าที่ของ กรมวิทยาศาสตร์บริการฯ ในการขออนุญาตลา ด้วยระบบนี้เจ้าหน้าที่ฯ สามารถขออนุญาตลา หรือตรวจสอบผลการลา
เฉพาะภายในวศ. เท่านั้น
	</p>
	<%}else{%>
	 <h2>
       วันนี้ <%=date.getDate(date.getDate(date.DATE_THAI), date.MONTH_NAME_SHORT).get(date.DATE_THAI).toString() %> 
       ลงเวลาเข้าทำงาน: <%=user.getEarliestFingerScanToday() %> 
       <br/>
      	เวลาเลิกงาน: <%=user.getLeaveFingerScanToday()%> 
 	 </h2>
 	<p style="margin-top: -18px;">  	* เวลาเข้าทำงานจะปรากฎหลัง 10.30น. กรณีลาครึ่งวันจะต้องมีเวลาปฏิบัติราชการไม่น้อยกว่า 4 ชั่วโมง </p>
	<p>
        ผู้ใช้ระบบ : <%=user.employee.fullName%><br/>
        ตำแหน่ง <%=user.employee.workTitle%>
        สังกัด <%=user.employee.topORGName%><br/>
        บรรจุ <%=date.getDate(user.employee.startWorkDate, date.MONTH_NAME_SHORT).get(date.DATE_THAI).toString()%>
        อายุราชการ(งาน) <%=user.employee.numOfWorkYear%> ปี <%=user.employee.numOfWorkMonth % 12%> เดือน <br/>
        
    </p>
    
    <%}%>
<%}%>
    
    
   	</td>
   	</tr>
 </table>
</div>
    
<div id="main">
<p>
<jsp:include page="<%=task.getJSPFormName(thisPage.getTaskCode())%>"></jsp:include>
</p>
</div> 
<%//=thisPage.getTaskCode() %>
<div id="sidebar">
<%if(adminMenu.size() > 0){%>
    <h3>งานผู้ดูแลระบบ : </h3>
    <p>
    <%for(int i = 0; i < adminMenu.size(); i++){%>
        <a class="sidelink" href="index.jsp?<%=LutGlobalRequestName.MENU_CODE%>=<%=menu.WELCOME%>&<%=LutGlobalRequestName.TASK_CODE%>=<%=menu.getInitialTaskCode(adminMenu.get(i).toString())%>"><%=user.adminModule.getName(adminMenu.get(i).toString())%></a><span class="hide"> | </span>
    <%}%>
    </p>
<%}%>    
<h3>ข้อมูลเพิ่มเติม : </h3>
<p>ท่านสามารถอ่านข้อมูลเพิ่มเติมจากลิงค์ดังต่อไปนี้</p>

<p><a class="sidelink" href="http://ethan.dss.local/km/index.php/%E0%B8%A3%E0%B8%B0%E0%B8%9A%E0%B8%9A%E0%B8%A5%E0%B8%B2" target ="_blank" ">คู่มือการใช้งานระบบ</a><span class="hide"> | </span>
<a class="sidelink" href="#">คำถามที่พบบ่อย(FAQ)</a><span class="hide"> | </span>
<a class="sidelink" href="#">ติดต่อสอบถาม</a><span class="hide"> | </span>
</div>

<div id="footer">
	กลุ่มเทคโนโลยีสารสนเทศ สท. VERSION=<%=th.go.dss.BuildInfo.revision%> with connection url= <%=th.go.dss.BuildInfo.databaseUrl %>
</div>

</body>
</html>
