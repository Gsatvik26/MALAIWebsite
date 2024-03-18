<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login</title>
     <link rel="stylesheet" type="text/css" href="style.css">
</head>
<body>

<%
    String rollNo = request.getParameter("roll_no");
    String password = request.getParameter("password");
    String role = request.getParameter("role");
    
    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/Malai", "root", "tiger");
        
        String tableName = role.equals("Admin") ? "admin" : "users";
        String sql = "SELECT * FROM " + tableName + " WHERE roll_no = ? AND password = ?";
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, rollNo);
        pstmt.setString(2, password);
        
        rs = pstmt.executeQuery();
        if (rs.next()) {
            if (role.equals("User")) {
                response.sendRedirect("event_reg.html");
            } else if (role.equals("Admin")) {
                response.sendRedirect("admin.jsp");
            }
        } else {
            out.println("<h2>Invalid roll number or password!</h2>");
        }
    } catch (SQLException | ClassNotFoundException e) {
        e.printStackTrace();
        out.println("<h2>Error occurred: " + e.getMessage() + "</h2>");
    } finally {
        try {
            if (rs != null) rs.close();
            if (pstmt != null) pstmt.close();
            if (conn != null) conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
%>

</body>
</html>
