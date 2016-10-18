<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.Date" %>
<%@ page trimDirectiveWhitespaces="true" %> 
<!DOCTYPE html>
<html>
<head>
<title>현재시간</title>
</head>
<body>
<!-- 현재시간 표시 - html주석 -->
<%-- jsp주석 --%>
<%  Date d = new Date();%>
현재시간 : <%= d %>
</body>
</html>