<%@ page contentType="text/html; charset=utf-8" %>
<!DOCTYPE html>
<html>
<head>
<title>삭제</title>
</head>
<body>
<form action="delete.jsp" method="post">
<table border="1">
<tr>
	<td>아이디</td>
	<td><input type="text" name="memberID" size="10"></td>
	<td>암호</td>
	<td><input type="password" name="password" size="10"></td>
</tr>
<tr>
	<td colspan="4"><input type="submit" value="삭제"></td>
</tr>
</table>
</form>
</body>
</html>