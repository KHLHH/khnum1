<%@ page contentType="text/html; charset=utf-8" %>
<html>
<head><title>Server Info Out - Using application object</title></head>
<body>
Server Info : <%=application.getServerInfo() %><br>
Servlet Minor Version : <%=application.getMajorVersion() %> <br> 
Servlet Major Version : <%=application.getMinorVersion() %> <br> 

</body>
</html>



