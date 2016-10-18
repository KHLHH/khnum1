<%@ page contentType = "text/html; charset=euc-kr" %>
<%@ page import = "util.CookieBox" %>
<%
CookieBox cookieBox = new CookieBox(request);
boolean login = cookieBox.exists("LOGIN") && cookieBox.getValue("LOGIN").equals("SUCCESS");

%>
<html>
<head><title>로그인여부 검사</title></head>
<body>
<%
	if(login){
		out.print("아이디 "+cookieBox.getValue(" ID")+"로 로그인 한 상태");
	} else {
		out.print("로그인 하지 않은 상태");
	}

%>


</body>
</html>
