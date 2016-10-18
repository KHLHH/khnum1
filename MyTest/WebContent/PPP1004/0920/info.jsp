<%@ page contentType = "text/html; charset=euc-kr" %>
<html>
<head><title>INFO</title></head>
<body>
<table border="1" cellpadding="0" cellspacing="0">
<tr>
	<td>Product Number</td><td>XXXX</td>
</tr>
<tr>
	<td>Price</td><td>10$</td>
</tr>
</table>
<% request.setAttribute("type","B"); %>

<jsp:include page="infoSub.jsp" flush="false" />
<%-- <jsp:param name="type" value="B" />
</jsp:include>
--%>
</body>
</html>










