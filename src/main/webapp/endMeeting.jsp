<%--
  Created by IntelliJ IDEA.
  User: igor-go
  Date: 16.06.2015
  Time: 10:13
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="common.jsp" %>
<%
    String base_url_end = BigBlueButtonURL + "api/end?";

    String id = request.getParameter("id");
    String pass = request.getParameter("pass");


    String end_parameters = "meetingID=" + urlEncode(id)
            + "&password=" + urlEncode(pass);

    Document doc = null;
    try {
        String url_end = base_url_end + end_parameters
                + "&checksum="
                + checksum("end" + end_parameters + salt);
        doc = parseXml(postURL(url_end, ""));
    } catch (Exception e) {
        e.printStackTrace();
    }

    if (doc.getElementsByTagName("returncode").item(0).getTextContent()
            .trim().equals("SUCCESS")) {
%>
<p>Webinar is over</p>
<%
} else {
%>
<p>Error occured while webinar was ending</p>
<%
    }
%>
</body>
</html>
