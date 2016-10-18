<%@ page contentType="text/html;charset=utf-8" %>
<%@ page import = "logon.LogonDBBean" %>
<%@ include file="color.jspf"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<% request.setCharacterEncoding("utf-8");%>
<html>
<head>
<title>회원탈퇴</title>
<link href="style.css" rel="stylesheet" type="text/css">
</head>

<c:if test="${check == 1}">
	<body bgcolor="${bodyback_c}">
	<form method="post" action="main.do" name="userinput" >
	<table width="270" border="0" cellspacing="0" cellpadding="5" align="center">
	  <tr bgcolor="${title_c}">
	    <td height="39" align="center">
	  <font size="+1" ><b>회원정보가 삭제되었습니다.</b></font></td>
	  </tr>
	  <tr bgcolor="${value_c}">
	    <td align="center">
	      <p>흑흑.... 서운합니다. 안녕히 가세요.</p>
	      <meta http-equiv="Refresh" content="5;url=main.do" >
	    </td>
	  </tr>
	  <tr bgcolor="${value_c}">
	    <td align="center">
	      <input type="submit" value="확인">
	    </td>
	  </tr>
	</table>
	</form>
</c:if>

<c:if test="${check != 1}">
	<script>
	  alert("비밀번호가 맞지 않습니다.");
	      history.go(-1);
	</script>
</c:if>

</body>
</html>