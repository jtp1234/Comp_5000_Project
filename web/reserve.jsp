<%-- 
    Document   : reserve
    Created on : Apr 20, 2018, 4:06:20 AM
    Author     : John
--%>

<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Reserve</title>
    </head>
    <body>
        <jsp:include page="header.jsp"/>
        <%
        try {
            Class.forName("com.mysql.jdbc.Driver");
        } catch(ClassNotFoundException e) {
            e.printStackTrace();
        }
        Connection connection = null;
        try {
            String dbURL = "jdbc:mysql://localhost:3306/library_catalog";
            String username = "root";
            String password = "admin";
            connection = DriverManager.getConnection(dbURL, username, password);
        } catch(SQLException e) {
            for (Throwable t : e) {
                t.printStackTrace();
            }
        }
        Cookie[] cookies = request.getCookies();
        String cookieName = "userId";
        String cookieValue = null;
        for (Cookie cookie : cookies) {
            if (cookieName.equals(cookie.getName())) {
                cookieValue = cookie.getValue();
            }
        }
        
        if (cookieValue == null) {
            response.sendRedirect("login.jsp");
        }
        
        String userQuery = "SELECT * FROM reservations WHERE user_id = \"" + cookieValue + "\"";
        ResultSet userResult = connection.createStatement().executeQuery(userQuery);
        
        String createUser = "INSERT INTO reservations (user_id, book_id) VALUES (" + cookieValue + ", " + request.getParameter("book") + ");"; 
                            connection.createStatement().executeUpdate(createUser);
        
        response.sendRedirect("reservations.jsp");
        %>
    </body>
</html>
