<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<%

    String contactJDBC_URL = "jdbc:mysql://localhost:3306/Malai";
    String contactJDBC_USERNAME = "root";
    String contactJDBC_PASSWORD = "tiger";

    String name = request.getParameter("name");
    String emailAddress = request.getParameter("emailAddress");
    String message = request.getParameter("message");

    Connection conn = null;
    PreparedStatement pstmt = null;
    try {
        
        Class.forName("com.mysql.jdbc.Driver");
        conn = DriverManager.getConnection(contactJDBC_URL, contactJDBC_USERNAME, contactJDBC_PASSWORD);

        
        String sql = "INSERT INTO contact_us (name, email, message) VALUES (?, ?, ?)";
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, name);
        pstmt.setString(2, emailAddress);
        pstmt.setString(3, message);

        int rowsAffected = pstmt.executeUpdate();
        if (rowsAffected > 0) {
            out.println("<h2>Form submission successful!</h2>");
        } else {
            out.println("<h2>Form submission failed!</h2>");
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
