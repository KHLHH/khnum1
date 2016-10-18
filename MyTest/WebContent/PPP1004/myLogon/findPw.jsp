<%@ page  contentType="text/html; charset=utf-8"%>
<%@ include file ="../view/color.jsp" %>

<html>
<head><title>로그인</title></head>
<body onload="begin()" bgcolor="<%=bodyback_c%>">
<form name="myform" action="findPwPro.jsp" method="post" onSubmit="return checkIt()">
<table cellspacing="1" cellpadding="1" width="260" border="1" align="center">
<tr height="30">
	<td colspan="2" align="middle" bgcolor="<%=title_c%>"><strong>비밀번호 찾기</strong></td>
</tr>



<tr>
	<td width="200" bgcolor="<%=title_c %>" align="center">사용자 ID</td>
	<td width="400" bgcolor="<%=value_c %>" align="center">
		<input type="text" name="id" size="10" maxlength="12">
	</td>
</tr>

<tr height="30">
	<td width="110" bgcolor="<%=title_c %>" align="center">이름</td>
	<td width="150" bgcolor="<%=value_c %>" align="center">
		<input type="text" name="name" size="15" maxlength="12">
	</td>
</tr>

<tr>
	<td width="200" bgcolor="<%=title_c %>" align="center">주민등록번호</td>
	<td width="400" bgcolor="<%=value_c %>" align="center">
		<input type="text" name="jumin1" size="6" maxlength="6" min="6">
		<input type="text" name="jumin2" size="7" maxlength="7" min="7">
	</td>
</tr>


    
    <tr>
      <td colspan="2" align="center" bgcolor="<%=value_c%>">
       <input type="submit" name="modify" value="비밀번호 찾기" >
       <input type="button" value="취  소" onclick="javascript:window.location='main.jsp'">     
      </td>
    </tr>
    
    



</table>
</form>


<script>

function checkIt(){
	var userinput = eval("document.myform");
	

	if(!userinput.id.value){
		alert("ID를 입력하세요");
		return false;
	}
	
	if(!userinput.name.value){
		alert("사용자 이름을 입력하세요.");
		return false;
	}
	
	if(!userinput.jumin1.value || !userinput.jumin2.value ){
		alert("주민등록번호를 입력하세요");
		return false;
	}
	return true;
}

</script>
</body>



</html>
