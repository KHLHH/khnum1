<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import = "java.sql.DriverManager" %>
<%@ page import = "java.sql.Connection" %>
<%@ page import = "java.sql.Statement" %>
<%@ page import = "java.sql.ResultSet" %>
<%@ page import = "java.sql.SQLException" %>

<html>
<head><title>Member List</title></head>
<body>

MEMBER table content :
<table width="100%" border="1">

<tr>
	<th>Name</th><th>ID</th><th>E-mail</th>
</tr>
<%
Class.forName("oracle.jdbc.driver.OracleDriver");
Connection conn = null;
Statement stmt = null;
ResultSet rs = null;

String query = "select * from MEMBER order by MEMBERID";

try {
	String jdbcDriver = "jdbc:oracle:thin:@localhost:1521:XE";
	String dbUser = "scott";
	String dbPass = "tiger";
	
	conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);
	stmt = conn.createStatement();
	rs = stmt.executeQuery(query);
	
	while(rs.next()){
		%>
<tr>
	<td><%= rs.getString("NAME")%></td>
	<td><%= rs.getString("MEMBERID")%></td>
	<td><%= rs.getString("EMAIL")%></td>
</tr>
		
		
		<%	
	}
	
} catch(SQLException ex){
	out.println(ex.getMessage());
	ex.printStackTrace();
} finally {
	if(rs!=null)try{rs.close();} catch(SQLException ex){}
	if(stmt!=null)try{stmt.close();} catch(SQLException ex){}
	if(conn!=null)try{conn.close();} catch(SQLException ex){}
}


%>




</table>



</body>
</html>








