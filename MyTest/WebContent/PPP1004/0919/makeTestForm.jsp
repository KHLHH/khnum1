<%@ page contentType="text/html; charset=utf-8" %>

<html>
<head><title>폼 생성</title></head>
<body>
Put data and click submit button.
<form action="viewParameter.jsp" method="get">
Name : <input type="text" name="name" size="10"> <br>
Addr : <input type="text" name="address" size="30"> <br>
Fav. animal :
	<input type="checkbox" name="pet" value="dog">Dog
	<input type="checkbox" name="pet" value="cat">Cat
	<input type="checkbox" name="pet" value="pig">Pig
<br>
<input type="submit" value="Submit">
</form>


</body>


</html>

