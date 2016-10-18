<%@ page contentType="text/html; charset=utf-8" %>
<%
	String id = request.getParameter("memberId");
if(id == null){
%>
<html>
<head><title>Login - failure</title></head>
<body>
No ID sent - please add your id like <br>
?memeberId=##yourId## <br>
Without ## and place your Id like <br>
?memeberId=test <br>
</body>
</html>
<%	
} else if(id.equals("test")){
		response.sendRedirect("index.jsp");
	} else {
		%>
<html>
<head><title>Login - failure</title></head>
<body>
NO REGISTERED ID.
</body>
</html>
		<%
	}

%>


