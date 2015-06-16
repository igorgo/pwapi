<%--
  Created by IntelliJ IDEA.
  User: igor-go
  Date: 16.06.2015
  Time: 9:08
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="common.jsp"%>
<%
    String first_name = request.getParameter("first_name");
    String last_name = request.getParameter("last_name");
    String firm = request.getParameter("firm");
    String meetingid = request.getParameter("meetingid");
    String user = urlEncode(last_name + " " + first_name + " (" + firm + ")");
    String base_url_join = BigBlueButtonURL + "api/join?";
    String join_parameters = "meetingID=" + urlEncode(meetingid)
            + "&fullName=" + user + "&password=ap";
    String joinURL = base_url_join + join_parameters + "&checksum="
            + checksum("join" + join_parameters + salt);
%>

<script language="javascript" type="text/javascript">
    window.location.href="<%=joinURL%>";
</script>

</body>
</html>
