<%@ page contentType="text/html; charset=utf-8" %>
<jsp:useBean id="member" scope="request" class="chap11.member.MemberInfo" />
<html>

<head><title>Hello</title></head>
<body>
<%= member.getName() %> 
(<%= member.getId() %>) Hello member~

</body>
</html>





