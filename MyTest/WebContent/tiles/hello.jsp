<%@ page contentType="text/html; charset=euc-kr" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%
	request.setAttribute("greeting", "안녕하세요");
%>
<tiles:insertDefinition name="hello">
	<tiles:putAttribute name="title" value="이걸로 변경" />
</tiles:insertDefinition>




