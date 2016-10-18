<%@ page contentType="text/html;charset=utf-8" %>
<%@page import="pds.service.IncreaseDownloadCountService"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="pds.service.PdsItemNotFoundException"%>
<%@page import="pds.file.FileDownloadHelper"%>
<%@page import="pds.model.PdsItem"%>
<%@page import="pds.service.GetPdsItemService"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<fmt:requestEncoding value="utf-8" />
<fmt:setLocale value="ko"/>

<%
//id 저장하고 있는 것은 number 타입 -> parseInt
int id = Integer.parseInt(request.getParameter("id") );


// 이때 id 값을 들고 간다.
PdsItem item = GetPdsItemService.getInstance().getPdsItem(id);

request.setAttribute("item", item);
request.setAttribute("id", id+"" );


%>

<html>
<head>
<title>파일 등록 Form</title>
</head>
<body>

<div class="uploadFormWrapper">
	<form action="modify.jsp?id=${id}" method="post" enctype="multipart/form-data">
	<div class="notButtonWrapper">
		<div>
			<h4> 수정될 파일 내용을 입력해시길 바랍니다. </h4>
		</div>
	</div>
	<div class="notButtonWrapper-middle">
		<div>
			<div class="info">
				<div class="circle green ilb"></div>
				파일을 새로 선택하지 않으면, 기존의 파일에서 설명만 바뀝니다.
			</div>
			파 일 : <input type="file" name="file" /> <br/>
			<div style="height:10px" ></div>
			설 명 : <input type="text" name="description" value="${item.description}"/> <br/>
		</div>
	</div>
	<div class="buttonWrapper">
		<div>
			<input type="submit" value="업로드" /> <br/>
		</div>
	</div>
	</form>
</div>
</body>
</html>

