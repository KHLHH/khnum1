<%@ page contentType = "text/html; charset=euc-kr" %>

<%@ page import = "java.sql.DriverManager" %>
<%@ page import = "java.sql.Connection" %>
<%@ page import = "java.sql.PreparedStatement" %>
<%@ page import = "java.sql.SQLException" %>
<%@ page import = "java.sql.ResultSet" %>





<head><title>삭제</title></head>



<%
request.setCharacterEncoding("utf-8");
String memberID = request.getParameter("memberID");
String password = request.getParameter("password");
int updateCount = 0;

Class.forName("oracle.jdbc.driver.OracleDriver");

Connection conn = null;
PreparedStatement pstmt = null;
ResultSet rs = null;

try {
	String jdbcDriver = "jdbc:oracle:thin:@localhost:1521:XE";
	String dbUser = "scott";
	String dbPass = "tiger";
	
	
	conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);

	pstmt = conn.prepareStatement(
			"select * from MEMBER where MEMBERID = ?");
	pstmt.setString(1, memberID);
	rs = pstmt.executeQuery();
	if(rs.next()){
		
	} else {
		%>
		<script>alert("NO ID"); history.go(-1); </script>
		<%
	}

	pstmt = conn.prepareStatement(
			"select * from MEMBER where PASSWORD = ?");
	pstmt.setString(1, password);
	rs = pstmt.executeQuery();
	if(rs.next()){
		
	} else {
		%>
		<script>alert("NO PASSWORD"); history.go(-1); </script>
		<%
	}
	
	pstmt = conn.prepareStatement(
			"delete MEMBER where MEMBERID = ? and PASSWORD = ?");
	pstmt.setString(1, memberID);
	pstmt.setString(2, password);
	
	updateCount = pstmt.executeUpdate();
	if ( updateCount == 0 ){
		out.print("MEMBERID : "+memberID+" 인 회원이 존재하지 않습니다.");
	} else {
		out.print("MEMBERID : "+memberID+" 인 회원을 삭제 완료 했습니다.");
	}
	
} catch (SQLException ex) {
	out.println(ex.getMessage());
	ex.printStackTrace();
} finally {
	try {rs.close();} catch (SQLException ex) {}
	try {pstmt.close();} catch (SQLException ex) {}
	try {conn.close();} catch (SQLException ex) {}
}

%>



