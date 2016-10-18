<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.util.Enumeration" %>
<html>
<head>   
<title>application 기본 객체 속성 보기</title>
</head>
<body>
<%
	Enumeration attrEnum = application.getAttributeNames();
	while(attrEnum.hasMoreElements() ){
		String name = (String) attrEnum.nextElement();
		Object value = application.getAttribute(name);
		out.println("<br><br>Application Attribute:<br>");
		out.println("<b>"+name+"</b>"+" = "+value+"<br>");
	}

%>
</body>
</html>
