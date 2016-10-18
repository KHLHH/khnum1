<%@ page contentType = "text/html; charset=euc-kr" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head><title>시간대 목록</title></head>
<body>

<c:forEach var="id" 
		items="<%= java.util.TimeZone.getAvailableIDs() %>">     
    
    ${id}<br/>

</c:forEach>

</body>
</html>
