<%@ page contentType = "text/html; charset=utf-8" %>
<%
	String id = request.getParameter("id");
	String password = request.getParameter("password");

	if (id != "") {

		if (id.equals(password)) {
			session.setAttribute("MEMBERID", id);
%>
<html>
<head>
<title>로그인성공</title>
</head>
<body>

	로그인에 성공했습니다.
	<form action="sessionLoginCheck.jsp">
		<input type="submit" value="check">
	</form>
</body>
</html>
<%
	} else { // 로그인 실패시
%>
<script>
	alert("로그인에 실패하였습니다.");
	history.go(-1);
</script>
<%
	}
	} else {
%>
<script>
	alert("id가 없습니다.");
	history.go(-1);
</script>
<%
	}
%>
