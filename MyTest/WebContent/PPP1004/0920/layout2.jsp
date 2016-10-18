<%@ page contentType="text/html; charset=utf-8"%><html>
<head><title>layout2</title></head>
<body>

<table border="1" cellpadding="0" cellspacing="0">
<tr>
	<td colspan="2">
		<jsp:include page="module/top.jsp" flush="false" />
	</td>
</tr>
<tr>
	<td>
		<jsp:include page="module/left.jsp" flush="false" />
	</td>
	<td>
		<h3>Article</h3>
		<p>Content~~~ is located in here~~~~~~~~~~~ </p>
	</td>
</tr>

<tr>
	<td colspan="2">
		<jsp:include page="module/bottom.jsp" flush="false" />
	</td>
</tr>

</table>
</body>
</html>
