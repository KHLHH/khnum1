<%@ page contentType = "text/html; charset=utf-8" %>
<html>
<head><title>out 기본 객체 사용</title></head>
<body>
안녕하세요?<br>
<%= "안녕하세요?" %><br>
<% out.println("안녕하세요?"); %>
<br>
out 기본 객체를 사용하여 
<%
	out.println("출력한 결과입니다.");
%>
<%--  
<% if(value > 50){%>
<%= "A" %>
<% }else if(value >= 25){ %>
<%= "B" %>
<% } %>

<% 
if(value > 50){
 out.println("A");
}else if(value >= 25){
 out.println("B");
 } 
 %>  --%>


</body>
</html>













