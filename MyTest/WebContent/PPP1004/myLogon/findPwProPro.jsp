<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import = "logon.LogonDBBean" %>
<%@ page import = "java.sql.Timestamp" %>
<%@ include file="../view/color.jsp"%>

<% request.setCharacterEncoding("utf-8"); %>
<jsp:useBean id="member" class="logon.LogonDataBean">
	<jsp:setProperty name="member" property="*" />
</jsp:useBean>

<%

String idAttri = (String)session.getAttribute("PwChangeId");

member.setId(idAttri);

LogonDBBean manager = LogonDBBean.getInstance();
Boolean b1 = manager.findPwNewPw(member);
if(!b1){
	%>
<script>
	alert("비밀번호 재생성 에러!");
	history.go(-1);
</script>
	<%
} else{
%>

<link href="style.css" rel="stylesheet" type="text/css">

<table width="270" border="0" cellspacing="0" cellpadding="5" align="center">
  <tr bgcolor="<%=title_c%>">
    <td height="39"  align="center">
  <font size="+1" ><b>회원 비밀번호가 수정되었습니다.</b></font></td>
  </tr>
  <tr>
    <td bgcolor="<%=value_c%>" align="center">
      <p>입력하신 내용대로 수정이 완료되었습니다.</p>
    </td>
  </tr>
  <tr>
    <td bgcolor="<%=value_c%>" align="center">
      <form>
    <input type="button" value="메인으로" onclick="window.location='main.jsp'">
      </form>
      5초후에 메인으로 이동합니다.
      
      <meta http-equiv="Refresh" content="5;url=main.jsp">
    </td>
  </tr>
</table>
</body>
</html>
<%
}
%>


