<%@ page contentType = "text/html; charset=euc-kr" %>
<html>
<head><title>404 Error Occur</title>
<script src="http://code.jquery.com/jquery-1.11.3.min.js"></script>
</head>
<body>
<strong>Your requested page does not exist</strong>
<br><br>
Check your address is correct.
<button id="bb">Button Back</button>
<script>
 $(function(){
	$("#bb").on("click",function(){
		history.go(-1);
	});
 });
</script>
</body>
</html>