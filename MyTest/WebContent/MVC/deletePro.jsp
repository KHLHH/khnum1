<%@ page contentType = "text/html; charset=utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<% request.setCharacterEncoding("utf-8"); %>

<c:if test="${check==1}">
<meta http-equiv="Refresh" content="0;url=/MVC_board/list.do?pageNum=${pageNum}" >
</c:if>
<c:if test="${check==0}">
비밀번호가 다릅니다.
<br>
<a href="javascript:history.go(-1)">[글삭제 폼으로 돌아가기]</a>
</c:if>