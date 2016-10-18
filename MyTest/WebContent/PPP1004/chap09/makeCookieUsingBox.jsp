<%@ page contentType = "text/html; charset=euc-kr" %>
<%@ page import ="util.CookieBox" %>
<html>
<head><title>CookieBox사용예</title></head>
<body>
<%
response.addCookie(CookieBox.createCookie("name","su"));
response.addCookie(CookieBox.createCookie("id","madvirus","/",-1));
%>
CookieBox를 사용하여 쿠키 생성

</body>
</html>
