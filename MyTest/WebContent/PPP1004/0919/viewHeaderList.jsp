<%@ page contentType = "text/html; charset=utf-8" %>
<%@ page import = "java.util.Enumeration" %>

<html>
<head><title>Header List output</title></head>
<body>
<%
Enumeration headerEnum = request.getHeaderNames();
while(headerEnum.hasMoreElements() ){
	String headerName = (String)headerEnum.nextElement();
	String headerValue = request.getHeader(headerName);

%>
<font size="6">
<%= headerName %> = <%= headerValue %>

<%
	}
%><br>
</font>
</body>
</html>

