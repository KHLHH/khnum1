<%@ page contentType="text/html;charset=utf-8" %>
<%@ include file="color.jsp" %>


<%
int num = Integer.parseInt(request.getParameter("num"));
String pageNum = request.getParameter("pageNum");

%>
<html>
<head>
<title>게시물 삭제하기</title>
<link href="style.css" rel="stylesheet" type="text/css">
</head>

<body bgcolor="<%=bodyback_c%>">
<div class="center">
<h1>글 삭제</h1>
<form method="post" name="delForm" action="deletePro.jsp?pageNum=<%=pageNum%>" onsubmit="return deleteSave();">
<table border="1" align="center" cellspacing="0" cellpadding="0" width="350">
	<tr height="30">
		<td align="center" bgcolor="<%=value_c%>">
		<b>비밀번호를 입력해 주세요.</b>
	</tr>
	<tr height="30">
		<td align="center" >
			비밀번호 :
			<input type="password" name="passwd" size="8" maxlength="12">
			<input type="hidden" name="num" value="<%=num %>">
		</td>
	</tr>
	<tr height="30">
		<td align="center" bgcolor="<%=value_c%>">
			<input type="submit" value="글삭제">
			<input type="button" value="글목록"
				onclick="document.location.href='list.jsp?pageNum=<%=pageNum%>'">
		</td>
	</tr>

</table>
</form>


</div>


<script>
	function deleteSave(){
		if(document.delForm.passwd.value==""){
			alert("비밀번호를 입력하십시요.");
			document.delForm.passwd.focus();
			return false;
		}
		
	}
</script>
</body>

</html>






