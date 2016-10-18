<%@ page contentType = "text/html; charset=euc-kr" %>
<%
	//String type = request.getParameter("type");
	String type = (String)request.getAttribute("type");
%>
<br>
<table width="100%" border="1" cellpadding="0" cellspacing="0">
<tr>
	<td>Type</td>
	<td><b><%= type  %></b></td>
</tr>
<tr>
	<td>Special attribute</td>
	<td>
<%
	if (type.equals("A") ){
		out.println("Durable");
	} else if (type.equals("B") ){
		out.println("Great resolving ability");
	}
%>
	</td>
</tr>
</table>


