<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import = "logon.LogonDBBean" %>
<%

	request.setCharacterEncoding("utf-8");
	String id = request.getParameter("id");
	String name = request.getParameter("name");
	String j1 = request.getParameter("jumin1");
	String j2 = request.getParameter("jumin2");

	LogonDBBean manager = LogonDBBean.getInstance();
	int x = manager.findpwd(id,name, j1, j2);
%>

<!DOCTYPE html>
<html>
<head>
<title>pwd 변경</title>
<script>
function checkIt() {
    var userinput = eval("document.userinput");

   
    if(!userinput.passwd.value ) {
        alert("비밀번호를 입력하세요");
        return false;
    }
    if(userinput.passwd.value != userinput.passwd2.value)
    {
        alert("비밀번호를 동일하게 입력하세요");
        return false;
    }
    return true;
}
</script>


</head>
<body>
<% if(x == 0){ %>
아이디, 이름, 주민번호가 틀렸습니다.<br>
<a href="javascript:this.close();">닫기</a>

<%}else{ %> 

비밀번호를 변경합니다. 변경할 비번을 입력하세요.
<form action="changePwdTo.jsp" method="post" onsubmit="return checkIt();" name="userinput">
<table>
 <tr>
      <td >
        비밀번호: <input type="password" name="passwd" size="15" maxlength="12">
      </td>
    <tr> 
      
      <td>
      비밀번호 확인:  <input type="password" name="passwd2" size="15" maxlength="12">
      </td>
    </tr>
   <tr><td>
   <input type="hidden" name="id" value="<%= id %>">
   <input type="submit" value="비밀번호 변경">
   </td></tr>
</table>
</form>
<%} %>

</body>
</html>