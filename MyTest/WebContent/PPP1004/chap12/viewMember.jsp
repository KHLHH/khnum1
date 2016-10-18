<%@ page contentType = "text/html; charset=utf-8" %>

<%@ page import = "java.sql.DriverManager" %>
<%@ page import = "java.sql.Connection" %>
<%@ page import = "java.sql.Statement" %>
<%@ page import = "java.sql.PreparedStatement" %>
<%@ page import = "java.sql.ResultSet" %>
<%@ page import = "java.sql.SQLException" %>

<%
request.setCharacterEncoding("utf-8");
//String memberID = request.getParameter("memberID");
String memberID = "id1";
%>

<html>
<head><title>회원 정보</title></head>
<%
Class.forName("oracle.jdbc.driver.OracleDriver");

Connection conn = null;
PreparedStatement stmt = null;
ResultSet rs = null;

String query = "select * from MEMBER where MEMBERID = ?";
String jdbcDriver = "jdbc:oracle:thin:@localhost:1521:XE";
String dbUser = "scott";
String dbPass = "tiger";
try {
	conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);
	stmt = conn.prepareStatement(query);
	stmt.setString(1, memberID);
	rs = stmt.executeQuery();
	
	if(rs.next() ){
		%>
<table border="1" cellspacing="0">
<tr>
<td>아이디</td><td><%= memberID %></td>
</tr>
<tr>
<td>암호</td><td><%= rs.getString("PASSWORD") %></td>
</tr>
<tr>
<td>이름</td><td><%= rs.getString("NAME") %></td>
</tr>
<tr>
<td>이메일</td><td><%= rs.getString("EMAIL")%></td>
</tr>

</table>
		<%
	} else {
		out.print(memberID+"에 해당하는 정보가 존재하지 않습니다.");
	}
} catch (SQLException ex){
	out.print("에러 발생"+ex.getMessage());
	ex.printStackTrace();
} finally {
	if(rs != null) {try{ rs.close(); } catch(SQLException ex){}  }
	if(stmt != null) {try{ stmt.close(); } catch(SQLException ex){}  }
	if(conn != null) {try{ conn.close(); } catch(SQLException ex){}  }
}

%>

</html>










