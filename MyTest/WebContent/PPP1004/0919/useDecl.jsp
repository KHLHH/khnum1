<%@ page contentType="text/html; charset=euc-kr" %>
<%@ page import="day1.Multiply" %>
<%-- <%!
	public int multiply(int a, int b){
		int c = a * b;
		return c;
	}
%> --%>
<html>
<head><title>����θ� ����� �� ������ ��</title></head>
<body>
<% Multiply m = new Multiply();  %>
10 * 25 = <%= m.multiply(10, 25) %>

</body>
</html>

