

<%@ page contentType ="text/html; charset=euc-kr"%>
<%@ page errorPage ="error/error404.jsp" %>
<html>
<head><title>Parameter Show</title></head>
<body>

name Parameter value : <%= request.getParameter("name").toUpperCase()%>

</body>
</html>



