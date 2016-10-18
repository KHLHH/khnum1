<%@ page contentType = "text/html; charset=utf-8" %>
<%@ page import = "java.util.Calendar" %>
<html>
<head><title>현재 시간</title></head>
<body>
<%
	Calendar cal = (Calendar) request.getAttribute("time");
	String name = request.getParameter("name");
%>
CurrentTime : <%= cal.get(Calendar.HOUR) %> HH
<%= cal.get(Calendar.MINUTE) %> MM
<%= cal.get(Calendar.SECOND) %> SS
<br>
이름은 <%= name %>입니다.
</body>
</html>

