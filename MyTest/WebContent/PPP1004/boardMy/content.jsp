<%@ page contentType = "text/html; charset=utf-8" %>
<%@ page import = "board.BoardDBBean" %>
<%@ page import = "board.BoardDataBean" %>

<%@ page import = "board.MyCommentDBBean" %>
<%@ page import = "board.MyCommentDataBean" %>


<%@ page import = "java.util.*" %>
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
	<table width="500" border="1" class="content-table" cellspacing="0" cellpadding="0" bgcolor="<%=bodyback_c %>" align="center">
		
	<form>
		
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
			<td class="content" align="center" width="125" bgcolor="<%=value_c %>">글내용</td>
			<td align="left" width="375" colspan="3" style="padding:10px" class="content"><pre><%= article.getContent() %></pre></td>
		</tr>
		
		<tr height="30">
			<td colspan="4" bgcolor="<%=value_c%>" align="right">
				<input type="button" value="글수정" onclick="document.location.href='updateForm.jsp?num=<%=article.getNum()%>&pageNum=<%=pageNum%>'">
				&nbsp;&nbsp;&nbsp;&nbsp;
				<input type="button" value="글삭제" onclick="document.location.href='deleteForm.jsp?num=<%=article.getNum()%>&pageNum=<%=pageNum%>'">
				&nbsp;&nbsp;&nbsp;&nbsp;
				<input type="button" value="답글달기" onclick="document.location.href='writeForm.jsp?num=<%=article.getNum()%>&pageNum=<%=pageNum%>&ref=<%=ref %>&re_step=<%=re_step%>&re_level=<%=re_level%>'">
				&nbsp;&nbsp;&nbsp;&nbsp;
				<input type="button" value="글목록" onclick="document.location.href='list.jsp?pageNum=<%=pageNum%>'">
			</td>
		</tr>
		</form>
	
	
	
	
		<form action="writeComment.jsp" method="post" onSubmit="return checkComment();"
			name="writeCommentform">
		<tr class="write-comment value_c">
			<td class="comment-left" align="center" width="125"> 코멘트 작성 </td>
			<td class="comment-content" align="center" width="250" colspan="2">
				<textarea name="content" rows="3" cols="40"></textarea>
			</td>
			<td class="comment-right" width="125">
				<table>
					<tr>
						<td>작성자
							<input type="text" size="10" maxlength="50" name="writer">
							<input type="hidden" name="articleNum" value=<%=num%>>
							<input type="hidden" name="pageNum" value=<%=pageNum%>>
						</td>
					</tr>
					<tr>
						<td class="comment-passwd">비밀번호
							<input type="password" size="8" maxlength="50" name="passwd">
						</td>
					</tr>
					<tr>
						<td>
							<input type="submit" size="10" maxlength="50" value="댓글 작성">
						</td>
					</tr>
				</table>
			</td>
		</tr>
		</form>
	</table>
		<%
		// How much there are comment
      	MyCommentDBBean myCommentDB = MyCommentDBBean.getInstance();
      	int commentCount =  myCommentDB.getCommentCount(num);
		%>
	
	<div class="gap"></div>
	<table width="500" border="1" class="content-table" cellspacing="0" cellpadding="0" bgcolor="<%=bodyback_c %>" align="center">

		<tr class="view-comment-header">
			<td  colspan="4">
				 코멘트 수  
				 <span class="comment-count"><%=commentCount %></span>
			</td>
		</tr>
		
		<!-- for 문 써서 커맨트 반복 출력 -->
		
		
		<%
		// Get list of comments 
      	List<MyCommentDataBean> myComments =  myCommentDB.getComments(num);
		%>
		<%
		for(MyCommentDataBean myComment : myComments){
			%>
		<tr class="view-comment-inf">
			<td class="clear" colspan="4">
				<div class="left">
					<span class="comment-writer">
						<%=myComment.getWriter()%>
					</span>
					<span class="comment-reg_date">
						<%=myComment.getReg_date()%>
					</span>
				</div>
				<div class="right child-clear">
					<span class="comment-ip">
						<span class="text">
							접속IP: 
						</span>
						<%=myComment.getIp()%>
					</span>
					<span class="comment-del">
						<a href="deleteCommentForm.jsp?commentNum=<%=myComment.getCommentNum()%>&articleNum=<%=myComment.getArticleNum()%>&pageNum=<%=pageNum%>"> [삭제]</a>
					</span>
				</div>
			</td>
		</tr>
		
		<tr class="view-comment-content">
			<td colspan="4"><pre><%=myComment.getContent()%></pre></td>
		</tr>
			<%
		}
		%>
		
	
	
	</table>

<div class="gap"></div>
<div class="gap"></div>
<div class="gap"></div>

</div>





</body>
</html>



<% } catch(Exception ex){ex.printStackTrace(); }  %>
