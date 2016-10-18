<%@ page contentType = "text/html; charset=euc-kr" %>
<html>
<head><title>INFO</title></head>
<body>
<table width="100%" border="1" cellpadding="0" cellspacing="0">
<tr>
	<td>제품번호</td> <td>XXXX</td>
</tr>
<tr>
	<td>가격</td> <td>10,000원</td>
</tr>
</table>
<% request.setAttribute("type", "B"); %>

<jsp:include page="infoSub.jsp" flush="false" />
	<%-- <jsp:param name="type" value="B" /> 
</jsp:include>
--%>



</body>
</html>










