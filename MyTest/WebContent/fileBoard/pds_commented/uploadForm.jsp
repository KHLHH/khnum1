<%@ page contentType="text/html;charset=utf-8" %>
<html>
<head>
<title>파일 등록 Form</title>
</head>
<body>

<div class="uploadFormWrapper">
	<form action="upload.jsp" method="post" enctype="multipart/form-data">
	<div class="notButtonWrapper">
		<div>
			<h4> 업로드할 파일을 입력해시길 바랍니다. </h4>
		</div>
	</div>
	<div class="notButtonWrapper-middle">
		<div>
			파일 : <input type="file" name="file" /> <br/>
			<div style="height:10px" ></div>
			설명 : <input type="text" name="description" /> <br/>
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

