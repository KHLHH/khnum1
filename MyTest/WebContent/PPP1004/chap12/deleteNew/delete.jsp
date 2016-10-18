<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.sql.DriverManager"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.ResultSet"%>
<%@ page import="java.sql.SQLException"%>
<%@ page import="java.sql.PreparedStatement"%>

<html>
<head>
<title>회원 삭제</title>
</head>
<%
request.setCharacterEncoding("utf-8");
String id = request.getParameter("memberID");
String passwd = request.getParamter("password");

Class.forName("oracle.jdbc.driver.OracleDriver");

Conn



%>
</body>
</html>
