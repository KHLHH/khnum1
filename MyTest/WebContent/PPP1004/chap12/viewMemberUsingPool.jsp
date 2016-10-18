<%@ page contentType = "text/html; charset=utf-8" %>
<%@ page import = "java.sql.DriverManager" %>
<%@ page import = "java.sql.Connection" %>
<%@ page import = "java.sql.Statement" %>
<%@ page import = "java.sql.ResultSet" %>
<%@ page import = "java.sql.SQLException" %>
<html>
<head><title>회원 목록</title></head>
<body>

MEMBMER 테이블의 내용
<table width="100%" border="1">
<tr>
    <td>이름</td><td>아이디</td><td>이메일</td>
</tr>
<%
    
    Connection conn = null;
    Statement stmt = null;
    ResultSet rs = null;
    
    try {        
        String query = "select * from MEMBER order by MEMBERID";

        conn =
DriverManager.getConnection(
			"jdbc:apache:commons:dbcp:/pool");
        // 이제 풀링 드라이버에서  connection pool 가져옴
        // 그 중에 pool.jocl로 만든 커넥션 풀에서 가져온다.
        // 커넥션 풀에서 커넥션
        // 고정 경로:jocl경로
        //jdbc:apache:commons:dbcp:  /pool
        // 커넥션 풀의 url 넣어서 연결
        stmt = conn.createStatement();
        rs = stmt.executeQuery(query);
        while(rs.next()) {
%>
<tr>
    <td><%= rs.getString("NAME") %></td>
    <td><%= rs.getString("MEMBERID") %></td>
    <td><%= rs.getString("EMAIL") %></td>
</tr>
<%
        }
    } finally {
        if (rs != null) try { rs.close(); } catch(SQLException ex) {}
        if (stmt != null) try { stmt.close(); } catch(SQLException ex) {}
        if (conn != null) try { conn.close(); } catch(SQLException ex) {}
        // connectionPool에 반환한다. 이름은 같지만, 하는 일은 달라진다.
        // html 다 보내고, 화면 로딩 종료.
    }
%>
</table>


</body>
</html>
