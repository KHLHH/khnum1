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
// multipart/form-data 방식으로 form에서 보냈으면 true를 리턴하도록 한다.
boolean isMultipart = ServletFileUpload.isMultipartContent(request);
// 파일이 업로드가 안된 상태로 만든다. 응답 정보의 상태를 BAD_REQUEST로 만들고 끝낸다.
// 만일 uploadForm.jsp 에서 제대로 설정을 안할 경우 - 화면에 출력되는 것이 전혀 없다.
// Console 창에 보면 responded with a status 404라고 출력이 되게 된다.
if(!isMultipart){
	response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
	return;
}

// 팩토리 만들고, 이를 이용해서 서블릿파일업로드 만들고, 파라미터는 파일아이템으로 온다.
DiskFileItemFactory factory = new DiskFileItemFactory();
ServletFileUpload upload = new ServletFileUpload(factory);
// 객체는 두개가 온다. file과 description이 온다.
List<FileItem> items = upload.parseRequest(request);




/////////
// 이제 객체로 저장할 수 있는 공간이 생긴다.
AddRequest addRequest = new AddRequest();

Iterator<FileItem> iter = items.iterator();
while(iter.hasNext() ){
	FileItem item = iter.next();
	// 전송된 값이 하나라면,
	if(item.isFormField() ){
		// getFieldName 
		String name = item.getFieldName();
		if(name.equals("description") ){
			// 해당 이름으로 전송된 값을 저장을 시키고
			String value = item.getString("utf-8");
			// 빈 객체에 저장을 한다.
			addRequest.setDescription(value);
		}		
	} else {
		// 만일 파일이면 else 부분이 실행이 되게 된다.
		// file 타입의 파라미터 이름은 uploadForm.jsp 에서 name="file"
		String name = item.getFieldName();
		if(name.equals("file") ){
			// 들고 갈 경로 , 임시 디렉토리에 업로드 되있는 파일에 인풋 스트림을 연결 시키도록한다.
			// 반환 값에 의해서, 절대 경로가 온다.  
			String realPath = FileSaveHelper.save("c:\\java\\pds", item.getInputStream() );
			
			 // 이 addRequest 객체를 통해서, 나중에 DB에 업로드 된 파일의 정보를 올리도록 한다.
			 // 위에서의 Description, 밑의 파일의 이름, 경로, 사이즈, 실제 경로+파일명 등을  빈 객체에 저장을 시키도록 한다.
			addRequest.setFileName(item.getName() );
			addRequest.setFileSize(item.getSize() ); 
			addRequest.setRealPath(realPath); // 파일이 실제로 업로드된 경로까지 저장 된다.
		}
	}	
}

//이 request의 내용을 최종적으로 DB를 부르도록 한다.
// getInstance로 객체를 가져옴. - 아까 열심히 set한 빈 객체를 들고 간다.
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
