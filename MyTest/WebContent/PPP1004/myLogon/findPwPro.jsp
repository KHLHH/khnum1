<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import = "logon.LogonDBBean" %>
<%@ page import = "java.sql.Timestamp" %>
<%@ include file="../view/color.jsp"%>

<% request.setCharacterEncoding("utf-8"); %>
<jsp:useBean id="member" class="logon.LogonDataBean">
	<jsp:setProperty name="member" property="*" />
</jsp:useBean>

<%

LogonDBBean manager = LogonDBBean.getInstance();
Boolean b1 = manager.findPw(member);
if(!b1){
	%>
<script>
	alert("아이디를 찾을 수 없습니다.");
	history.go(-1);
</script>
	<%
} else{
session.setAttribute("PwChangeId",member.getId());
%>


<html>
<head><title>새로운 비밀번호 입력</title></head>
<body onload="begin()" bgcolor="<%=bodyback_c%>">
<form name="myform" action="findPwProPro.jsp" method="post" onSubmit="return checkIt()">
<table cellspacing="1" cellpadding="1" width="260" border="1" align="center">
<tr height="30">
	<td colspan="2" align="middle" bgcolor="<%=title_c%>"><strong>새로운 비밀번호 입력</strong></td>
</tr>

<tr>
	<td width="200" bgcolor="<%=title_c %>" align="center">비밀번호</td>
	<td width="400" bgcolor="<%=value_c %>" align="center">
		<input type="password" name="passwd" size="15" maxlength="12">
	</td>
</tr>

<tr>
	<td width="200" bgcolor="<%=title_c %>" align="center">비밀번호 확인</td>
	<td width="400" bgcolor="<%=value_c %>" align="center">
		<input type="password" name="passwd2" size="15" maxlength="12">
	</td>
</tr>


    
    <tr>
      <td colspan="2" align="center" bgcolor="<%=value_c%>">
       <input type="submit" name="modify" value="새로운 비밀번호 입력" >
       <input type="button" value="취  소" onclick="javascript:window.location='main.jsp'">     
      </td>
    </tr>
    
    



</table>
</form>


<script>

function checkIt(){
	var userinput = eval("document.myform");
	


	if(!userinput.passwd.value){
		alert("비밀번호를 입력하세요.");
		return false;
	}
	
	if(userinput.passwd.value != userinput.passwd2.value){
		alert("비밀번호를 동일하게 입력하세요");
		return false;
	}
	
	return true;
}

</script>
</body>



</html>

<%
}
%>


