<%@ page contentType = "text/html; charset=euc-kr" %>
<%@ page isErrorPage = "true" %>

<html>
<head><title>Error Occured</title></head>
<body>
Request processing error<br>
<p>
Error Type: <%= exception.getClass().getName() %> <br>
Error Message: <%= exception.getMessage() %> <br>
</p>
</body>
</html>

