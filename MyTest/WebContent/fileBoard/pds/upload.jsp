<%@ page contentType="text/html;charset=utf-8" %>
<%@ page import="pds.service.AddPdsItemService"%>
<%@ page import="pds.file.FileSaveHelper"%>
<%@ page import="pds.model.AddRequest"%>
<%@ page import="pds.model.PdsItem"%>
<%@ page import="java.util.Iterator"%>
<%@ page import="java.util.List"%>
<%@ page import="org.apache.commons.fileupload.FileItem"%>
<%@ page import="org.apache.commons.fileupload.disk.DiskFileItemFactory"%>
<%@ page import="org.apache.commons.fileupload.servlet.ServletFileUpload"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


<% request.setCharacterEncoding("utf-8"); %>

<%
boolean isMultipart = ServletFileUpload.isMultipartContent(request);
if(!isMultipart){
	response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
	return;
}

DiskFileItemFactory factory = new DiskFileItemFactory();
ServletFileUpload upload = new ServletFileUpload(factory);
List<FileItem> items = upload.parseRequest(request);


AddRequest addRequest = new AddRequest();

Iterator<FileItem> iter = items.iterator();
while(iter.hasNext() ){
	FileItem item = iter.next();
	if(item.isFormField() ){
		String name = item.getFieldName();
		if(name.equals("description") ){
			String value = item.getString("utf-8");
			addRequest.setDescription(value);
		}		
	} else {
		String name = item.getFieldName();
		if(name.equals("file") ){
			String realPath = FileSaveHelper.save("c:\\java\\pds", item.getInputStream() );
			addRequest.setFileName(item.getName() );
			addRequest.setFileSize(item.getSize() ); 
			addRequest.setRealPath(realPath);
		}
	}	
}

PdsItem pdsItem = AddPdsItemService.getInstance().add(addRequest);
%>
<html>
<head>
	<title>업로드 성공</title>
</head>
<body>

<div class="uploadFormWrapper">
	<form action="list.jsp" method="post" enctype="multipart/form-data">
	<div class="notButtonWrapper">
		<div>
			<h4> 업로드 성공 </h4>
		</div>
	</div>
	<div class="notButtonWrapper-middle">
		<div>
			<%=pdsItem.getFileName() %> 파일을 업로드 했습니다.
			
		</div>
	</div>
	<div class="buttonWrapper">
		<div>
			<input type="submit" value="목록보기" /> <br/>
		</div>
	</div>
	</form>
</div>

<br>
</body>


</html>
