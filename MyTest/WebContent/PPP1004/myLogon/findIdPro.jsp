<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import = "logon.LogonDBBean" %>
<%@ page import = "java.sql.Timestamp" %>
<%@ include file="../view/color.jsp"%>

<% request.setCharacterEncoding("utf-8"); %>
<jsp:useBean id="member" class="logon.LogonDataBean">
	<jsp:setProperty name="member" property="*" />
</jsp:useBean>

<%

log("findIdPro");
member.setReg_date(new Timestamp(System.currentTimeMillis()) );
LogonDBBean manager = LogonDBBean.getInstance();
String str1 = manager.findId(member);
if(str1 == null){
	%>
<script>
	alert("아이디를 찾을 수 없습니다.");
	history.go(-1);
</script>
	<%
} else{
%>


<table width="270" border="0" cellspacing="0" cellpadding="5" align="center">
  <tr bgcolor="<%=title_c%>">
    <td height="39"  align="center">
  <font size="+1" >찾은 아이디는 : <b style="font-weight:900; text-decoration:underline;"><%=str1 %></b>입니다.</font></td>
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


