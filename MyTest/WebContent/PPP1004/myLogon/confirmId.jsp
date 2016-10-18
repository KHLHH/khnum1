<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import = "logon.LogonDBBean" %>
<%@ include file = "../view/color.jsp"%>

<html>
<head><title>ID 중복 확인</title></head>
<link href="style.css" rel="stylesheet" type="text/css">

<% request.setCharacterEncoding("utf-8");%>
<%
String id = request.getParameter("id");
LogonDBBean manager = LogonDBBean.getInstance();
int check = manager.confirmId(id);
%>
<body bgcolor="<%=bodyback_c%>">
<%
if(check == 1){
%>
<table width="270" border="0" cellspacing="0" cellpadding="5">
<tr bgcolor="<%=title_c%>">
	<td height="39"><%=id %>는 이미 사용중인 아이디입니다.</td>
</tr>
</table>
<form name="checkForm" method="post" action="confirmId.jsp">
<table width="270" border="0" cellspactin="0" cellpadding="5">
<tr>
	<td bgcolor="<%=value_c%>" align="center">
		다른 아이디를 선택하세요.<br>
		<input type="text" size="10" maxlength="12" name="id">
		<input type="submit" value="ID중복확인">
	</td>
</tr>
</table>

</form>
<%
}else {
%>

<table width="270" border="0" cellspacing="0" cellpadding="5">
<tr bgcolor="<%=title_c%>">
	<td align = "center">
		<p>입력하신 <%=id %>는 사용 하실 수 있는 ID 입니다.</p>
		<input type="button" value="닫기" onclick="setId()">
	</td>
</tr>
</table>
<%
}
%>
</body>
</html>
<script>
function setId(){
	opener.document.userinput.idCheck.value="y";
	opener.document.userinput.id.value="<%=id%>";
	self.close();
}

</script>



