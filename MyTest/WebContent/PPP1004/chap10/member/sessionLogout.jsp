<%@ page contentType = "text/html; charset=utf-8" %>
<%
session.invalidate();
%>


<html>
<head><title>Logout</title></head>
<body>
Now you're logged out.
<a href="sessionLoginForm.jsp"><input type="button" value="LogOut"></a>
</body>
</html>

