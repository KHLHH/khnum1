<%@ page contentType="text/html; charset=utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:if test="${param.dest == '1'}">
	<c:redirect url="/chap16/use_c_set.jsp" />
</c:if>
<c:if test="${param.dest == '2'}">
	<c:redirect url="use_c_set.jsp" />
</c:if>
<c:if test="${param.dest == '3'}">
	<c:redirect url="/viewToday.jsp" context="/SepJSP/chap15" />
</c:if>
<c:if test="${param.dest == '4'}">
	<c:redirect url="http://search.daum.net/search">
		<c:param name="w" value="blog" />
		<c:param name="q" value="주나이스" />
	</c:redirect>
</c:if>











