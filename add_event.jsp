<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add Event</title>
    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet" href="css/responsive-style.css">
</head>
<body>

<%
    String eventName = request.getParameter("event_name");
    String rollNo = request.getParameter("roll_no");

    Connection conn = null;
    PreparedStatement pstmt = null;
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/Malai", "root", "tiger");
        String sql = "INSERT INTO event_details (event, roll_no) VALUES (?, ?)";
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, eventName);
        pstmt.setString(2, rollNo);
        int rowsAffected = pstmt.executeUpdate();

        if (rowsAffected > 0) {
            out.println("<h2>Event added successfully!</h2>");
        } else {
            out.println("<h2>Failed to add event!</h2>");
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

</body>
</html>
