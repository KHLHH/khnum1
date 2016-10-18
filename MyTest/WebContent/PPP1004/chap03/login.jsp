<%@ page contentType="text/html; charset=utf-8" %>
<%
	String id = request.getParameter("memberId");
	if (id.equals("test")) {//id가 test인 경우 == 로그인 성공
		response.sendRedirect("index.jsp");
	} else {
%>
<html>
<head><title>로그인에 실패</title></head>
<body>
잘못된 아이디입니다.
</body>
</html>
<%
	}
%>
