<%@ page contentType = "text/html; charset=euc-kr" %>
<%@ page import = "util.CookieBox" %>
<%
CookieBox cookieBox = new CookieBox(request);
boolean login = cookieBox.exists("LOGIN") && cookieBox.getValue("LOGIN").equals("SUCCESS");

%>
<html>
<head><title>�α��ο��� �˻�</title></head>
<body>
<%
	if(login){
		out.print("���̵� "+cookieBox.getValue(" ID")+"�� �α��� �� ����");
	} else {
		out.print("�α��� ���� ���� ����");
	}

%>


</body>
</html>
