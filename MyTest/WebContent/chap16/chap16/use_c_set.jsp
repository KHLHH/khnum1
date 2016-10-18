<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="mvjsp.chap16.Member" %>
<%@ page import="java.util.HashMap" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	Member member = new Member();
	HashMap<String, String> pref = new HashMap<String, String>();
%>
<html>
<body>
<c:set var="mem" value="<%= member %>" />
<c:set target="${mem}" property="name" value="su" />

<c:set var="pre" value="<%= pref %>" />
<c:set var="favoriateColor" value="#{pre.color}" />

회원 이름: ${mem.name},
좋아하는 색: ${favoriateColor}

<br />
<c:set target="${pre}" property="color" value="red" />

설정 이후 좋아하는 색: ${favoriateColor}

</body>
</html>






