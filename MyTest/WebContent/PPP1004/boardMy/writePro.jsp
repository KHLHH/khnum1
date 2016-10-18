<%@ page contentType="text/html;charset=utf-8" %>
<%@ page import = "board.BoardDBBean" %>
<%@ page import = "java.sql.Timestamp" %>


<% request.setCharacterEncoding("utf-8"); %>

<jsp:useBean id="article" scope="page" class="board.BoardDataBean">
	<jsp:setProperty name="article" property="*" />
</jsp:useBean>


<%
log(request.getParameter("writer"));
log(request.getParameter("content"));
article.setReg_date(new Timestamp(System.currentTimeMillis() ));
article.setIp(request.getRemoteAddr() );
BoardDBBean dbPro = BoardDBBean.getInstance();
dbPro.insertArticle(article);

response.sendRedirect("list.jsp");
%>





