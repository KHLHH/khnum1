<%@ page contentType="text/html; charset=utf-8"%><html>
<head><title>layout1</title></head>
<body>

<table border="1" cellpading="0" cellspacing="0">
<tr>
	<td colspan="2">
		<jsp:include page="module/top.jsp" flush="false" />
	</td>
</tr>
<tr>
	<td width="100" valign="top">
		<jsp:include page="module/left.jsp" flush="false" />
	</td>
	<td width="500 valign="top">
		<!--  Content : Start -->
		Layout1
		<br><br><br>
		<!--  Content : End -->
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
