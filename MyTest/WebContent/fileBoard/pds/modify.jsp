<%@ page contentType="text/html;charset=utf-8" %>
<%@ page import="pds.service.AddPdsItemService"%>
<%@ page import="pds.file.FileSaveHelper"%>
<%@ page import="pds.model.AddRequest"%>
<%@ page import="pds.model.PdsItem"%>
<%@ page import="java.util.Iterator"%>
<%@ page import="java.util.List, java.nio.file.Files, java.nio.file.Paths"%>
<%@ page import="pds.service.GetPdsItemService"%>
<%@ page import="org.apache.commons.fileupload.FileItem"%>
<%@ page import="org.apache.commons.fileupload.disk.DiskFileItemFactory"%>
<%@ page import="org.apache.commons.fileupload.servlet.ServletFileUpload"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


<% request.setCharacterEncoding("utf-8"); %>
<%
System.out.println("#########"+request.getParameter("id") );
int id = Integer.parseInt(request.getParameter("id") );



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
boolean isThereFile = false;
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
			isThereFile = true;
			String realPath = FileSaveHelper.save("c:\\java\\pds", item.getInputStream() );
			
			addRequest.setFileName(item.getName() );
			addRequest.setFileSize(item.getSize() ); 
			addRequest.setRealPath(realPath);
		}
	}	
}

boolean isUpdated = false;
if( 
	(addRequest.getFileName() != null ) && ( !addRequest.getFileName().equals("")  )
		){

	try {

		PdsItem oldFile = GetPdsItemService.getInstance().getPdsItem(id);
		String oldFileName = new String(oldFile.getRealPath().getBytes("utf-8"), "iso-8859-1" );
		System.out.println(oldFileName);
	    Files.delete(Paths.get(oldFileName));
	} catch (Exception x) {
		
	    System.err.println(x);
	}
	
	isUpdated = AddPdsItemService.getInstance().modifyNotNullFile(addRequest, id);
} else {
	isUpdated = AddPdsItemService.getInstance().modifyYesNullFile(addRequest, id);
}
%>
<html>
<head>
	<title>업로드 성공</title>
</head>
<body>
<% if(isUpdated) {
	out.println("파일을 수정 했습니다.");
} else {
	out.println("Error!!!!!");
}

%>
<br>
<a href="list.jsp">목록보기</a>
</body>


</html>
