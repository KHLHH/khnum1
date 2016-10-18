<%@ page buffer="none" contentType = "text/html; charset=utf-8" %>
<%--
    버퍼가 없을 경우와 버퍼의 내용을 한번 전송한 후에는 
    <jsp:forward> 액션 태그가 올바르게 실행되지 않을 수도 있다.
    이미 웹브라우저에 데이터가 전송된 경우에는 <jsp:forward>를 사용해서 
    흐름을 이동할 수 없도록 규약하고 있다.
--%>
<html>
<head><title>from.jsp의 제목</title></head>
<body>

이 페이지는 from.jsp가 생성한 것입니다.

<jsp:forward page="../to/to.jsp" />

</body>
</html>
