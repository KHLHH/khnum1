<%@ page contentType = "text/html; charset=utf-8" %>

<%@ page import = "java.sql.DriverManager" %>
<%@ page import = "java.sql.Connection" %>
<%@ page import = "java.sql.Statement" %>
<%@ page import = "java.sql.PreparedStatement" %>
<%@ page import = "java.sql.SQLException" %>

<%
request.setCharacterEncoding("utf-8");
String memberID = request.getParameter("memberID");
String name = request.getParameter("name");

int updateCount = 0;
Class.forName("oracle.jdbc.driver.OracleDriver");

Connection conn = null;
PreparedStatement stmt = null;
log("####memberID : "+memberID+"####name : "+name);

try {
	String jdbcDriver = "jdbc:oracle:thin:@localhost:1521:XE";
	String dbUser = "scott";
	String dbPass = "tiger";
	
	String query = "update Member set NAME = ? where MEMBERID = ?";
	
	conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);
	stmt = conn.prepareStatement(query);
	stmt.setString(1, "newnew");
	stmt.setString(2, "id1");
	updateCount = stmt.executeUpdate();
} finally {
	if(stmt != null) try{stmt.close();}catch(SQLException ex){}
	if(conn != null) try{conn.close();}catch(SQLException ex){}
}
%>
<html>
<head><title>이름 변경</title></head>
<body>
<%
if(updateCount > 0)
	out.print(memberID+"의 이름을 "+name+"으로 변경");
else 
	out.print(memberID+"의 아이디가 존재하지 않음");

%>



</body>
</html>
