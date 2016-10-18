<%@ page contentType = "text/html; charset=utf-8" %>
<%
String id = request.getParameter("id");
String password = request.getParameter("password");
if(id.equals("")){
	%>
<script>
alert("None ID Entered");
history.go(-1);
</script>
	<%
}

if(id.equals(password)){
	session.setAttribute("MEMBERID", id);
	%>
<jsp:forward page="sessionLoginCheck.jsp" />
	<%
} else {
%>
<script>
alert("Login failed");
history.go(-1);
</script>
<%
}


%>