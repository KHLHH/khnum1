<%@ page contentType="text/html; charset=euc-kr" %>
<%@ page import="soldesk.board.BoardDBBean" %>
<%@ page import="soldesk.board.BoardDataBean" %>
<%@ page import="soldesk.board.CommentDBBean" %>
<%@ page import="soldesk.board.CommentDataBean" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ include file="color.jsp" %>
<html>
<head>
<title>게시판</title>
<link href="style.css" rel="stylesheet" type="text/css">
</head>

<%
	int num=Integer.parseInt(request.getParameter("num"));
	String pageNum=request.getParameter("pageNum");
	
	SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm");
	
	try{
			BoardDBBean dbPro=BoardDBBean.getInstance();
			BoardDataBean article=dbPro.getArticle(num);
			
			CommentDBBean cdb=CommentDBBean.getInstance();
			ArrayList comments=cdb.getComments(article.getNum());
			int count=cdb.getCommentCount(article.getNum());
			int ref=article.getRef();
			int re_step=article.getRe_step();
			int re_level=article.getRe_level();
%>
			<body bgcolor=<%=bodyback_c %>>
			<div class="center"><b>글내용 보기</b><br>
				<table width=500 border=1 cellspacing=0 cellpadding=0 bgcolor=<%=bodyback_c %> align=center>
					<form>
					<tr height=30>
						<td align=center width=125 bgcolor=<%=value_c %>>글번호</td>
						<td align=center width=125><%=article.getNum() %></td>
						<td align=center width=125 bgcolor=<%=value_c %>>조회수</td>
						<td align=center width=125><%=article.getReadcount() %></td>
					</tr>
					<tr height=30>
						<td align=center width=125 bgcolor=<%=value_c %>>작성자</td>
						<td align=center width=125><%=article.getWriter() %></td>
						<td align=center width=125 bgcolor=<%=value_c %>>작성일</td>
						<td align=center width=125><%=sdf.format(article.getReg_date()) %></td>
					</tr>
					<tr height=30>
						<td align=center width=125 bgcolor=<%=value_c %>>글제목</td>
						<td align=center width=375 colspan=3><%=article.getSubject() %></td>
					</tr>
					<tr>
						<td align=center width=125 bgcolor=<%=value_c %>>글내용</td>
						<td align=center width=375 colspan=3><%=article.getContent() %></td>
					</tr>
					<tr height=30>
						<td colspan=4 bgcolor=<%=value_c %> align=right>
							<input type=button value=글수정 onclick="document.location.href='updateForm.jsp?num=<%=article.getNum()%>&pageNum=<%=pageNum%>'">&nbsp;&nbsp;&nbsp;&nbsp;
							<input type=button value=글삭제 onclick="document.location.href='deleteForm.jsp?num=<%=article.getNum()%>&pageNum=<%=pageNum%>'">&nbsp;&nbsp;&nbsp;&nbsp;
							<input type=button value=답글쓰기 onclick="document.location.href='writeForm.jsp?num=<%=num%>&ref=<%=ref%>&re_step=<%=re_step%>&re_level=<%=re_level%>'">&nbsp;&nbsp;&nbsp;&nbsp;
							<input type=button value=글목록 onclick="document.location.href='list.jsp?pageNum=<%=pageNum%>'">
						</td>
					</tr>
					</form>
					<form method=post action=contentPro.jsp >
					<tr bgcolor=<%=value_c %> align=center>
						<td>코멘트 작성</td>
						<td colspan=2>
							<textarea name=commentt rows="6" cols="40"></textarea>
							<input type=hidden name=content_num value=<%=article.getNum() %>>
							<input type=hidden name=p_num value=<%=pageNum%>>
							<input type=hidden name=comment_num value=<%=count+1%>>
						</td>
						<td align=center>
							작성자<br>
							<input type=text name=commenter size=10><br>
							비밀번호<br>
							<input type=password name=passwd size=10><p>
							<input type=submit value=코멘트달기>
						</td>
					</tr>
					</form>
				</table>
		<%if(count>0){ %>
				<p>
				<table width=500 border=0 cellspacing=0 cellpadding=0 bgcolor=<%=bodyback_c %> align=center>
					<tr>
						<td>코멘트 수: <%=comments.size() %>
					</tr>
					<%for(int i=0;i<comments.size();i++){
							CommentDataBean dbc=(CommentDataBean)comments.get(i);
					%>
						<tr>
							<td align=left size=250 bgcolor=<%=value_c %>>
							&nbsp;<b><%=dbc.getCommenter() %>&nbsp;님</b> (<%=sdf.format(dbc.getReg_date())%>)
							</td>
							<td align=right size=250 bgcolor=<%=value_c %>> 접속IP:<%=dbc.getIp() %>
							&nbsp;<a href="delCommentForm.jsp?ctn=<%=dbc.getContent_num()%>&cmn=<%=dbc.getComment_num() %>&pageNum=<%=pageNum %>" >[삭제]</a>&nbsp;
							</td>
						</tr>	
						<tr>
							<td colspan=2><%=dbc.getCommentt() %><td>
					<%} %>
						</tr>
				</table>
				<%} %>
			<%
	}catch(Exception e){}
			%>
			</div>
			</body>
</html>
