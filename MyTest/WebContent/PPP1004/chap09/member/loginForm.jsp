<%@ page contentType = "text/html; charset=euc-kr" %>
<html>
<head><title>�α�����</title></head>
<body>

<form action="<%= request.getContextPath() %>/chap09/member/login.jsp" method="post">
	ID : <input type="text" name="id" size="10">
	Password : <input type="password" name="password" size="10">
	<input type="submit" value="�α���">
</form>


</body>
</html>