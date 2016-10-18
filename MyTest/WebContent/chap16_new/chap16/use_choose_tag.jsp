<%@ page contentType = "text/html; charset=euc-kr" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head><title>choose 태그</title></head>
<body>
<ul>
<li>
<c:choose>
	<c:when test="${param.name == 'bk' }">
	당신의 이름은 ${param.name} 입니다.	
	</c:when>
	<c:when test="${param.age >= 20 }">
		당신은 20세 이상입니다.
	</c:when>
	<c:otherwise>
		당신은 'bk'가 아니고 20세 이상이 아닙니다.
	</c:otherwise>
</c:choose>
</li>
</ul>

</body>
</html>
