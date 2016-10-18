<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import = "board.BoardDBBean" %>
<%@ page import = "board.BoardDataBean" %>
<%@ page import = "java.util.List" %>
<%@ page import = "java.util.*" %>
<%@ page import = "java.text.SimpleDateFormat" %>
<%@ include file = "color.jsp" %>


<%@ page import = "board.MyCommentDBBean" %>
<%@ page import = "board.MyCommentDataBean" %>

<%@ page import="board.BoardDBBean" %>
<%@ page import="java.sql.Timestamp" %>
<%@ page import="java.util.*" %>


<%
int pageSize = 3; // 한 페이지에서 보여줄 글의 수
int pageBlock = 2;
SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
%>

<%
String pageNum = request.getParameter("pageNum");
String searchCategory = request.getParameter("searchCategory");
if(searchCategory == null)searchCategory="";
String searchKeyword = request.getParameter("searchKeyword");
if(searchKeyword == null)searchKeyword="";
// 현재 요펑한 페이지 수.

if (pageNum == null || pageNum.equals("null")){
	pageNum = "1";
}

int currentPage = Integer.parseInt(pageNum);
int startRow = (currentPage * pageSize ) - pageSize + 1;
int endRow = currentPage * pageSize;
int count = 0; // 전체글의 갯수를 저장을 하도록 한다.
int number = 0; // 화면상의 글 번호
List articleList = null;
BoardDBBean dbPro = BoardDBBean.getInstance();
Map searchCondition = new HashMap();
searchCondition.put("searchCategory",searchCategory);
searchCondition.put("searchKeyword",searchKeyword);

count = dbPro.listCountSearch(searchCondition);

if (count > 0 ){
	articleList = dbPro.listSearch(startRow, endRow, searchCondition);	
}

number = count - (currentPage - 1) * pageSize;

%>
<html>
<head>
<title>게시판</title>
<link href="style.css" rel="stylesheet" type="text/css">
</head>
<body bgcolor="<%=bodyback_c%>">
<div><h3>글 목록 (전체 글의 수 <%=count %>)</h3>


<%
if(count == 0){
%>
<table width="700" border="1" cellspacing="0" cellpadding="0">
<tr>
	<td align="center">
		게시판에 저장된 글이 없습니다.
	</td>
</tr>
</table>
<%	} else { %>
<table width="700" border="1" cellspacing="0" cellpadding="0" align="center">

<tr>
	<td colspan="7" align="right" style="padding:10px" bgcolor="<%=value_c %>">
		<a href="writeForm.jsp"><input type="button" value="글쓰기"></a>
	</td>
</tr>

<tr height="30" bgcolor="value_c" class="list-header" >
	<td align="center" width="50">번호</td>
	<td align="center" width="250">제 목</td>
	<td align="center" width="100">작성자</td>
	<td align="center" width="150">작성일</td>
	<td align="center" width="50">조회</td>
	<td align="center" width="100">IP</td>	
</tr>
<%
 for(int i = 0; i < articleList.size(); i++){
	 BoardDataBean article = (BoardDataBean) articleList.get(i);
%>
<tr height="30">
	<td align="center" width="50"><%= number-- %></td>
	<td width="250">

<%
	int wid=0;
	if(article.getRe_level() > 0){ // 답변 글이라면,
		wid = 10 * (article.getRe_level() );
		%>
		<img src = "images/level.gif" width="<%= wid %>" height = "16">
		<img src = "images/re.gif">
		<%
	} else { %>
		<img src = "images/level.gif" width="<%= wid %>" height = "16">
	<%
	} %>
		<a href = "content.jsp?num=<%=article.getNum() %>&pageNum=<%= currentPage %>" >
		
			<%= article.getSubject() %>
			<%
			// How much there are comment
			int num = article.getNum();
	      	MyCommentDBBean myCommentDB = MyCommentDBBean.getInstance();
	      	int commentCount =  myCommentDB.getCommentCount(num);
			%>
			<span class="bracket comment-count"> [<%=commentCount %>] </span>
			<% if(article.getReadcount() >= 20 ){ %>
			<img src="images/hot.gif" border="0" height="16">
			
		
			
			<% } %>
		</a>
	</td>
	<td align="center" width="100">
		<a href="mailto:<%= article.getEmail() %>"><%= article.getWriter() %></a>
	</td>
	
	
	<td align="center" width="150">
		<%= sdf.format(article.getReg_date() ) %>
	</td>
	
	<td align="center" width="50" >
		<%= article.getReadcount() %>
	</td>
	
	<td align="center" width="100">
		<%=article.getIp() %>
	</td>
	<%
%>
</tr>


<% }
}


%>

<tr align="center" class="list-page">
	<td colspan="7">
<%

if(count > 0){
	// 전체 페이지 수 계산
	int pageCount = count / pageSize + (count % pageSize == 0 ? 0 : 1);

	int startPage = (int) ((currentPage-1)/pageBlock)*pageBlock+1;
	int endPage = startPage + pageBlock - 1;
	
	if (endPage > pageCount ) endPage = pageCount;
	if (startPage > pageBlock){ %>
		<a href="list.jsp?pageNum=<%= startPage - pageBlock %>"> 이전 - </a>
	<%	
	}
	for (int i = startPage; i<= endPage; i++){ %>
		<a href="list.jsp?pageNum=<%= i %>">[<%= i %>]</a>
		<%
	}
	if(endPage < pageCount) { %>
		<a href="list.jsp?pageNum=<%= startPage + pageBlock %>"> - 다음 </a>
		<%
	}
	%>
<form action="list.jsp" method="get">
	<select name="searchCategory">
		<option value="writer" <% if(searchCategory.equals("writer"))out.print("selected");%> >
			 작성자 </option>
		<option value="subject" <% if(searchCategory.equals("subject"))out.print("selected");%> >
			 제 목  </option>
		<option value="content"  <% if(searchCategory.equals("content"))out.print("selected");%> >
			 내 용  </option>
	</select>
	<input type="text" name="searchKeyword" size="20" maxlength="20" 
		value="<% if(searchKeyword != null)out.print(searchKeyword);%>" >
	<input type="submit" value="검색">
</form>
	<%
	
}
%>
	</td>
</tr>
</table>

</div>
</body>
</html>
