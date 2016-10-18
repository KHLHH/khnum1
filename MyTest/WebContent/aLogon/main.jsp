<%@ page  contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="color.jspf"%>

<% request.setCharacterEncoding("utf-8");%>


	
<c:if test="${memId == null }">
<html>
<head><title>메인입니다..</title>
<link href="style.css" rel="stylesheet" type="text/css">



	<script>
	
	function focusIt()
	{     
	   document.inform.id.focus();//내가 작업하고 있는 문서의 inform이라는 곳에 id에 커서를 가져다 줌
	}
	
	function checkIt()
	{
	   inputForm=eval("document.inform");
	   if(!inputForm.id.value){
	     alert("아이디를 입력하세요..");
	inputForm.id.focus();
	return false;
	   }
	   if(!inputForm.passwd.value){
	     alert("패스워드를 입력하세요..");
	inputForm.passwd.focus();
	return false;
	   }
	}
	
	</script>
	</head>
	<body onLoad="focusIt();" bgcolor="${bodyback_c}">
	  <form name="inform" method="post" action="loginPro.do"  onSubmit="return checkIt();">
	
	  <table width=500 cellpadding="0" cellspacing="0"  align="center" border="1" >
	      <tr>
	       <td width="300" bgcolor="${bodyback_c}" height="20">
	       &nbsp;
	       </td>
	  
	        <td bgcolor="${title_c}"  width="100" align="right">아이디</td>
	        <td width="100" bgcolor="${value_c}">
	            <input type="text" name="id" size="15" maxlength="10"></td>
	      </tr>
	      <tr >
	         <td rowspan="2" bgcolor="${bodyback_c}" width="300" >메인입니다.</td>
	         <td bgcolor="${title_c}"  width="100" align="right">패스워드</td>
	         <td width="100" bgcolor="${value_c}">
	            <input type="password" name="passwd" size="15" maxlength="10"></td>
	       </tr>
	       <tr>
	          <td colspan="3" bgcolor="${title_c}"   align="center">
	            <input type="submit" name="Submit" value="로그인">
	            <input type="button"  value="회원가입" onclick="javascript:window.location='inputForm.do'">
	          </td>
	       </tr>
	    </table>
	    
	    </form>

</c:if>



<c:if test="${memId != null }">
       <table width=500 cellpadding="0" cellspacing="0"  align="center" border="1" >
         <tr>
           <td width="300" bgcolor="${bodyback_c}" height="20">하하하</td>

           <td rowspan="3" bgcolor="${value_c}" align="center">
             ${memId}님이 <br>
             방문하셨습니다
             <form  method="post" action="logout.do"> 
             <input type="submit"  value="로그아웃">
             <input type="button" value="회원정보변경" onclick="javascript:window.location='modify.do'">
             </form>
         </td>
        </tr>
       <tr >
         <td rowspan="2" bgcolor="${bodyback_c}" width="300" >메인입니다.</td>
      </tr>
     </table>
     <br>
</c:if>
</body>
</html>