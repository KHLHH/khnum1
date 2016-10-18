<%@ page contentType="text/html;charset=utf-8" %>
<%@ page import = "logon.*" %>
<%@ include file="color.jspf"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<% request.setCharacterEncoding("utf-8");%>

<html>
<head>
<title>회원정보수정</title>
<link href="style.css" rel="stylesheet" type="text/css">


<script>
   <!--
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
      
        if(!userinput.username.value) {
            alert("사용자 이름을 입력하세요");
            return false;
        }
        if(!userinput.jumin1.value  || !userinput.jumin2.value )
        {
            alert("주민등록번호를 입력하세요");
            return false;
        }
    }
-->
</script>


<body bgcolor="${bodyback_c}">
<form method="post" action="modifyPro.do" name="userinput" onsubmit="return checkIt()">

  <table width="600" border="1" cellspacing="0" cellpadding="3"  align="center">
    <tr >
      <td  colspan="2" height="39" bgcolor="${title_c}" align="center">
     <font size="+1" ><b>회원 정보수정</b></font></td>
    </tr>
    <tr>
      <td colspan="2" class="normal" align="center">회원의 정보를 수정합니다.</td>
    </tr>
     <tr>
      <td width="200" bgcolor="${value_c}"><b>아이디 입력</b></td>
      <td width="400" bgcolor="${value_c}"> </td>
    <tr> 

    <tr>
      <td  width="200"> 사용자 ID</td>
      <td  width="400">${c.id}</td>
    </tr>
   
     <tr>
      <td width="200"> 비밀번호</td>
      <td width="400">
        <input type="password" name="passwd" size="10" maxlength="10" value="${c.passwd}">
      </td>
    <tr> 
    <tr>
      <td  width="200" bgcolor="${value_c}"><b>개인정보 입력</b></td>
      <td width="400" bgcolor="${value_c}"> </td>
    <tr> 
    <tr>
      <td   width="200">사용자 이름</td>
      <td  width="400">
        <input type="text" name="name" size="15" maxlength="20" value="${c.name}">
      </td>
    </tr>
    <tr>
      <td width="200">주민등록번호</td>
      <td width="400">
        ${c.jumin1}-${c.jumin2}
      </td>
    </tr>
   <tr>
      <td width="200">E-Mail</td>
      <td width="400">
          <input type="text" name="email" size="40" maxlength="30" value="${c.email}">
      </td>
    </tr>
    <tr>
      <td width="200">Blog</td>
      <td width="400">
          <input type="text" name="blog" size="60" maxlength="50" value="${c.blog}">
      </td>
    </tr>     
    <tr>
      <td colspan="2" align="center" bgcolor="${value_c}">
       <input type="submit" name="modify" value="수   정" >
       <input type="button" value="취  소" onclick="javascript:window.location='main.do'">     
      </td>
    </tr>
  </table>
</form>
</body>
</html>