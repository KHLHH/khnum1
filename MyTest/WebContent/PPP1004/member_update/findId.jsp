<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>id 찾기</title>
</head>
<body>

이름, 주민번호 입력하세요.
<form action="findIdPro.jsp" method="post">
<table border="1"><tr><td>
이름 : <input name ="name">
</td></tr>
<tr><td>
주민번호:  <input type="text" name="jumin1" size="7" maxlength="6">
        -<input type="text" name="jumin2" size="7" maxlength="7">
</td></tr>       
<tr><td>
<input type="submit" value="ID찾기">
</td></tr>	
</table>
</form>

</body>
</html>