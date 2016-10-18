<%@ page contentType="text/html; charset=utf-8"%>
<%
	String name = request.getParameter("name");
	String value = request.getParameter("value");
	
	if(name != null && value != null){
		application.setAttribute("int1", 10);
	}
%>

<html>
<head>

<title>application 속성 지정</title>
</head>
<body>
<%
if(name != null && value != null){
	out.println("Application Basic Object Attribute Set: ");
	out.println(name+"="+value);
}	else {
	out.println("Application Basic Object Attribute Not Set from Query URL?name=n1&value=v1");
}
	%>

</body>
</html>
