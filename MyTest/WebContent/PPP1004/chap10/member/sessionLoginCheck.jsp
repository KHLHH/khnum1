<%@ page contentType = "text/html; charset=utf-8" %>
<% 
String memberId = (String) session.getAttribute("MEMBERID");
boolean login = memberId == null ? false : true;
%>
<html>
<head><title>Login Check</title></head>
<body>
<% 
if(login){
	out.print("[ID : "+memberId+" ] is logged in <br>");
	%>
	<a href="sessionLogout.jsp"><input type="button" value="LogOut"></a>
	<%
} else {
	out.print("Not logged in status");
	%>
	<jsp:forward page="sessionLoginForm.jsp" />
	<%	
}

%>

</body>
</html>


