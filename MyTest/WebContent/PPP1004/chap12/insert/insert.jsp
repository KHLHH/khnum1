<%@ page contentType = "text/html; charset=euc-kr" %>

<%@ page import = "java.sql.DriverManager" %>
<%@ page import = "java.sql.Connection" %>
<%@ page import = "java.sql.PreparedStatement" %>
<%@ page import = "java.sql.SQLException" %>



<%
request.setCharacterEncoding("utf-8");
String memberID = request.getParameter("memberID");
String password = request.getParameter("password");
String name = request.getParameter("name");
String email = request.getParameter("email");

Class.forName("oracle.jdbc.driver.OracleDriver");

Connection conn = null;
PreparedStatement pstmt = null;

try {
	String jdbcDriver = "jdbc:oracle:thin:@localhost:1521:XE";
	String dbUser = "scott";
	String dbPass = "tiger";
	
	conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);
	pstmt = conn.prepareStatement(
			"insert into MEMBER values (?, ?, ?, ?)");
	pstmt.setString(1, memberID);
	pstmt.setString(2, password);
	pstmt.setString(3, name);
	pstmt.setString(4, email);
	
	pstmt.executeUpdate();
} catch (SQLException ex) {
	out.println(ex.getMessage());
	ex.printStackTrace();
}

%>


<html>
<head><title>����</title></head>
<body>

MEMBER ���̺� ���ο� ���ڵ带 �����߽��ϴ�

</body>
</html>





