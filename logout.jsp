
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*" %>
<%
    // Invalidate the session
    session.invalidate();
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="refresh" content="3;url=login.html">
    <title>Logging out...</title>
</head>
<body>
    <h1>Logging out...</h1>
    <p>You are being redirected to the login page.</p>
</body>
</html>
