<%@ page contentType = "text/html; charset=utf-8" %>
<%@ page deferredSyntaxAllowedAsLiteral="true" %>
<%--<%@ page isELIgnored="false" %>  --%>
<%
	request.setAttribute("name", "최범균");
%>
<html>
<head><title>EL Object</title></head>
<body>

요청 URI: ${pageContext.request.requestURI} <br>
request의 name 속성: ${requestScope.name} <br>
code 파라미터: ${param.code}<br>
#{ 10 }
</body>
</html>
