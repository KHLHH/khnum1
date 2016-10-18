<%@ page contentType="text/html;charset=utf-8" %>
<%@ page import = "board.MyCommentDBBean" %>
<%@ page import = "board.MyCommentDataBean" %>
<%@ page import = "java.sql.Timestamp" %>


<% request.setCharacterEncoding("utf-8"); %>

<jsp:useBean id="myComment" scope="page" class="board.MyCommentDataBean">
	<jsp:setProperty name="myComment" property="*" />
</jsp:useBean>


<%
log(request.getParameter("writer"));
log(request.getParameter("content"));

String articleNum = request.getParameter("articleNum");
String pageNum = request.getParameter("pageNum");
if(pageNum == null)articleNum="1";


myComment.setReg_date(new Timestamp(System.currentTimeMillis() ));
myComment.setIp(request.getRemoteAddr() );
MyCommentDBBean dbPro = MyCommentDBBean.getInstance();
dbPro.insertMyComment(myComment);

response.sendRedirect("content.jsp?num="+articleNum+"&pageNum="+pageNum);
%>





