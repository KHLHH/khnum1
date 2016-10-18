<%@ page contentType ="text/html; charset=utf-8" %>
<%@ page session = "true" %>
<%@ page import = "java.util.Date" %>
<%@ page import = "java.text.SimpleDateFormat" %>

<% 
Date time = new Date();
SimpleDateFormat formatter =
	new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
%>
<html>
<head><title>Session Info </title>
<style>
*{border:1px dotted;}
</style>

</head>
<body>
<table>
<tr>
	<td>Session ID:</td>
	<td><%= session.getId() %></td>
</tr>

<tr>
	<td>Session Created Time: </td>
	<td>
	<% time.setTime(session.getCreationTime()); 
	out.print( formatter.format(time) );
	
	%>
	</td>
</tr>
<tr>
	<td>Session Last Access Time : </td>
	<td>
	<% time.setTime(session.getLastAccessedTime());
	out.print( formatter.format(time) );
	%>
	</td>
</tr>

</table>

<br>



</body>
</html>








