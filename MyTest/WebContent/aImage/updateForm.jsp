
[updateForm.jsp]
<%@ page contentType = "text/html; charset=euc-kr" %>
<%
    request.setCharacterEncoding("euc-kr");
%>
<jsp:forward page="template.jsp">
    <jsp:param name="CONTENTPAGE" value="../iub/updateForm_view.jsp" />
</jsp:forward>