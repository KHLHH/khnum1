<%@ page contentType="text/html;charset=utf-8" %>
<%@ include file="color.jsp" %>


<%
int commentNum = Integer.parseInt(request.getParameter("commentNum"));
String articleNum = request.getParameter("articleNum");
String pageNum = request.getParameter("pageNum");

%>
<html>
<head>
<title>댓글 삭제하기</title>
<link href="style.css" rel="stylesheet" type="text/css">
</head>

<body bgcolor="<%=bodyback_c%>">
<div class="center">
<h1>댓글 삭제</h1>
<form method="post" name="delForm" action="deleteCommentPro.jsp" onsubmit="return deleteSave();">
<table border="1" align="center" cellspacing="0" cellpadding="0" width="350">
	<tr height="30">
		<td align="center" bgcolor="<%=value_c%>">
		<b>비밀번호를 입력해 주세요.</b>
	</tr>
	<tr height="30">
		<td align="center" >
			비밀번호 :
			<input type="password" name="passwd" size="8" maxlength="12">
			<input type="hidden" name="commentNum" value="<%=commentNum %>">
			<input type="hidden" name="articleNum" value="<%=articleNum %>">
		</td>
	</tr>
	<tr height="30">
		<td align="center" bgcolor="<%=value_c%>">
			<input type="submit" value="댓글삭제">
			<input type="button" value="되돌아가기"
				onclick="document.location.href='content.jsp?num=<%=articleNum%>&pageNum=<%=pageNum%>'">
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






