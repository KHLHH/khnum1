<%@ page contentType = "text/html; charset=euc-kr" %>
<%@ page import ="util.CookieBox" %>
<html>
<head><title>CookieBox��뿹</title></head>
<body>
<%
response.addCookie(CookieBox.createCookie("name","su"));
response.addCookie(CookieBox.createCookie("id","madvirus","/",-1));
%>
CookieBox�� ����Ͽ� ��Ű ����

</body>
</html>
