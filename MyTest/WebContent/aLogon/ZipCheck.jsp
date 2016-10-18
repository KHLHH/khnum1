<%@ page contentType="text/html;charset=utf-8" %>
<%@ page import="java.util.*" %>
<%@ page import="logon.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<% request.setCharacterEncoding("utf-8");%>




<html>
<head>
<title>우편번호검색</title>
<link href="style.css" rel="stylesheet" type="text/css">
<script>
	function dongCheck(){
		if (document.zipForm.area4.value == ""){
			alert("동이름을 입력하세요");
			document.zipForm.area4.focus();
			return;
		}
		document.zipForm.submit();
	}
	
function sendAddress(zipcode,area1,area2,area3,area4){
var address =area1+ " "+area2+ " " +area3+ " " +area4;
opener.document.userinput.zipcode.value=zipcode;
opener.document.userinput.address.value=address;
self.close();
	}
</script> 
</head>
<body bgcolor="#FFFFCC">


<div>
<b>우편번호 찾기</b>
<form name="zipForm" method="post" action="ZipCheck.do">
     <input type="hidden" name="check" value="n">
<table>
      <tr>
        <td><br>
          도로명 주소 입력 : <input name="area4" type="text">
          <input type="button" value="검색" onclick= "dongCheck();">
        </td>
      </tr>
     <c:choose>
	 		 <c:when test="${zipcodeList == null}">
	   			<tr><td align="center"><br>검색된 결과가 없습니다.</td></tr>
	 		 </c:when>
	 		 <c:otherwise>
				<tr>
					<td align="center"><br>
				    	※검색 후, 아래 우편번호를 클릭하면 자동으로 입력됩니다.
				    </td>
				</tr>
				
				<c:forEach var="zipBean" items="${zipcodeList}">
					<tr><td>
						<a href="javascript:sendAddress(
							'${zipBean.zipcode}','${zipBean.area1}','${zipBean.area2}',
							'${zipBean.area3}','${zipBean.area4}')">
								${zipBean.zipcode}
								&nbsp;${zipBean.area1}&nbsp;${zipBean.area2}
							    &nbsp;${zipBean.area2}&nbsp;${zipBean.area3}
								&nbsp;${zipBean.area4}
						</a><br>
					</td></tr>
				</c:forEach>
	   		 </c:otherwise>
	   </c:choose>
	<tr><td align="center"><br><a href="javascript:this.close();">닫기</a><tr></td>
</table>
</form>
</div>
</body>
</html>