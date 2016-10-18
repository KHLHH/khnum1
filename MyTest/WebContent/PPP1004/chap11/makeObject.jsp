<%@ page contentType = "text/html; charset=utf-8"%>

<jsp:useBean id="member" scope="request" class="chap11.member.MemberInfo" />

<%  
member.setId("한글");
member.setName("su");
%>
<jsp:forward page="useObject.jsp" />




