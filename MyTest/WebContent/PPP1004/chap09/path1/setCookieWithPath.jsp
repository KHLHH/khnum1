<%@ page contentType = "text/html; charset=euc-kr" %>
<%@ page import = "java.net.URLEncoder" %>
<%@ page import = "java.net.URLDecoder" %>
<% 
Cookie cookie1 = new Cookie("path1",
		URLEncoder.encode(":/chap09/path1","euc-kr"));
cookie1.setPath("/SepJSP/chap09/path1");
response.addCookie(cookie1);
Cookie cookie2 = new Cookie("path2",
		URLEncoder.encode(":unset","euc-kr"));
response.addCookie(cookie2);
Cookie cookie3 = new Cookie("path3",
		URLEncoder.encode(":/","euc-kr"));
cookie3.setPath("/");
response.addCookie(cookie3);
Cookie cookie4 = new Cookie("path4",
		URLEncoder.encode(":/chap09/path2","euc-kr"));
cookie4.setPath("/SepJSP/chap09/path2");
response.addCookie(cookie4);

%>


<html>
<head><title>쿠키 경로 지정</title></head>
<body>

다음과 같이 쿠키를 생성했습니다.<br>
<%= cookie1.getName() %>=<%= URLDecoder.decode(cookie1.getValue(),"utf-8") %>
[<%= cookie1.getPath() %>]
<br>
<%= cookie2.getName() %>=<%= URLDecoder.decode(cookie2.getValue(),"utf-8") %>
[<%= cookie2.getPath() %>]
<br>
<%= cookie3.getName() %>=<%= URLDecoder.decode(cookie3.getValue(),"utf-8") %>
[<%= cookie3.getPath() %>]
<br>
<%= cookie4.getName() %>=<%= URLDecoder.decode(cookie4.getValue(),"utf-8") %>
[<%= cookie4.getPath() %>]

</body>
</html>
