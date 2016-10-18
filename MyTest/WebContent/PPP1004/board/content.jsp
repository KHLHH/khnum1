<%@ page contentType = "text/html; charset=utf-8" %>
<%@ page import = "board.BoardDBBean" %>
<%@ page import = "board.BoardDataBean"%>
<%@ page import = "java.text.SimpleDateFormat"%>
<%@ include file = "color.jsp" %>

<html>
<head>
<title>게시판 글 보기</title>
<link href="style.css" rel="stylesheet" type="text/css">
</head>

<%
int num = Integer.parseInt(request.getParameter("num") );
String pageNum = request.getParameter("pageNum");

SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
try {
	BoardDBBean dbPro = BoardDBBean.getInstance();
	BoardDataBean article = dbPro.getArticle(num);
	
	int ref = article.getRef();
	int re_step = article.getRe_step();
	int re_level = article.getRe_level();
	
} catch(Exception ex){ex.printStackTrace(); }
%>



</html>




