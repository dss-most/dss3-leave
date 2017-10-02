<%@page contentType="text/html"%>
<%@page pageEncoding="TIS-620"%>
<%@page import="gitex.tu.*"%>
<%
LeaveReqHtmlPage.logoutUser(session);
%>
<br>
<p class="block center">
 ท่านได้ออกจากระบบการลาเรียบร้อยแล้ว ขอบคุณที่ใช้บริการ<br><br>
 <input type="button" value="     OK     " onclick="window.opener=null;window.close()">
</p>