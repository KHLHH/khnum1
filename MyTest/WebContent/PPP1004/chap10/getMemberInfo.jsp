<%@ page contentType="text/html; charset=EUC-KR" %>
<html>
<head>
<title>session</title>
</head>
<body>
<% String id = (String)session.getAttribute("MEMBERID"); %>
<% String name = (String)session.getAttribute("NAME"); %>
<p>Session saved value</p>
id : <%= id %><br>
name : <%= name %><br>

</body>
</html>