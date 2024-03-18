<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Registration Successful</title>
</head>
<body>

<%
    String JDBC_URL = "jdbc:mysql://localhost:3306/Malai";
    String JDBC_USERNAME = "root";
    String JDBC_PASSWORD = "tiger";

    String name = request.getParameter("name");
    String email = request.getParameter("email");
    String hallTicketNumber = request.getParameter("hallTicketNumber"); 
    String phone = request.getParameter("phone");
    String department = request.getParameter("department");
    String password = request.getParameter("password");

    Connection conn = null;
    PreparedStatement pstmt = null;
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(JDBC_URL, JDBC_USERNAME, JDBC_PASSWORD);

        String sql = "INSERT INTO users (name, email, roll_no, p_no, dept, password) VALUES (?, ?, ?, ?, ?, ?)";
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, name);
        pstmt.setString(2, email);
        pstmt.setString(3, hallTicketNumber);
        pstmt.setString(4, phone);
        pstmt.setString(5, department);
        pstmt.setString(6, password);
    

        int rowsAffected = pstmt.executeUpdate();
        if (rowsAffected > 0) {
            out.println("<h2>Registration Successful!</h2>");
            out.println("<h3><a href=\"login.html\">Click here to login</a></h3>");

        } else {
            out.println("<h2>Registration Failed!</h2>");
        }
    } catch (SQLException | ClassNotFoundException e) {
        e.printStackTrace();
        out.println("<h2>Error occurred: " + e.getMessage() + "</h2>");
    } finally {
        if (pstmt != null) {
            try {
                pstmt.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        if (conn != null) {
            try {
                conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
%>

</body>
</html>
