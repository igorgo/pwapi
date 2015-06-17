<%@ include file="bbb_api.jsp"%>
<%
  request.setCharacterEncoding("UTF-8");
  response.setCharacterEncoding("UTF-8");
String base_url_create = BigBlueButtonURL + "api/create?";
String base_url_join = BigBlueButtonURL + "api/join?";
String base_url_end = BigBlueButtonURL + "api/end?";

Random random = new Random();
String voiceBridge_param = "&voiceBridge=" + (70000 + random.nextInt(9999));

String welcome = "Добро пожаловать на вебинар «%%CONFNAME%%»";

String action = request.getParameter("action");
String username = request.getParameter("username");
String id = request.getParameter("id");
String name = request.getParameter("name");
String pass = request.getParameter("pass");
String record = request.getParameter("record");
/*if (record == null || record.isEmpty()) {
  record = "false";
} else {
  record = "true";
}*/

if (action.equals("create")) {
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
<%= "{ \"status\":\"ok\",\"url\":\"" + joinURL + "\" }" %>
<%
 } else {
%>
<%= "{ \"status\":\"bad\" }" %>
<%
}
} else if (action.equals("end")) {
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
<%= "{ \"status\":\"ok\" }" %>
<%
 } else {
%>
<%= "{ \"status\":\"bad\" }" %>
<%
}
}
%>

<%@ page contentType="application/json;charset=UTF-8" %>



