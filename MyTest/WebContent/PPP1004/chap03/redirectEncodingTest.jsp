<%@ page import = "java.net.URLEncoder" %>
<%@ page pageEncoding="utf-8" %>
<%
	/* String value = "자바";
	String encodedValue = URLEncoder.encode(value, "utf-8"); 
	response.sendRedirect("index.jsp?name=" + encodedValue); */
	
	String value = "자바";
	response.sendRedirect("index.jsp?name=" + value); 
	
%>
