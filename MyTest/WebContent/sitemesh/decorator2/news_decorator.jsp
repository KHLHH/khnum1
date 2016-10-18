<%@ page contentType="text/html; charset=euc-kr" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="decorator" uri="http://www.opensymphony.com/sitemesh/decorator" %>

<html lang="ko">
<head>
	<title>19장 <decorator:title /> </title>
	<style type="text/css">
		#footer {color: red; }
	</style> 
</head>
<body>
	뉴스 홈 | 스포츠 | 경제 | 연애
	<hr/>
	<decorator:body />
	<hr/>
	<div id="footer">뉴스 푸터</div>
</body>
</html>