<%--
  Created by IntelliJ IDEA.
  User: igor-go
  Date: 15.06.2015
  Time: 12:23
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="common.jsp"%>
  <%
  String base_url_create = BigBlueButtonURL + "api/create?";
  String base_url_join = BigBlueButtonURL + "api/join?";

  Random random = new Random();
  String voiceBridge_param = "&voiceBridge=" + (70000 + random.nextInt(9999));

  String welcome = "Добро пожаловать на вебинар «%%CONFNAME%%»";
  String username = request.getParameter("username");
  String id = request.getParameter("id");
  String name = request.getParameter("name");
  String pass = request.getParameter("pass");
  String record = request.getParameter("record");
  if (record == null || record.isEmpty()) {
    record = "false";
  } else {
    record = "true";
  }

  String create_parameters = "name=" + urlEncode(name)
          +"&meetingID=" + urlEncode(id)
          + "&attendeePW=ap"
          + "&moderatorPW=" + urlEncode(pass)
          + "&welcome=" +  urlEncode(welcome)
          + voiceBridge_param
          +"&record=" + record;
// Attempt to create a meeting using meetingID
  Document doc = null;
  try {
    String url = base_url_create + create_parameters
            + "&checksum="
            + checksum("create" + create_parameters + salt);
    doc = parseXml( postURL( url, "" ) );
  } catch (Exception e) {
    e.printStackTrace();
  }

    String joinURL;

  if (doc.getElementsByTagName("returncode").item(0).getTextContent()
          .trim().equals("SUCCESS")) {

    //
    // Looks good, now return a URL to join that meeting
    //

    String join_parameters = "meetingID=" + urlEncode(id)
            + "&fullName=" + urlEncode(username) + "&password=" + urlEncode(pass);

    joinURL = base_url_join + join_parameters + "&checksum="
            + checksum("join" + join_parameters + salt);
  } else {
    joinURL = "";
  }

    if (joinURL.startsWith("http://")) {
  %>

  <script language="javascript" type="text/javascript">
    window.location.href="<%=joinURL%>";
  </script>

  <%
    }


%>
</body>
</html>
