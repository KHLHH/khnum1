<%@ page contentType="text/html; charset=euc-kr" %>
<%@ page import="day1.Multiply" %>
<%-- <%!
	public int multiply(int a, int b){
		int c = a * b;
		return c;
	}
%> --%>
<html>
<head><title>선언부를 사용한 두 정수의 곱</title></head>
<body>
<% Multiply m = new Multiply();  %>
10 * 25 = <%= m.multiply(10, 25) %>

</body>
</html>

