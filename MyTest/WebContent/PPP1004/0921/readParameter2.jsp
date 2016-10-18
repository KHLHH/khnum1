<%@ page contentType = "text/html; charset=euc-kr" %>
<html>
<head><title>파라미터 출력</title></head>
<body>

name parameter value : <%= request.getParameter("name").toUpperCase() %>

</body>
</html>
