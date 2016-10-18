<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import = "logon.LogonDBBean" %>
<%

	request.setCharacterEncoding("utf-8");
	String name = request.getParameter("name");
	String j1 = request.getParameter("jumin1");
	String j2 = request.getParameter("jumin2");

	LogonDBBean manager = LogonDBBean.getInstance();
	String id = manager.findId(name, j1, j2);
%>

<!DOCTYPE html>
<html>
<head>
<title>id 찾기</title>
</head>
<body>
<% if(id.equals("")){ %>
이름, 주민번호가 틀렸습니다.<br>
<a href="javascript:this.close();">닫기</a>

<%}else{ %> 

찾으신 아이디는 <%= id %> 입니다.<br>
<a href="javascript:this.close();">닫기</a>

<%} %>

</body>
</html>