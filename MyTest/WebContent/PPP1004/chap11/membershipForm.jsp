<%@ page contentType = "text/html; charset=utf-8" %>
<html>
<head><title>Register form</title></head>
<body>
<form action="<%= request.getContextPath() %>/chap11/processJoining.jsp" method="post" >
<table border="1" cellpadding="0" cellspacing="0">
<tr>
<td>ID</td>
<td colspan="3"><input type="text" name="id" size="10"></td>
</tr>
<tr>
<td>Name</td>
<td><input type="text" name="name" size="10"></td>
<td>Email</td>
<td><input type="text" name="email" size="10"></td>
</tr>


<tr>
<td>Address</td>
<td colspan="3"><input type="text" name="address" size="30"></td>
</tr>

<tr>
<td>Age</td>
<td colspan="3"><input type="text" name="age" size="30"></td>
</tr>

<tr>
<td colspan="4" align="center">
<input type="submit" value="Register">
</tr>






</table>
</form>
</body>
</html>