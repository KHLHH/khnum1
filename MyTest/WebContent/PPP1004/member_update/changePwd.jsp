<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>비밀번호 찾기</title>
</head>
<body>

아이디, 이름, 주민번호를 입력하세요.
<form action="changePwdPro.jsp" method="post">
<table border="1">
<tr><td>
아이디 : <input name ="id">
</td></tr>

<tr><td>
이름 : <input name ="name">
</td></tr>
<tr><td>
주민번호:  <input name="jumin1" size="7" maxlength="6">
        -<input name="jumin2" size="7" maxlength="7">
</td></tr>       
<tr><td>
<input type="submit" value="pwd찾기">
</td></tr>	
</table>
</form>


</body>
</html>