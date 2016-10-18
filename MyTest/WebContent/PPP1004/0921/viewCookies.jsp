<%@ page contentType = "text/html; charset=utf-8" %>
<%@ page import = "java.net.URLDecoder" %>
<html>
<head><title>쿠키 목록</title></head>
<body>
<br> 쿠키 목록<br>
<%
Cookie[] cookies = request.getCookies();
if(cookies != null && cookies.length >0 ){
	for(Cookie cookie: cookies){
		out.println("쿠키 이름 : "+cookie.getName()+"<br> 쿠키 값 : "+URLDecoder.decode(cookie.getValue(),"utf-8")+"<br><br>");	
	}
}
%>

</body>
</html>
