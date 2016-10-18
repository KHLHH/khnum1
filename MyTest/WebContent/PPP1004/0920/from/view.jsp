<%@ page contentType = "text/html; charset=euc-kr" %>

<%
	String code = request.getParameter("code");
	String viewPageURL = "viewModule/";
	
	if (code.equals("A")){
		viewPageURL += "a.jsp";
	} else if (code.equals("B")){
		viewPageURL += "b.jsp";
	} else if (code.equals("C")){
		viewPageURL += "c.jsp";
	}
%>
<%= viewPageURL %>
<jsp:forward page="<%= viewPageURL %>" />

