<%@ page contentType="text/html; charset=utf-8"%><%
	request.setCharacterEncoding("utf-8");
%>
<html>
<head><title>INFO</title></head>
<body>

include 전 name 파라미터 값: <%= request.getParameter("name") %>

<% request.setAttribute("date", new java.util.Date()); %>

<hr> 

<jsp:include page="body_sub.jsp" flush="false">
	<jsp:param name="name" value="su" />
</jsp:include>

<hr/>

include 후 name 파라미터 값: <%= request.getParameter("name") %>

</body>
</html>