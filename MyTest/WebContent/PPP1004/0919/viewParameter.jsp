<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.util.Enumeration" %>
<%@ page import="java.util.Map" %>
<%
	//request.setCharacterEncoding("utf-8");
%>
<html>
<head><title>Requested Parameter Output</title></head>
<body>
name parameter = <%= request.getParameter("name") %> <br>
address parameter = <%= request.getParameter("address") %> <br>
<p>
<b>request.getParameterValues() Mehod Use</b><br>
</p>
<% 
	String[] values = request.getParameterValues("pet");
	if(values != null){
		for (int i = 0; i < values.length ; i++){
			%>
			<%= values[i] %>
			<%
		}
	}
%>

<p>
<b>request.getParameterNames() Method Use</b>
</p>

<%
	Enumeration paramEnum = request.getParameterNames();
	while(paramEnum.hasMoreElements()){
		String name = (String) paramEnum.nextElement();
		%>
		<%= name %>
		<% 
	}
%>

<p>
<b>request.getParameterMap() Method Use</b><br>
</p>

<%
	Map parameterMap = request.getParameterMap();
	String[] nameParam = (String[])parameterMap.get("name");
	if (nameParam != null){
		%>
		name = <%= nameParam[0] %>
		<%
	}
%>
</body>
</html>

