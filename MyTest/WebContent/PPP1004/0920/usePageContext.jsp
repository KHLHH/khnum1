<%@ page contentType = "text/html; charset=utf-8" %>
<html>
<head><title>pageContext 기본 객체</title></head>
<body>
<%
	HttpServletRequest requestFrMethod = (HttpServletRequest) pageContext.getRequest();
%>
Q: request basic object  and  pageContext.getRequest()  are same?:<br>
A: <%= request == requestFrMethod  %> <br>

pageContext.getOut() Method using data out;
<% pageContext.getOut().println("Hello!"); %>

</body>

</html>