<%@ page contentType = "text/html; charset=euc-kr" %>
<%@ page buffer="1kb" %>
<%@ page errorPage = "error/viewErrorMessage.jsp" %>
<html>
<head><title>Buffer Flush 이후 예외 발생 결과</title></head>
<body>

<% for(int i=0;i<256;i++){ out.println(i);} %>
<%= 1/0 %>
</body>
</html>