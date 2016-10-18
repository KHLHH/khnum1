<%@ page contentType="text/html;charset=utf-8"%>


<%@ page import = "board.MyCommentDBBean" %>
<%@ page import = "board.MyCommentDataBean" %>

<%@ page import="board.BoardDBBean" %>
<%@ page import="java.sql.Timestamp" %>
<%@ page import="java.util.*" %>





<%
request.setCharacterEncoding("utf-8"); %>

<jsp:useBean id="myComment" scope="page" class="board.MyCommentDataBean">
	<jsp:setProperty name="myComment" property="*" />
</jsp:useBean>


<%

String articleNum = request.getParameter("articleNum");
String pageNum = request.getParameter("pageNum");


MyCommentDBBean dbPro = MyCommentDBBean.getInstance();
Map ret = dbPro.deleteMyComment(myComment);

Integer update = (Integer) (ret.get("update") == null ? 0 : ret.get("update") );


if(update == 1 ){
	%>
<meta http-equiv="Refresh" content="0;url=content.jsp?num=<%=articleNum%>&pageNum=<%=pageNum%>">
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


