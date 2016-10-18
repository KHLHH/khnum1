<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import = "util.CookieBox" %>
<%
String id = request.getParameter("id");
String password = request.getParameter("password");

if (id.equals(password)){
	response.addCookie(
			CookieBox.createCookie("LOGIN","SUCCESS","/",-1)
			
			);
	response.addCookie(
			CookieBox.createCookie("ID",id,"/",-1)
			
			);
	%>
	<html>
	<head><title>로그인 성공</title></head>

	로그인에 성공했습니다.~~~


	</html>
<%
	
	
} else { // 로그인 실패시
	%>
	로그인에 실패했습니다.
	
	
	<%
	
	
	
}



%>


