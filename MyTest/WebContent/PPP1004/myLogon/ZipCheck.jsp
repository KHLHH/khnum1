<%@ page contentType="text/html;charset=utf-8" %>
<%@ page import="java.util.*" %>
<%@ page import="logon.*" %>

<%
request.setCharacterEncoding("utf-8");
String check = request.getParameter("check");
String area4 = request.getParameter("area4");
LogonDBBean manager = LogonDBBean.getInstance();

Vector zipcodeList = manager.zipcodeRead(area4);
int totalList = zipcodeList.size();
%>

<html>
<head><title>우편번호 검색</title></head>
<link href="style.css" rel="stylesheet" type="text/css">
<script>
function dongCheck(){
	if(document.zipForm.area4.value == ""){
		alert("동이름을 입력하세요.");
		docuement.zipForm.area4.focus();
		return;
	}
	document.zipForm.submit();
}

function sendAddress(zipcode, area1, area2, area3, area4){
	var address;
	if(area3){
		address = area1+" "+area2+" "+area3+" "+area4;
	} else {
		address = area1+" "+area2+" "+area4;
	}
	opener.document.userinput.zipcode.value=zipcode;
	opener.document.userinput.address.value=address;
	self.close();
}

</script>
<body bgcolor="#FFFFCC">

<div>
<b>우편번호 찾기</b>
<table>
<form name="zipForm" method="post" action="ZipCheck.jsp">
<tr>
	<td>
		<br>도로명 주소 입력 : <input name="area4" type="text">
		<input type="button" value="검색" onclick="dongCheck();">
	</td>
</tr>
<input type="hidden" name="check" value="n">
</form>
<%
if(check.equals("n")){
	if(zipcodeList.isEmpty() ){
		%>
		<tr><td align="center"><br>검색된 결과가 없습니다.</td></tr>
		<%
	} else {
		%>
		<tr><td align="center"><br>
		※검색 후, 아래 우편번호를 클릭하면 자동으로 입력됩니다.</td></tr>
		<%
		for(int i=0; i<totalList; i++){
			ZipcodeBean zipBean = (ZipcodeBean) zipcodeList.elementAt(i);
			String tempZipcode = zipBean.getZipcode();
			String tempArea1 = zipBean.getArea1();
			String tempArea2 = zipBean.getArea2();
			String tempArea3 = zipBean.getArea3();
			String tempArea4 = zipBean.getArea4();
			if(tempArea3 == null) tempArea3 = "";
			%>
			<tr><td><a href="javascript:sendAddress('<%=tempZipcode%>','<%=tempArea1%>','<%=tempArea2%>','<%=tempArea3%>','<%=tempArea4%>')">
			<%=tempZipcode%> <%=tempArea1%> <%=tempArea2%> <%=tempArea3%> <%=tempArea4%>
			</a></td></tr>
			<%
		}
	}
}
%>
<tr><td align="center"><br><a href="javascript:this.close();">닫기</a></td></tr>
</table>
</div>
</body>









</html>












