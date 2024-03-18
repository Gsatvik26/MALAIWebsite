<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard</title>
</head>
<body>

<h1 style="text-align: center; margin-bottom: 20px;">Welcome to Admin Dashboard</h1>

<ul style="list-style-type:none;margin:0;padding:0;">
    <li style="display:inline;margin-right:10px;"><a href="#event_table">Event Table</a></li>
    <li style="display:inline;margin-right:10px;"><a href="#contact_us">Contact Us</a></li>
    <li style="display:inline;margin-right:10px;"><a href="logout.jsp">Logout</a></li> <!-- Added logout option -->
</ul>

<hr>

<h2 id="event_table" style="margin-bottom: 10px;">Event Table</h2>
<%
    Connection conn = null;
    Statement stmt = null;
    ResultSet rs = null;
    String searchValue = request.getParameter("searchValue");
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/Malai", "root", "tiger");
        stmt = conn.createStatement();
        
        String query = "SELECT * FROM event_details";
        if (searchValue != null && !searchValue.isEmpty()) {
            query += " WHERE event LIKE '%" + searchValue + "%' OR roll_no LIKE '%" + searchValue + "%'";
        }
        query += " ORDER BY event";
        
        rs = stmt.executeQuery(query);	

    
        out.println("<form action='' method='get' style='margin-bottom: 10px;'>");
        out.println("<input type='text' name='searchValue' placeholder='Search Event Name or Roll No.' value='" + (searchValue != null ? searchValue : "") + "'>");
        out.println("<button type='submit'>Search</button>");
        out.println("</form>");
        out.println("<table style='width: 100%; border-collapse: collapse; border: 1px solid #ddd;'>");
        out.println("<tr style='background-color: #f2f2f2;'><th style='padding: 8px; text-align: left;'>Event Name</th><th style='padding: 8px; text-align: left;'>Roll Number</th><th style='padding: 8px; text-align: left;'>Action</th></tr>");
        while (rs.next()) {
            out.println("<tr><td style='padding: 8px; border: 1px solid #ddd; color: #000;'>" + rs.getString("event") + "</td>");
            out.println("<td style='padding: 8px; border: 1px solid #ddd; color: #000;'>" + rs.getString("roll_no") + "</td>");
            out.println("<td style='padding: 8px; border: 1px solid #ddd;'><a href='delete_event.jsp?event_name=" + rs.getString("event") + "&roll_no=" + rs.getString("roll_no") + "' style='text-decoration: none; color: blue;'>Delete</a></td></tr>");
        }
        out.println("</table>");
    } catch (Exception e) {
        e.printStackTrace();
        out.println("<p>Error occurred: " + e.getMessage() + "</p>");
    } finally {
        try {
            if (rs != null) rs.close();
            if (stmt != null) stmt.close();
            if (conn != null) conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
%>

<h2 id="queries" style="margin-bottom: 10px;">Queries</h2>
<hr>

<%
    try {
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/Malai", "root", "tiger");
        stmt = conn.createStatement();
        rs = stmt.executeQuery("SELECT * FROM contact_us");
        

        out.println("<table style='width: 100%; border-collapse: collapse; border: 1px solid #ddd;'>");
        out.println("<tr style='background-color: #f2f2f2;'><th style='padding: 8px; text-align: left;'>Name</th><th style='padding: 8px; text-align: left;'>Email Address</th><th style='padding: 8px; text-align: left;'>Message</th></tr>");
        while (rs.next()) {
            out.println("<tr><td style='padding: 8px; border: 1px solid #ddd; color: #000;'>" + rs.getString("name") + "</td>");
            out.println("<td style='padding: 8px; border: 1px solid #ddd; color: #000;'>" + rs.getString("email") + "</td>");
            out.println("<td style='padding: 8px; border: 1px solid #ddd;'>" + rs.getString("message") + "</td></tr>");
        }
        out.println("</table>");
    } catch (Exception e) {
        e.printStackTrace();
        out.println("<p>Error occurred: " + e.getMessage() + "</p>");
    } finally {
        try {
            if (rs != null) rs.close();
            if (stmt != null) stmt.close();
            if (conn != null) conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
%>

<hr>

</body>
</html>
