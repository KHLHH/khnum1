<%@ page contentType = "text/html; charset=utf-8" %>
<%@ page buffer="8kb" autoFlush="false" %>
<html>
<head><title>autoFlush 속성값 예제</title></head>
<body>

<%  for (int i = 0 ; i < 1000 ; i++) {   %>
1234
<%  }  %>

</body>
</html>
