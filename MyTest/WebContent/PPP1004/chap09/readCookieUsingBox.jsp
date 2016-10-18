<%@ page contentType = "text/html; charset=euc-kr" %>
<%@ page import="util.CookieBox" %>
<%
	CookieBox cookieBox = new CookieBox(request);
%>
<html>
<head><title>Cookie »ç¿ë</title></head>
<body>

<%
out.println("name Cookie : "
		+cookieBox.getValue("name")
		+"<br>id Cookie : "
		+cookieBox.getValue("id")
		);


%>

</body>
</html>
