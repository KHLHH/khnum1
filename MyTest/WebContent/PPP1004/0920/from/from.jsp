<%@ page contentType="text/html; charset=utf-8"%>
<%@ page buffer="none" %>
<%--
	<jsp:foward> 액션 태그를 실행하면
	생성했던 출력 결과는 모두 제거된다.
--%>
<html>
<head>
<title>from.jsp의 제목</title>
</head>
<body>

This page from forward.jsp

<jsp:forward page="../to/to.jsp" />

forward 액션 태그 후

</body>
</html>
