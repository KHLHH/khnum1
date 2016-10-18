<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.util.List" %>
<%@ page import="java.io.*" %>
<%@ page import="org.apache.commons.fileupload.FileItem"%>
<%@ page import="org.apache.commons.fileupload.disk.DiskFileItemFactory" %>
<%@ page import="org.apache.commons.fileupload.servlet.ServletFileUpload" %>

<html>
<head><title>업로드 정보</title></head>
<body>
<%
// 1. ServletFileUpload 의 static 메서드 isMultipartContent 를 사용해서 파일인지 확인.
boolean isMultipart = ServletFileUpload.isMultipartContent(request);
if(isMultipart) {
	DiskFileItemFactory factory = new DiskFileItemFactory();
	ServletFileUpload upload = new ServletFileUpload(factory);
	List<FileItem> items = upload.parseRequest(request);
	Iterator<FileItem> iter = items.iterator();
	while(iter.hasNext() ){
		FileItem item = iter.next();
		// 파일이 아닌 경우
		if(item.isFormField() ){
			String name = item.getFieldName();
			String value = item.getString("utf-8");
			out.print("요청 파라미터 : "+name+" = "+value+"<br>");
			out.println("<br>");
		} else {
			String name = item.getFieldName();
			String fileName = item.getName();
			String contentType = item.getContentType();
			boolean isInMemory = item.isInMemory();
			long sizeInBytes = item.getSize();
			
			File file = new File("f://item/"+fileName);
			item.write(file);
			out.println("name : "+name+"<br>");
			out.println("fileName : "+fileName+"<br>");
			out.println("sizeInBytes : "+sizeInBytes+"<br>");
			out.println("contentType : "+contentType+"<br>");
			if(isInMemory){
				out.println("isInMemory : "+isInMemory+" 메모리 저장 <br>");
			} else {
				out.println("isInMemory : "+isInMemory+" 임시 파일 저장 <br>");
			}
			out.println("<br>");
		}
	}
} else {
	out.println("multipart/form 요청이 아님");
}
%>
</body>
</html>

