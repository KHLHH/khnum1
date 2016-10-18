<%@ page contentType="text/html; charset=euc-kr" %>
<html>
<head>
	<title>뷰</title>
</head>
<body>
Expression 사용 결과 : <%= request.getAttribute("result") %>
<br>
<br>
EL 사용 결과 : ${result}

</body>
</html>
