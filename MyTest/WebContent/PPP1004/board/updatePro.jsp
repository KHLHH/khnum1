<%@ page contentType="text/html;charset=utf-8" %>
<%@ page import="board.BoardDBBean"%>
<%@ page import="java.sql.Timestamp"%>


<%
request.setCharacterEncoding("utf-8");
%>


<jsp:useBean id="article" scope="page" class="board.BoardDataBean">
	<jsp:setProperty name="article" property="*" />
</jsp:useBean>

<%
String pageNum = request.getParameter("pageNum");

BoardDBBean dbPro = BoardDBBean.getInstance();
int check = dbPro.updateArticle(article);

if(check == 1){
	%>
<body>
<h1>성공적으로 데이터가 삭제가 되었습니다.</h1>
<meta http-equiv="Refresh" content="0;url.list.jsp?pageNum<%=pageNum%>">
</body>
	<%
} else {
	%>
<script>
	alert("비밀번호가 맞지 않습니다.");
	history.go(-1);
</script>
	<%
}



%>




