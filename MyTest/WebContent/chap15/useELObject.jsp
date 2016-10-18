<%@ page contentType ="text/html;charset=utf-8" %>

<%
pageContext.setAttribute("name","aaa");
request.setAttribute("name", "su");
session.setAttribute("name","jjj");
%>
<html>
<head><title>EL Object</title></head>
<body>
${name}<br>
<%-- 같은 이름으로 속성이 여러 영역에 저장시 작은 영역에 있는 값이 출력 --%>
요청 URI : ${pageContext.request.requestURI } <br>
request의 name 속성 : ${requestScope.name} <br>
<%-- <%= request.getAttribute("name") %> --%>
code 파라미터 : ${param.code }<br>

<%-- <%= request.getParameter("code")%> --%>
${10}
#{10}


</body>
</html>




