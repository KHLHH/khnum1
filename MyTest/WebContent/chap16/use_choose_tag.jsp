<%@ page contentType = "text/html; charset=euc-kr" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head><title>choose �±�</title></head>
<body>
<ul>
<li>
<c:choose>
	<c:when test="${param.name == 'bk' }">
	����� �̸��� ${param.name} �Դϴ�.	
	</c:when>
	<c:when test="${param.age >= 20 }">
		����� 20�� �̻��Դϴ�.
	</c:when>
	<c:otherwise>
		����� 'bk'�� �ƴϰ� 20�� �̻��� �ƴմϴ�.
	</c:otherwise>
</c:choose>
</li>
</ul>

</body>
</html>
