<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<% request.setCharacterEncoding("utf-8");%>

  <body bgcolor="${bodyback_c}">
    <table>
    <tr>
	    <td bgcolor="${title_c}" >
	    	<a href="modifyForm.do">정보수정</a>
	    </td>
    </tr>
    <tr>
	    <td bgcolor="${title_c}" >
	    	<a href="deleteForm.do">탈퇴</a>
	    </td>
    </tr>
    </table>
    <p>
    </p>
  </body>
</html>