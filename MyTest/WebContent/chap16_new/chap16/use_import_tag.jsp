<%@ page contentType = "text/html;charset=utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<% request.setCharacterEncoding("utf-8"); %>
<c:choose>
	<c:when test="${param.type == '1'}">
		<c:import url="http://search.daum.net/search">
			<c:param name="w" value="cafe" />
			<c:param name="q" value="보라매 공원" />
		</c:import>
	</c:when>
	<c:when test="${param.type == '2'}">
		<c:import url="http://search.daum.net/search">
			<c:param name="w" value="cafe" />
			<c:param name="q" value="보라매 공원" />
		</c:import>
	</c:when>
	<c:otherwise>
		<c:import url="use_import_tag_help.jsp">
			<c:param name="message" value="선택해주세요" />
		</c:import>
	</c:otherwise>
</c:choose>

