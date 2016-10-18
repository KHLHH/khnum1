<%@ page contentType = "text/html; charset=utf-8" %>
<%@ page import = "board.BoardDBBean" %>
<%@ page import = "board.BoardDataBean" %>
<%@ page import = "java.text.SimpleDateFormat" %>
<%@ include file="color.jsp"%>
<html>
<head>
<title>게시판</title>
<link href="style.css" rel="stylesheet" type="text/css">
</head>

<%

   int num = Integer.parseInt(request.getParameter("num"));
 
	String pageNum = request.getParameter("pageNum");

   SimpleDateFormat sdf =
        new SimpleDateFormat("yyyy-MM-dd HH:mm");

   try{
      BoardDBBean dbPro = BoardDBBean.getInstance();
      BoardDataBean article =  dbPro.getArticle(num);
 
  int ref=article.getRef();
  int re_step=article.getRe_step();
  int re_level=article.getRe_level();
%>
<body bgcolor="<%=bodyback_c%>">
<div class="center">
	<h1>글 내용 보기</h1>
	<form>
	<table width="500" border="1" cellspacing="0" cellpadding="0" bgcolor="<%=bodyback_c %>" align="center">
		
		
		<tr height="30">
			<td align="center" width="125" bgcolor="<%=value_c %>" class="content-title">글제목</td>
			<td align="center" width="375" colspan="3" style="padding:10px" class="content-title"><h2><%= article.getSubject() %></h2></td>
		</tr>
				
		<tr height="30">
			<td align="center" width="125" bgcolor="<%=value_c %>">글번호</td>
			<td align="center" width="125"><%= article.getNum() %></td>
			
			<td align="center" width="125" bgcolor="<%=value_c %>">조회수</td>
			<td align="center" width="125"><%= article.getReadcount() %></td>
		</tr>
		<tr height="30">
			<td align="center" width="125" bgcolor="<%=value_c %>">작성자</td>
			<td align="center" width="125"><%= article.getWriter() %></td>
			
			<td align="center" width="125" bgcolor="<%=value_c %>">작성일</td>
			<td align="center" width="125"><%= article.getReg_date() %></td>
		</tr>
		
		<tr>
			<td align="center" width="125" bgcolor="<%=value_c %>">글내용</td>
			<td align="left" width="375" colspan="3" style="padding:10px" class="content"><pre><%= article.getContent() %></pre></td>
		</tr>
		
		<tr height="30">
			<td colspan="4" bgcolor="<%=value_c%>" align="right">
				<input type="button" value="글수정" onclick="document.location.href='updateForm.jsp?num=<%=article.getNum()%>'">
				&nbsp;&nbsp;&nbsp;&nbsp;
				<input type="button" value="글삭제" onclick="document.location.href='deleteForm.jsp?num=<%=article.getNum()%>'">
				&nbsp;&nbsp;&nbsp;&nbsp;
				<input type="button" value="답글달기" onclick="document.location.href='writeForm.jsp?num=<%=article.getNum()%>&ref=<%=ref %>&re_step=<%=re_step%>&re_level=<%=re_level%>'">
				&nbsp;&nbsp;&nbsp;&nbsp;
				<input type="button" value="글목록" onclick="document.location.href='list.jsp?pageNum=<%=pageNum%>'">
			</td>
		</tr>
		
	
	</table>
	</form>


</div>





</body>
</html>



<% } catch(Exception ex){ex.printStackTrace(); }  %>
