<%@ page contentType="text/html; charset=euc-kr" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="decorator" uri="http://www.opensymphony.com/sitemesh/decorator" %>

<html lang="ko">
<head>
	<title>19�� <decorator:title /> </title>
	<style type="text/css">
		#footer {color: red; }
	</style> 
</head>
<body>
	���� Ȩ | ������ | ���� | ����
	<hr/>
	<decorator:body />
	<hr/>
	<div id="footer">���� Ǫ��</div>
</body>
</html>