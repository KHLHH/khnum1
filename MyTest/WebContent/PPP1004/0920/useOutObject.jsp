<%@ page contentType = "text/html; charset=utf-8"%>
<html>
<head><title>out basic object usage</title></head>
<body>
Hello?<br>
<%= "Hello?" %><br>
<% out.println("Hello?"); %><br>
</body>
</html>


<% int value=60; %>

<% if(value > 50){%>
<%= "A" %>
<% }else if(value >= 25){ %>
<%= "B" %>
<% }  %>

<%
if(value > 50){
 out.println("A");
}else if(value >= 25){
 out.println("B");
 } 
 %>  