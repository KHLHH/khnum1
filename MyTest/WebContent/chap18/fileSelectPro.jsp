<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@ page import="java.util.*"%>
<%@ page import="java.net.*"%>
<%@ page import="java.io.*"%>
<%@ include file="view/color.jsp"%>

<%
String realPath = "";
String savePath = "fileSave";
String type = "utf-8";
int maxSize = 5*1024*1024;

ServletContext context = getServletContext();
realPath = context.getRealPath(savePath);
ArrayList saveFiles = new ArrayList(); // 서버에 저장된 이름이 저장이 된다.
ArrayList origFiles = new ArrayList(); // 원본이름이 필요하다. -항상 실제 이름이랑 같이 저장 시켜야한다. 클라이언트는 원래 이름 모름

String user = "";
String title = "";
String content = "";

try {
	// 멀티파트리쿼스트 객체 만들면서 - 파일이 업로드가 실제로 된다.
	MultipartRequest multi = new MultipartRequest(request, realPath, maxSize, type, new DefaultFileRenamePolicy() );
	
	// 일반 파라미터는 getParameter - 멀티파트의 request 객체에서 가져옴
	user = multi.getParameter("txtUser");
	title = multi.getParameter("txtTitle");
	content = multi.getParameter("txtAbstract");
	
	// 파일 타입을 가져올려면 - 파라미터 이름들을 꺼내온다.
	// selectFile1, selectFiel2 등으로 input 태그 속성 name 에 먹인 값이 꺼내 와진다.
	Enumeration files = multi.getFileNames();
	
	while(files.hasMoreElements() ){
		String name = (String) files.nextElement();

		// name 이라는 태그 이름으로 전송된 파일 중에서
		// 서버에 저장된  파일 이름 가져옴.
		saveFiles.add(multi.getFilesystemName(name) );
		origFiles.add(multi.getOriginalFileName(name) );
		// 업로드된 파일의 정보가, 각각 List 두개에 나눠서 저장이된다.
		// 이 경우에는 index를 가지고 같은 파일인 것을 만들어야한다.
	}	
	
	// 지금까지
	// 파일 관련은 List에 넣고, 기타 작성자 등 파라미터는 String에 넣었다.
%>

<html>
<head>
<title>여러개의 파일을 업로드하는 예제</title>
<link href="style.css" rel="stylesheet" type="text/css">
</head>
<body bgcolor="<%=bodyback_c%>">
<table width="50%" border="1" align="center" cellpadding="1" cellspacing="1" >
<tr>
    <td width="15%" bgcolor="<%=value_c%>" align="center"><strong>작성자</strong></td>
    <td width="35%"><%= user %></td></tr>
<tr><td width="15%" bgcolor="<%=value_c%>" align="center"><strong>제목</strong></td>
    <td width="35%"><%= title %></td>
</tr>
<tr>
	<td width="15%" bgcolor="<%=value_c%>" align="center"><strong>내용</strong></td>
	<td width="35%" colspan="3">
		<%= content %>	
	</td>
</tr>
<tr><td colspan="4" bgcolor="<%=value_c%>">&nbsp;</td></tr>
<tr>
	<td colspan="4"><strong>업로드된 파일 리스트</strong></td>
</tr>
<%  
		for(int i=0; i<saveFiles.size(); i++){
			%>
			<tr>
				<td colspan="4">
				<%
				// y 객체에는 업로드 된 파일명을 저장하고 있다.
				String y=(String) saveFiles.get(i);
				// 업로드한 파일의 경로가 된다. 
				String x=request.getContextPath()+"/"+savePath+"/"+y;
				// 밑에는 업로드된 경로를 출력하게 한다. a 링크로
				// i+1 시켜서 1번째부터 출력이 되게 한다.
				%>
				<%=i+1%>.<a href="<%=x%>"><strong><%=origFiles.get(i)%></strong></a>
				</td>
			</tr>
			<%	
		}
%>

</table>
</body>
</html>

<%
// 연결 시킬때, 경로가 잘못될 경우 대비 -> IOException 처리
	} catch(Exception ex){
		ex.printStackTrace();
	}
%>


