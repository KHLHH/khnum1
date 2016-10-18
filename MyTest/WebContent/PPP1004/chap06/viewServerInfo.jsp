<%@ page contentType="text/html; charset=utf-8"%>
<html>
<head>
<title>서버 정보 출력</title>
</head>
<body>
	서버정보: <%=application.getServerInfo()%><br> 
	서블릿 규약 메이저 버전: <%=application.getMajorVersion()%><br> 
	서블릿 규약 마이너 버전: <%=application.getMinorVersion()%>


특정 웹 어플리케이션에 포함된 모든 jsp페이지는 하나의 application객체를 공유함.
웹 어플리케이션 전반에 걸쳐서 사용되는 정보를 담고 있다.
초기 설정 정보, 서버 정보,  웹 어플리케이션이 제공하는 자원



</body>
</html>