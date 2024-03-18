<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<%
    String JDBC_URL = "jdbc:mysql://localhost:3306/Malai";
    String JDBC_USERNAME = "root";
    String JDBC_PASSWORD = "tiger";

    
    String event = request.getParameter("event");
    String rollNo = request.getParameter("roll_no");

    
    Connection conn = null;
    PreparedStatement pstmt = null;
    try {
        
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(JDBC_URL, JDBC_USERNAME, JDBC_PASSWORD);

        String sql = "INSERT INTO event_details (event, roll_no) VALUES (?, ?)";
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, event);
        pstmt.setString(2, rollNo);

        int rowsAffected = pstmt.executeUpdate();
        if (rowsAffected > 0) {
            out.println("<h2>Registration Successful!</h2>");
        } else {
            out.println("<h2>Registration Failed!</h2>");
        }
    } catch (Exception e) {
        e.printStackTrace();
        out.println("<h2>Error occurred: " + e.getMessage() + "</h2>");
    } finally {
        
        try {
            if (pstmt != null) pstmt.close();
            if (conn != null) conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
%>
