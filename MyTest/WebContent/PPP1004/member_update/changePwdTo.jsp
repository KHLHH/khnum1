<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import = "logon.LogonDBBean" %>
<%
	
	request.setCharacterEncoding("utf-8");
	String id = request.getParameter("id");
	String pwd = request.getParameter("passwd");
	LogonDBBean manager = LogonDBBean.getInstance();
	manager.updatepwd(id, pwd);
%>
<!DOCTYPE html>
<html>
<head>
<title>Insert title here</title>
</head>
<body>
비밀번호가 변경되었습니다.

<a href="javascript:this.close();">닫기</a>


</body>
</html>