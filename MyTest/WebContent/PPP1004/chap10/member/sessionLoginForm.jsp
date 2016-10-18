<%@ page contentType="text/html; charset=utf-8" %>
<html>

<head><title>Login Form</title></head>
<body>
<form action="<%= request.getContextPath() %>/chap10/member/sessionLogin.jsp" method="post">
	ID: <input type="text" name="id" size="10">
	PW: <input type="password" name="password" size="10">
	<input type="submit" value="로그인">
</form>
</body>
</html>

