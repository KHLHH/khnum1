<%@ page contentType="text/html; charset=euc-kr" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%
	request.setAttribute("greeting", "�ȳ��ϼ���");
%>
<tiles:insertDefinition name="hello">
	<tiles:putAttribute name="title" value="�̰ɷ� ����" />
</tiles:insertDefinition>




