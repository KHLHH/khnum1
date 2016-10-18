<%@ page contentType = "text/html; charset=utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<html>
<head><title>함수 사용</title>
<style>
	table {
		border-collapse: collapse;
	}
	td{
		border: 1px solid black;
	}
</style>
</head>
<body>
<c:set var="str1" value="Functions <태그>를 사용합니다." />
<c:set var="str2" value="사용" />
<c:set var="tokens" value="1,2,3,4,5,6,7,8,9,10" />
<table>
<tr>
	<td>
	str1
	</td><td>
	${str1}
	</td></tr><tr><td>
	str2
	</td><td>
	${str2}
	</td></tr><tr><td>
	${str2}
	</td><td>
	${fn:length(str1)}
	</td></tr><tr><td>
	toUpperCase(str1)
	</td><td>
	${fn:toUpperCase(str1)}
	</td></tr><tr><td>
	toLowerCase(str1)
	</td><td>
	${fn:toLowerCase(str1)}
	</td></tr><tr><td>
	substring(str1, 3, 6)
	</td><td>
	${fn:substring(str1, 3, 6)}
	</td></tr><tr><td>
	substringAfter(str1, str2)
	</td><td>
	${fn:substring(str1, 3, 6)}
	</td></tr><tr><td>
	substringBefore(str1, str2)
	</td><td>
	${fn:substringBefore(str1, str2)}
	</td></tr><tr><td>
	trim(str1)
	</td><td>
	${fn:trim(str1)}
	</td></tr><tr><td>
	replace(str1, src, dest)
	</td><td>
	${fn:replace(str1, src, dest)}
	</td></tr><tr><td>
	indexOf(str1, str2)
	</td><td>
	${fn:indexOf(str1, str2)}
	</td></tr><tr><td>
	startsWith(str1, str2)
	</td><td>
	${fn:startsWith(str1, str2)}
	</td></tr><tr><td>
	endsWith(str1, str2)
	</td><td>
	${fn:endsWith(str1, str2)}
	</td></tr><tr><td>
	contains(str1, str2)
	</td><td>
	${fn:contains(str1, str2)}
	</td></tr><tr><td>
	containsIgnoreCase(str1, str2)
	</td><td>
	${fn:containsIgnoreCase(str1, str2)}
	</td></tr><tr><td>
	<c:set var="array" value="${fn:split(tokens, ',')}" />

	join(array, "-")
	</td><td>
	${fn:join(array, "-")}
	</td></tr><tr><td>
	escapeXml(str1)
	</td><td>
	${fn:escapeXml(str1) }
	</td></tr>
</table>


</body>
</html>









