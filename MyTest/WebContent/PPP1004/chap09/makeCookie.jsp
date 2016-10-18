<%@ page contentType = "text/html; charset=utf-8" %>
<%@ page import = "java.net.URLEncoder" %>
<%
Cookie cookie =
	new Cookie("name",URLEncoder.encode("수","utf-8"));
response.addCookie(cookie);
%>
<html>
<head><title>쿠키생성</title></head>
<body>

쿠키 이름 : <%=  cookie.getName() %> <br>
쿠키 값    :  "<%= cookie.getValue() %>"

</body>
</html>
